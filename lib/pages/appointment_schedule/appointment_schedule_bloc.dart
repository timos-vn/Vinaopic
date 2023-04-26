import 'dart:convert';
import 'package:get/get.dart' as libGet;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_list_lich_hen_request.dart';
import 'package:vinaoptic/models/network/response/lich_hen_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'appointment_schedule_event.dart';
import 'appointment_schedule_state.dart';


class AppointmentScheduleBloc extends Bloc<AppointmentScheduleEvent,AppointmentScheduleState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  String unitId = '';
  String userName = '';


  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  bool isScroll = true;
  int get maxPage => _maxPage;
  int get currentPage => _currentPage;
  List<AppointmentScheduleData> _list = [];
  List<AppointmentScheduleData> get list => _list;


  AppointmentScheduleBloc(this.context) : super(AppointmentScheduleInitial()){
    _networkFactory = NetWorkFactory(context);
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);
    on<GetList>(_getList);
  }

  void _getList(GetList event, Emitter<AppointmentScheduleState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    emitter( (!isRefresh && !isLoadMore)
        ? AppointmentScheduleLoading()
        : AppointmentScheduleInitial());
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        AppointmentScheduleState state = await handleCallApi(i,event.dateFrom,event.dateTo,event.status);
        if (!(state is GetListSuccess)) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    AppointmentScheduleState state = await handleCallApi(_currentPage,event.dateFrom,event.dateTo,event.status);
    emitter(state);
  }


  Future<AppointmentScheduleState> handleCallApi(int pageIndex,String dateForm, String dateTo, String status) async {
    GetListAppointmentScheduleRequestBody request = new GetListAppointmentScheduleRequestBody(
        pageIndex: pageIndex,
        pageCount: 10,
        userId: int.parse(userID.toString()),
        dateForm: dateForm,
        dateTo: dateTo,
        status: status,
        units: unitId
    );

    AppointmentScheduleState state = _handleLoadList(
        await _networkFactory!.getListAppointmentSchedule(request,_accessToken!), pageIndex);
    return state;
  }
  AppointmentScheduleState _handleLoadList(Object data, int pageIndex) {
    if (data is String) return AppointmentScheduleFailure(data);
    try {
      AppointmentSchedule response = AppointmentSchedule.fromJson(data as Map<String,dynamic>);
      _maxPage = 20;//response.pageIndex ?? Const.MAX_COUNT_ITEM;
      List<AppointmentScheduleData> list = response.data!;
      print(_list.length);
      if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
        _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1)
          _list = list;
        else
          _list.addAll(list);
      }
      if (Utils.isEmpty(_list))
        return AppointmentScheduleEmpty();
      else
        isScroll = true;
      return GetListSuccess();
    } catch (e) {
      print(e.toString());
      return AppointmentScheduleFailure('Error'.tr);
    }
  }
}