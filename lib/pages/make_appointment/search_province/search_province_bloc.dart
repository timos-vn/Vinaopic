import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_storage/get_storage.dart';

import '../../../core/untils/const.dart';
import '../../../core/untils/utils.dart';
import '../../../models/network/response/list_commune_respons.dart';
import '../../../models/network/response/list_district_response.dart';
import '../../../models/network/response/list_province_response.dart';
import '../../../models/network/service/network_factory.dart';
import 'search_province_event.dart';
import 'search_province_state.dart';


class SearchProvinceBloc extends Bloc<SearchProvinceEvent,SearchProvinceState>{
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? userName;
  String? _accessToken;
  String? get accessToken => _accessToken;
  String? _refreshToken;
  String? get refreshToken => _refreshToken;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  int _maxPage = 20;
  bool isScroll = true;
  int get maxPage => _maxPage;

  bool isShowCancelButton = false;

  List<ListProvinceResponseData> _searchResultsProvince = <ListProvinceResponseData>[];
  List<ListProvinceResponseData> searchResultsProvince = <ListProvinceResponseData>[];

  List<ListDistrictResponseData> _searchResultsDistrict = <ListDistrictResponseData>[];
  List<ListDistrictResponseData> searchResultsDistrict = <ListDistrictResponseData>[];

  List<ListCommuneResponseData> _searchResultsCommune = <ListCommuneResponseData>[];
  List<ListCommuneResponseData> searchResultsCommune = <ListCommuneResponseData>[];

  String currentAddress = '';

  SearchProvinceBloc(this.context) : super(InitialSearchProvinceState()){
    _networkFactory = NetWorkFactory(context);
    on<GetPrefsSearchProvince>(_getPrefs);
    on<GetListProvinceEvent>(_getList);
    on<CheckShowCloseEvent>(_checkShowCloseEvent);
    on<SearchProvincesEvent>(_searchValuesEvent);

    on<SearchDistrictEvent>(_searchDistrictEvent);
    on<SearchCommuneEvent>(_searchCommuneEvent);
  }

  void _checkShowCloseEvent(CheckShowCloseEvent event, Emitter<SearchProvinceState> emitter)async{
    emitter(SearchProvinceLoading());
    isShowCancelButton = !Utils.isEmpty(event.text);
    emitter(InitialSearchProvinceState());
  }
  final box = GetStorage();
  void _getPrefs(GetPrefsSearchProvince event, Emitter<SearchProvinceState> emitter)async{
    emitter(InitialSearchProvinceState());
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userName = box.read(Const.USER_NAME);
    emitter(GetPrefsSuccess());
  }

  void _getList(GetListProvinceEvent event, Emitter<SearchProvinceState> emitter)async{
    emitter(InitialSearchProvinceState());
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    emitter( (!isRefresh && !isLoadMore)
        ? SearchProvinceLoading()
        : InitialSearchProvinceState());
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        SearchProvinceState state = await handleCallApi(i,event.idProvince.toString(),event.idDistrict.toString(),event.typeGetList,event.keysText);
        if (state is! GetListProvinceSuccess) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    SearchProvinceState state = await handleCallApi(_currentPage,event.idProvince.toString(),event.idDistrict.toString(),event.typeGetList,event.keysText);
    emitter(state);
  }

  ///Province
  void _searchValuesEvent(SearchProvincesEvent event, Emitter<SearchProvinceState> emitter){
    emitter(SearchProvinceLoading());
    searchResultsProvince = getSuggestionsProvince(event.keysText);
    emitter(SearchValuesSuccess());
  }

