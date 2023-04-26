import 'dart:convert';
import 'package:get/get.dart' as libGet;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/models/network/response/detail_history_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'detail_oder_history_event.dart';
import 'detail_order_history_sate.dart';


class DetailOrderHistoryBloc extends Bloc<DetailOrderHistoryEvent,DetailOrderHistoryState>{
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  String unitId='';

  List<DetailHistoryResponseData> _list = [];
  List<DetailHistoryResponseData> get list => _list;

  DetailOrderHistoryBloc(this.context) : super(CustomerInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<GetDataDetail>(_getDataDetail);
  }



  void _getDataDetail(GetDataDetail event, Emitter<DetailOrderHistoryState> emitter)async{
    emitter(CustomerLoading());
    DetailOrderHistoryState state = _handleLoadList(await _networkFactory!.getDetail(_accessToken!,event.sttRec));
    emitter(state);
  }


  DetailOrderHistoryState _handleLoadList(Object data) {
    if (data is String) return CustomerFailure(data);
    try {

      DetailHistoryResponse response = DetailHistoryResponse.fromJson(data as Map<String,dynamic>);
      _list = response.data!;
      return GetListCustomerSuccess();
    } catch (e) {
      print(e.toString());
      return CustomerFailure('Error'.tr);
    }
  }
}