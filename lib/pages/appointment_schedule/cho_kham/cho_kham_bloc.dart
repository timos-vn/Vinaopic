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
// import 'cho_kham_event.dart';
// import 'cho_kham_sate.dart';
//
// class ChoKhamBloc extends Bloc<ChoKhamEvent,ChoKhamState>{
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
//   int _maxPage = 10;
//   bool isScroll = true;
//   int get maxPage => _maxPage;
//   int get currentPage => _currentPage;
//   List<AppointmentScheduleData> _list;
//   List<AppointmentScheduleData> get list => _list;
//
//
//   ChoKhamBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//     _currentPage = 1;
//     _list = List();
//   }
//
//   @override
//   // TODO: implement initialState
//   ChoKhamState get initialState => ChoKhamInitial();
//
//   @override
//   Stream<ChoKhamState> mapEventToState(ChoKhamEvent event) async* {
//     // TODO: implement mapEventToState
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
//           ? ChoKhamLoading()
//           : ChoKhamInitial();
//       if (isRefresh) {
//         for (int i = 1; i <= _currentPage; i++) {
//           ChoKhamState state = await handleCallApi(i,event.dateFrom,event.dateTo);
//           if (!(state is GetListChoKhamSuccess)) return;
//         }
//         return;
//       }
//       if (isLoadMore) {
//         isScroll = false;
//         _currentPage++;
//       }
//       yield await handleCallApi(_currentPage,event.dateFrom,event.dateTo);
//     }
//   }
//
//   Future<ChoKhamState> handleCallApi(int pageIndex,String dateForm, String dateTo) async {
//     GetListAppointmentScheduleRequestBody request = new GetListAppointmentScheduleRequestBody(
//         pageIndex: pageIndex,
//         pageCount: 10,
//         userId: int.parse(idCustomer),
//         dateForm: dateForm,
//         dateTo: dateTo,
//         status: '1',units: unitId
//
//     );
//
//     ChoKhamState state = _handleLoadList(
//         await _networkFactory.getListAppointmentSchedule(request,_accessToken), pageIndex);
//     return state;
//   }
//   ChoKhamState _handleLoadList(Object data, int pageIndex) {
//     if (data is String) return ChoKhamFailure(data ?? 'Error'.tr);
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
//       return GetListChoKhamSuccess();
//     } catch (e) {
//       print(e.toString());
//       return ChoKhamFailure('Error'.tr);
//     }
//   }
// }