  List<ListProvinceResponseData> getSuggestionsProvince(String query) {
    List<ListProvinceResponseData> matches = [];
    matches.addAll(_searchResultsProvince);
    matches.retainWhere((s) => s.tenTinh.toString().toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  /// District
  void _searchDistrictEvent(SearchDistrictEvent event, Emitter<SearchProvinceState> emitter){
    emitter(SearchProvinceLoading());
    searchResultsDistrict = getSuggestionsDistrict(event.keysText);
    emitter(SearchValuesSuccess());
  }

  List<ListDistrictResponseData> getSuggestionsDistrict(String query) {
    List<ListDistrictResponseData> matches = [];
    matches.addAll(_searchResultsDistrict);
    matches.retainWhere((s) => s.tenQuan.toString().toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  /// Commune
  void _searchCommuneEvent(SearchCommuneEvent event, Emitter<SearchProvinceState> emitter){
    emitter(SearchProvinceLoading());
    searchResultsCommune = getSuggestionsCommune(event.keysText);
    emitter(SearchValuesSuccess());
  }

  List<ListCommuneResponseData> getSuggestionsCommune(String query) {
    List<ListCommuneResponseData> matches = [];
    matches.addAll(_searchResultsCommune);
    matches.retainWhere((s) => s.tenPhuong.toString().toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<SearchProvinceState> handleCallApi(int pageIndex,String idProvince, String idDistrict,int typeGetList, String keysText) async {
    if(idProvince.isEmpty && idDistrict.isEmpty){
      SearchProvinceState state = _handleLoadListProvince(await _networkFactory!.getListProvince(_accessToken!,idProvince.trim(),idDistrict.trim(),pageIndex,100), pageIndex);
      return state;
    }
    else if(idProvince.isNotEmpty && idDistrict.isEmpty){
      SearchProvinceState state = _handleLoadListDistrict(await _networkFactory!.getListProvince(_accessToken!,idProvince.trim(),idDistrict.trim(),pageIndex,150), pageIndex);
      return state;
    }
    else{
      SearchProvinceState state = _handleLoadListCommune(await _networkFactory!.getListProvince(_accessToken!,idProvince.trim(),idDistrict.trim(),pageIndex,150), pageIndex);
      return state;
    }
  }

  SearchProvinceState _handleLoadListProvince(Object data, int pageIndex) {
    if (data is String) return SearchProvinceFailure('Úi, ${data.toString()}');
    try {
      ListProvinceResponse response = ListProvinceResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 20;
      List<ListProvinceResponseData> list = response.data!;
      if (!Utils.isEmpty(list) && _searchResultsProvince.length >= (pageIndex - 1) * _maxPage + list.length) {
        _searchResultsProvince.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
        searchResultsProvince.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1) {
          _searchResultsProvince = list;
          searchResultsProvince = list;
        } else {
          _searchResultsProvince.addAll(list);
          searchResultsProvince.addAll(list);
        }
      }
      if (Utils.isEmpty(_searchResultsProvince)) {
        return GetListProvinceEmpty();
      } else {
        isScroll = true;
      }
      return GetListProvinceSuccess();
    } catch (e) {
      return SearchProvinceFailure('Úi, ${e.toString()}');
    }
  }

  SearchProvinceState _handleLoadListDistrict(Object data, int pageIndex) {
    if (data is String) return SearchProvinceFailure('Úi, ${data.toString()}');
    try {
      ListDistrictResponse response = ListDistrictResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 20;
      List<ListDistrictResponseData> list = response.data!;
      if (!Utils.isEmpty(list) && _searchResultsDistrict.length >= (pageIndex - 1) * _maxPage + list.length) {
        _searchResultsDistrict.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
        searchResultsDistrict.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1) {
          _searchResultsDistrict = list;
          searchResultsDistrict = list;
        } else {
          _searchResultsDistrict.addAll(list);
          searchResultsDistrict.addAll(list);
        }
      }
      if (Utils.isEmpty(_searchResultsDistrict)) {
        return GetListProvinceEmpty();
      } else {
        isScroll = true;
      }
      return GetListProvinceSuccess();
    } catch (e) {
      return SearchProvinceFailure('Úi, ${e.toString()}');
    }
  }

  SearchProvinceState _handleLoadListCommune(Object data, int pageIndex) {
    if (data is String) return SearchProvinceFailure('Úi, ${data.toString()}');
    try {
      ListCommuneResponse response = ListCommuneResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 20;
      List<ListCommuneResponseData> list = response.data!;
      if (!Utils.isEmpty(list) && _searchResultsCommune.length >= (pageIndex - 1) * _maxPage + list.length) {
        _searchResultsCommune.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
        searchResultsCommune.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1) {
          _searchResultsCommune = list;
          searchResultsCommune = list;
        } else {
          _searchResultsCommune.addAll(list);
          searchResultsCommune.addAll(list);
        }
      }
      if (Utils.isEmpty(_searchResultsCommune)) {
        return GetListProvinceEmpty();
      } else {
        isScroll = true;
      }
      return GetListProvinceSuccess();
    } catch (e) {
      return SearchProvinceFailure('Úi, ${e.toString()}');
    }
  }
}