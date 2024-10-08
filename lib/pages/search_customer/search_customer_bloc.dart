import 'dart:async';
import 'package:get/get.dart' as libGetX;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_customer_history.dart';
import 'package:vinaoptic/models/network/response/search_customer_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'package:vinaoptic/pages/search_customer/search_customer_event.dart';
import 'package:vinaoptic/pages/search_customer/search_customer_state.dart';

class SearchCustomerBloc extends Bloc<SearchCustomerEvent, SearchCustomerState> {
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  List<SearchCustomerResponseData> _searchResults = [];
  bool isScroll = true;
  bool isShowCancelButton = false;
  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  String _currentSearchText = '';

  int get maxPage => _maxPage;

  List<SearchCustomerResponseData> get searchResults => _searchResults;
  int totalPager = 0;
  int get currentPage => _currentPage;

  SearchCustomerBloc(this.context) : super(InitialSearchState()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);

    on<SearchCustomer>(_searchCustomer);
    on<CheckShowCloseEvent>(_checkShowCloseEvent);
  }

  void _searchCustomer(SearchCustomer event, Emitter<SearchCustomerState> emitter)async{
    emitter(SearchLoading());
    SearchCustomerRequestBody request = new SearchCustomerRequestBody(
        pageCount: 10,
        keyWord: event.searchValues,
        pageIndex: event.pageIndex);
    SearchCustomerState state = _handleSearch(await _networkFactory!.searchCustomer(request,_accessToken!), event.pageIndex);
    emitter(state);
  }

  void _checkShowCloseEvent(CheckShowCloseEvent event, Emitter<SearchCustomerState> emitter)async{
    emitter(SearchLoading());
    isShowCancelButton = !Utils.isEmpty(event.text);
    emitter(InitialSearchState());
  }


  void reset() {
    _currentSearchText = "";
    _currentPage = 1;
    _searchResults.clear();
  }

  Future<SearchCustomerState> handleCallApi(String searchText, int pageIndex) async {
    print(_accessToken);

    return state;
  }

  SearchCustomerState _handleSearch(Object data, int pageIndex) {
    if (data is String) return SearchFailure(data);
    try {

      SearchCustomerResponse response = SearchCustomerResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 20;
      List<SearchCustomerResponseData> list = response.data ?? [];
      totalPager = response.totalCount!;
      if (!Utils.isEmpty(list) && _searchResults.length >= (pageIndex - 1) * _maxPage + list.length) {
        _searchResults.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list); /// delete list cũ -> add data mới vào list đó.
        var xpe = _searchResults.toList();
        print(xpe);
      } else {
        if (_currentPage == 1) {
          _searchResults = list;
        } else
          _searchResults.addAll(list);
      }
      if (_searchResults.length > 0) {
        isScroll = true;
        return SearchSuccess();
      } else {
        return EmptySearchState();
      }
    } catch (e) {
      print(e.toString());
      return SearchFailure('Error'.tr);
    }
  }
}
