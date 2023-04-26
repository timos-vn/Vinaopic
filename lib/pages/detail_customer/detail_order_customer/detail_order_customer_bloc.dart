// import 'dart:convert';
// import 'package:get/get.dart' as libGet;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vinaoptic/core/untils/const.dart';
// import 'package:vinaoptic/models/network/response/detail_customer_response.dart';
// import 'package:vinaoptic/models/network/response/detail_order_customer_response.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
//
// import 'detail_order_customer_event.dart';
// import 'detail_order_customer_sate.dart';
//
//
// class GetDetailOrderCustomerBloc extends Bloc<DetailOrderCustomerEvent,DetailOrderCustomerState>{
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
//   List<GetDetailOrderCustomerResponseData> _list;
//   List<GetDetailOrderCustomerResponseData> get list => _list;
//   MainInfo mainInfo;
//
//   GetDetailOrderCustomerBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//     _list = List();
//   }
//
//   @override
//   // TODO: implement initialState
//   DetailOrderCustomerState get initialState => GetDetailOrderCustomerInitial();
//
//   @override
//   Stream<DetailOrderCustomerState> mapEventToState(DetailOrderCustomerEvent event) async* {
//     // TODO: implement mapEventToState
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//       _accessToken = _prefs.getString(Const.ACCESS_TOKEN) ?? "";
//       _refreshToken = _prefs.getString(Const.REFRESH_TOKEN) ?? "";
//       idCustomer = _prefs.getString(Const.USER_ID)??"";
//       unitId = _prefs.getString(Const.UNITS_ID)??"";
//     }
//
//     if (event is GetDetailOrderDetailCustomer) {
//       yield GetDetailOrderCustomerLoading();
//       DetailOrderCustomerState state = _handleLoadOrderDetail(await _networkFactory.getDetailOrderCustomer(_accessToken,event.maKH));
//       yield state;
//     }
//   }
//
//
//   DetailOrderCustomerState _handleLoadOrderDetail(Object data) {
//     if (data is String) return GetDetailOrderCustomerFailure(data ?? 'Error'.tr);
//     try {
//       GetDetailOrderCustomerResponse response = GetDetailOrderCustomerResponse.fromJson(data);
//       _list = response.data;
//       return GetDetailOrderCustomerSuccess();
//     } catch (e) {
//       print(e.toString());
//       return GetDetailOrderCustomerFailure('Error'.tr);
//     }
//   }
// }