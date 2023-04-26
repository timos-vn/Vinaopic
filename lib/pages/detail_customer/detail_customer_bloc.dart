// import 'dart:convert';
// import 'package:get/get.dart' as libGet;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vinaoptic/core/untils/const.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/models/network/request/get_list_detail_customer_request.dart';
// import 'package:vinaoptic/models/network/response/detail_customer_response.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
//
// import 'detail_customer_event.dart';
// import 'detail_customer_sate.dart';
//
//
// class GetDetailCustomerBloc extends Bloc<DetailCustomerEvent,DetailCustomerState>{
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
//
//   int _currentPage = 1;
//   int _maxPage = Const.MAX_COUNT_ITEM;
//   bool isScroll = true;
//   int get maxPage => _maxPage;
//   int get currentPage => _currentPage;
//   List<HdlHistory> _list;
//   List<HdlHistory> get list => _list;
//   MainInfo mainInfo;
//
//   GetDetailCustomerBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//     _list = List();
//   }
//
//   @override
//   // TODO: implement initialState
//   DetailCustomerState get initialState => GetDetailCustomerInitial();
//
//   @override
//   Stream<DetailCustomerState> mapEventToState(DetailCustomerEvent event) async* {
//     // TODO: implement mapEventToState
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//       _accessToken = _prefs.getString(Const.ACCESS_TOKEN) ?? "";
//       _refreshToken = _prefs.getString(Const.REFRESH_TOKEN) ?? "";
//       idCustomer = _prefs.getString(Const.USER_ID)??"";
//       unitId = _prefs.getString(Const.UNITS_ID)??"";
//     }
//
//     if (event is GetDataDetailCustomer) {
//       bool isRefresh = event.isRefresh;
//       bool isLoadMore = event.isLoadMore;
//       yield (!isRefresh && !isLoadMore)
//           ? GetDetailCustomerLoading()
//           : GetDetailCustomerInitial();
//       if (isRefresh) {
//         for (int i = 1; i <= _currentPage; i++) {
//           DetailCustomerState state = await handleCallApi(i,event.maKH,event.typeData);
//           if (!(state is GetDetailCustomerSuccess)) return;
//         }
//         return;
//       }
//       if (isLoadMore) {
//         isScroll = false;
//         _currentPage++;
//       }
//       yield await handleCallApi(_currentPage,event.maKH,event.typeData);
//     }
//   }
//
//   Future<DetailCustomerState> handleCallApi(int pageIndex,String maKH,int typeData) async {
//     ListDetailPromissoryNoteCustomerRequestBody requestBody = ListDetailPromissoryNoteCustomerRequestBody(
//         pageIndex: pageIndex,
//         pageCount: 10,
//         typeData: typeData.toString(),
//         maKh: maKH
//     );
//     DetailCustomerState state = _handleLoadList(await _networkFactory.getListDetailCustomer(requestBody,_accessToken),pageIndex);
//     return state;
//   }
//
//
//   DetailCustomerState _handleLoadList(Object data, int pageIndex) {
//     if (data is String) return GetDetailCustomerFailure(data ?? 'Error'.tr);
//     try {
//       DetailCustomerResponse response = DetailCustomerResponse.fromJson(data);
//       _maxPage = 10;
//       mainInfo = response.data.mainInfo;
//       List<HdlHistory> list = response.data.hdlHistory;
//       if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
//         _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
//       } else {
//         if (_currentPage == 1)
//           _list = list;
//         else
//           _list.addAll(list);
//       }
//       if (Utils.isEmpty(_list))
//         return GetDetailCustomerEmpty();
//       else
//         isScroll = true;
//       return GetDetailCustomerSuccess();
//     } catch (e) {
//       print(e.toString());
//       return GetDetailCustomerFailure('Error'.tr);
//     }
//   }
// }