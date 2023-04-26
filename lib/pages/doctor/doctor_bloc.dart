// import 'dart:convert';
// import 'package:get/get.dart' as libGet;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vinaoptic/core/untils/const.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/models/network/request/get_list_doctor_request.dart';
// import 'package:vinaoptic/models/network/response/list_doctor_response.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
//
// import 'doctor_event.dart';
// import 'doctor_state.dart';
//
// class DoctorBloc extends Bloc<DoctorEvent,DoctorState>{
//
//   NetWorkFactory _networkFactory;
//   SharedPreferences _prefs;
//   String _accessToken;
//   String get accessToken => _accessToken;
//   String _refreshToken;
//   String get refreshToken => _refreshToken;
//   BuildContext context;
//   String idCustomer;
//   String unitId;
//   int _currentPage = 1;
//   int _maxPage = Const.MAX_COUNT_ITEM;
//   bool isScroll = true;
//   int get maxPage => _maxPage;
//   int get currentPage => _currentPage;
//   List<ListDoctorResponseData> _list;
//   List<ListDoctorResponseData> get list => _list;
//
//   DoctorBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//     _currentPage = 1;
//     _list = List();
//   }
//
//   @override
//   // TODO: implement initialState
//   DoctorState get initialState => DoctorInitial();
//
//   @override
//   Stream<DoctorState> mapEventToState(DoctorEvent event) async* {
//     // TODO: implement mapEventToState
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//       _accessToken = _prefs.getString(Const.ACCESS_TOKEN) ?? "";
//       _refreshToken = _prefs.getString(Const.REFRESH_TOKEN) ?? "";
//       idCustomer = _prefs.getString(Const.USER_ID)??"";
//       unitId = _prefs.getString(Const.UNITS_ID)??"";
//     }
//     if (event is GetListDoctorEvent) {
//       bool isRefresh = event.isRefresh;
//       bool isLoadMore = event.isLoadMore;
//       yield (!isRefresh && !isLoadMore)
//           ? DoctorLoading()
//           : DoctorInitial();
//       if (isRefresh) {
//         for (int i = 1; i <= _currentPage; i++) {
//           DoctorState state = await handleCallApi(i);
//           if (!(state is GetListDoctorSuccess)) return;
//         }
//         return;
//       }
//       if (isLoadMore) {
//         isScroll = false;
//         _currentPage++;
//       }
//       yield await handleCallApi(_currentPage);
//     }
//
//   }
//   Future<DoctorState> handleCallApi(int pageIndex) async {
//     DoctorRequestBody request = new DoctorRequestBody(
//         pageIndex: pageIndex,
//         pageCount: 10,
//         userId: int.parse(idCustomer),
//         units: unitId ///2 Kham
//     );
//
//     DoctorState state = _handleLoadList(
//         await _networkFactory.getListDoctor(request,_accessToken), pageIndex);
//     return state;
//   }
//
//   DoctorState _handleLoadList(Object data, int pageIndex) {
//     if (data is String) return DoctorFailure(data ?? 'Error'.tr);
//     try {
//       ListDoctorResponse response = ListDoctorResponse.fromJson(data);
//       _maxPage = 10;
//       List<ListDoctorResponseData> list = response.data;
//
//       if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
//         _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
//       } else {
//         if (_currentPage == 1)
//           _list = list;
//         else
//           _list.addAll(list);
//       }
//       if (Utils.isEmpty(_list))
//         return GetLisDoctorEmpty();
//       else
//         isScroll = true;
//       return GetListDoctorSuccess();
//     } catch (e) {
//       print(e.toString());
//       return DoctorFailure('Error'.tr);
//     }
//   }
// }