import 'dart:async';
import 'package:get/get.dart' as libGetX;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/search_product_request.dart';
import 'package:vinaoptic/models/network/response/search_product_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'package:vinaoptic/pages/search_product/search_product_event.dart';
import 'package:vinaoptic/pages/search_product/search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  List<SearchProductResponseData> _searchResults = [];
  bool isScroll = true;
  bool isShowCancelButton = false;
  int _currentPage = 1;
  int _maxPage = 20;
  String _currentSearchText = '';

  int get maxPage => _maxPage;

  List<SearchProductResponseData> get searchResults => _searchResults;

  int get currentPage => _currentPage;

  SearchProductBloc(this.context) : super(InitialSearchProductState()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);

    on<SearchProduct>(_searchProduct);
    on<CheckShowCloseEvent>(_checkShowCloseEvent);
  }

  void reset() {
    _currentSearchText = "";
    _currentPage = 1;
    _searchResults.clear();
  }

  void _searchProduct(SearchProduct event, Emitter<SearchProductState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    String searchText = event.searchText;
    emitter( (!isRefresh && !isLoadMore)
        ? SearchProductLoading()
        : InitialSearchProductState());
    if (_currentSearchText != searchText) {
      _currentSearchText = searchText;
      _currentPage = 1;
      _searchResults.clear();
    }
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        SearchProductState state = await handleCallApi(searchText, i);
        if (!(state is SearchProductSuccess)) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    if (event.searchText != '') {
      if (event.searchText.length > 0) {
        SearchProductState state = await handleCallApi(searchText, _currentPage);
        emitter(state);
      } else {
        emitter(EmptySearchProductState());
      }
    } else {
      emitter(InitialSearchProductState());
      emitter(RequiredText());
    }
  }

  void _checkShowCloseEvent(CheckShowCloseEvent event, Emitter<SearchProductState> emitter)async{
    emitter(SearchProductLoading());
    isShowCancelButton = !Utils.isEmpty(event.text);
    emitter(InitialSearchProductState());
  }

  Future<SearchProductState> handleCallApi(String searchText, int pageIndex) async {

    SearchProductRequest request = new SearchProductRequest(
        pageIndex: pageIndex,
        pageCount: 20,
        keyWord: searchText,
    );

    SearchProductState state = _handleSearch(await _networkFactory!.searchProduct(request,_accessToken.toString()),pageIndex);
    return state;
  }

  SearchProductState _handleSearch(Object data, int pageIndex) {
    if (data is String) return SearchProductFailure(data);
    try {
      SearchProductResponse response = SearchProductResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 20;//response.pageIndex ?? Const.MAX_COUNT_ITEM;
      List<SearchProductResponseData> list = response.data ?? [];
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
        return SearchProductSuccess();
      } else {
        return EmptySearchProductState();
      }
    } catch (e) {
      print(e.toString());
      return SearchProductFailure('Error'.tr);
    }
  }
}
