// import 'dart:convert';
// import 'package:get/get.dart' as libGet;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
//
// import 'news_event.dart';
// import 'news_sate.dart';
//
// class NewsBloc extends Bloc<NewsEvent,NewsState>{
//
//
//   NetWorkFactory _networkFactory;
//   BuildContext context;
//
//
//   NewsBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//   }
//
//   @override
//   // TODO: implement initialState
//   NewsState get initialState => NewsInitial();
//
//   @override
//   Stream<NewsState> mapEventToState(NewsEvent event) async* {
//     // TODO: implement mapEventToState
//     // if (_prefs == null) {
//     //   _prefs = await SharedPreferences.getInstance();
//     //   _accessToken = _prefs.getString(Const.ACCESS_TOKEN) ?? "";
//     //   _refreshToken = _prefs.getString(Const.REFRESH_TOKEN) ?? "";
//     // }
//
//   }
// }