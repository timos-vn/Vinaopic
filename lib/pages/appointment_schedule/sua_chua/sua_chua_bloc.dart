// import 'dart:convert';
// import 'package:get/get.dart' as libGet;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vinaoptic/core/untils/const.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/models/network/request/get_list_lich_hen_request.dart';
// import 'package:vinaoptic/models/network/response/lich_hen_response.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
//
// import 'sua_chua_event.dart';
// import 'sua_chua_sate.dart';
//
// class SuaChuaBloc extends Bloc<SuaChuaEvent,SuaChuaState>{
//
//   String? userID;
//   NetWorkFactory? _networkFactory;
//   BuildContext context;
//   String? _accessToken;
//   String? _refreshToken;
//
//   final box = GetStorage();
//
//   String unitId = '';
//   String userName = '';
//
//
//   int _currentPage = 1;
//   int _maxPage = Const.MAX_COUNT_ITEM;
//   bool isScroll = true;
//   int get maxPage => _maxPage;
//   int get currentPage => _currentPage;
//   List<AppointmentScheduleData> _list;
//   List<AppointmentScheduleData> get list => _list;
//
//
//   SuaChuaBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//     _currentPage = 1;
//     _list = List();
//   }
//
//   @override
//   // TODO: implement initialState
//   SuaChuaState get initialState => CustomerInitial();
//
//   @override
//   Stream<SuaChuaState> mapEventToState(SuaChuaEvent event) async* {
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
//           ? CustomerLoading()
//           : CustomerInitial();
//       if (isRefresh) {
//         for (int i = 1; i <= _currentPage; i++) {
//           SuaChuaState state = await handleCallApi(i,event.dateFrom,event.dateTo);
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
//   }
//
//   Future<SuaChuaState> handleCallApi(int pageIndex,String dateForm, String dateTo) async {
//     GetListAppointmentScheduleRequestBody request = new GetListAppointmentScheduleRequestBody(
//         pageIndex: pageIndex,
//         pageCount: 10,
//         userId: int.parse(idCustomer),
//         dateForm: dateForm,
//         dateTo: dateTo,
//         status: '5',units: unitId
//
//     );
//
//     SuaChuaState state = _handleLoadList(
//         await _networkFactory.getListAppointmentSchedule(request,_accessToken), pageIndex);
//     return state;
//   }
//   SuaChuaState _handleLoadList(Object data, int pageIndex) {
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