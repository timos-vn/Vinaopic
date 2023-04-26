// import 'dart:convert';
// import 'package:get/get.dart' as libGet;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vinaoptic/core/untils/const.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/models/network/request/get_list_lich_hen_request.dart';
// import 'package:vinaoptic/models/network/response/lich_hen_response.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
//
// import 'cho_tu_van_event.dart';
// import 'cho_tu_van_sate.dart';
//
// class ChoTuVanBloc extends Bloc<ChoTuVanEvent,ChoTuVanState>{
//
//
//   NetWorkFactory _networkFactory;
//   BuildContext context;
//   SharedPreferences _prefs;
//   String _accessToken;
//   String get accessToken => _accessToken;
//   String _refreshToken;
//   String get refreshToken => _refreshToken;
//   String idCustomer;
//   String unitId;
//   int _currentPage = 1;
//   int _maxPage = Const.MAX_COUNT_ITEM;
//   bool isScroll = true;
//   int get maxPage => _maxPage;
//   int get currentPage => _currentPage;
//   List<AppointmentScheduleData> _list;
//   List<AppointmentScheduleData> get list => _list;
//
//
//
//
//   ChoTuVanBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//     _currentPage = 1;
//     _list = List();
//   }
//
//   @override
//   // TODO: implement initialState
//   ChoTuVanState get initialState => CustomerInitial();
//
//   @override
//   Stream<ChoTuVanState> mapEventToState(ChoTuVanEvent event) async* {
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//       _accessToken = _prefs.getString(Const.ACCESS_TOKEN) ?? "";
//       _refreshToken = _prefs.getString(Const.REFRESH_TOKEN) ?? "";
//       idCustomer = _prefs.getString(Const.USER_ID)??"";
//       unitId = _prefs.getString(Const.UNITS_ID)??"";
//     }
//
//     if (event is GetListCustomer) {
//       bool isRefresh = event.isRefresh;
//       bool isLoadMore = event.isLoadMore;
//       yield (!isRefresh && !isLoadMore)
//           ? CustomerLoading()
//           : CustomerInitial();
//       if (isRefresh) {
//         for (int i = 1; i <= _currentPage; i++) {
//           ChoTuVanState state = await handleCallApi(i,event.dateFrom,event.dateTo);
//           if (!(state is GetListCustomerSuccess)) return;
//         }
//         return;
//       }
//       if (isLoadMore) {
//         isScroll = false;
//         _currentPage++;
//       }
//       yield await handleCallApi(_currentPage,event.dateFrom,event.dateTo);
//     }
//
//   }
//   Future<ChoTuVanState> handleCallApi(int pageIndex,String dateForm, String dateTo) async {
//     GetListAppointmentScheduleRequestBody request = new GetListAppointmentScheduleRequestBody(
//         pageIndex: pageIndex,
//         pageCount: 10,
//         userId: int.parse(idCustomer),
//         dateForm: dateForm,
//         dateTo: dateTo,
//         status: '4',units: unitId
//
//     );
//
//     ChoTuVanState state = _handleLoadList(
//         await _networkFactory.getListAppointmentSchedule(request,_accessToken), pageIndex);
//     return state;
//   }
//   ChoTuVanState _handleLoadList(Object data, int pageIndex) {
//     if (data is String) return CustomerFailure(data ?? 'Error'.tr);
//     try {
//       AppointmentSchedule response = AppointmentSchedule.fromJson(data);
//       _maxPage = 10;//response.pageIndex ?? Const.MAX_COUNT_ITEM;
//       List<AppointmentScheduleData> list = response.data;
//       print(_list.length);
//       if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
//         _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
//       } else {
//         if (_currentPage == 1)
//           _list = list;
//         else
//           _list.addAll(list);
//       }
//       if (Utils.isEmpty(_list))
//         return GetLisCustomerEmpty();
//       else
//         isScroll = true;
//       return GetListCustomerSuccess();
//     } catch (e) {
//       print(e.toString());
//       return CustomerFailure('Error'.tr);
//     }
//   }
// }
