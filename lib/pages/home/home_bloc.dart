import 'package:get/get.dart' as libGet;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_list_awaiting_request.dart';
import 'package:vinaoptic/models/network/response/get_list_awaiting_customer_response.dart';
import 'package:vinaoptic/models/network/response/get_list_banner.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import '../../models/network/response/get_list_ticket_response.dart';
import 'home_event.dart';
import 'home_sate.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  bool isShowCancelButton = false;

  String unitId = '';
  String userName = '';
  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  bool isScroll = true;
  int get maxPage => _maxPage;
  int get currentPage => _currentPage;
  List<GetListAwaitingCustomerResponseData> _list = [];
  List<GetListAwaitingCustomerResponseData> get list => _list;

  List<GetListBannerResponseData> listBanner = [];

  List<ListTicket> listTicket = [];
  int totalPager = 0;


  HomeBloc(this.context) : super(HomeInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    userName = box.read(Const.USER_NAME);
    unitId = box.read(Const.UNITS_ID);

    on<GetAllListCustomerAwait>(_getAllListCustomerAwait);
    on<GetListBanner>(_getListBanner);
    on<GetTicketEvent>(_getTicketEvent);
    on<CheckShowCloseEvent>(_checkShowCloseEvent);
  }

  void _checkShowCloseEvent(CheckShowCloseEvent event, Emitter<HomeState> emitter)async{
    emitter(HomeLoading());
    isShowCancelButton = !Utils.isEmpty(event.text);
    emitter(HomeInitial());
  }

  void _getTicketEvent(GetTicketEvent event, Emitter<HomeState> emitter)async{
    emitter(HomeLoading());
    HomeState state = _handleGetListTicket(await _networkFactory!.getListTicket( _accessToken.toString(),event.dateFrom,event.dateTo,event.keySearch,event.status,event.pageIndex,20));
    emitter(state);
  }

  void _getAllListCustomerAwait(GetAllListCustomerAwait event, Emitter<HomeState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    emitter ((!isRefresh && !isLoadMore)
        ? HomeLoading()
        : HomeInitial());
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        HomeState state = await handleCallApi(i,event.dateFrom,event.dateTo);
        if (!(state is GetAllListCustomerSuccess)) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    HomeState state = await handleCallApi(_currentPage,event.dateFrom,event.dateTo);
    emitter(state);
  }

  void _getListBanner(GetListBanner event, Emitter<HomeState> emitter)async{
    emitter(HomeInitial());
    HomeState state = _handleLoadListBanner(
        await _networkFactory!.getBanner(_accessToken!));
    emitter(state);
  }

  Future<HomeState> handleCallApi(int pageIndex,String dateForm, String dateTo) async {
    GetListAwaitingCustomer request = new GetListAwaitingCustomer(
        pageIndex: pageIndex,
        pageCount: 10,
        dateForm: dateForm,
        dateTo: dateTo,
    );

    HomeState state = _handleLoadListAwaitingCustomer(
        await _networkFactory!.getListAwaitingCustomer(request,_accessToken!), pageIndex);
    return state;
  }

  HomeState _handleLoadListAwaitingCustomer(Object data, int pageIndex) {
    if (data is String) return HomeFailure(data);
    try {
      GetListAwaitingCustomerResponse response = GetListAwaitingCustomerResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 10;
      List<GetListAwaitingCustomerResponseData> list = response.data!;
      print(_list.length);
      if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
        _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1)
          _list = list;
        else
          _list.addAll(list);
      }
      if (Utils.isEmpty(_list))
        return GetLisCustomerEmpty();
      else
        isScroll = true;
      return GetAllListCustomerSuccess();
    } catch (e) {
      print(e.toString());
      return HomeFailure('Error'.tr);
    }
  }

  HomeState _handleLoadListBanner(Object data) {
    if (data is String) return HomeFailure(data );
    try {
      GetListBannerResponse response = GetListBannerResponse.fromJson(data as Map<String,dynamic>);

      listBanner = response.data!;

      return GetListBannerSuccess();
    } catch (e) {
      print(e.toString());
      return HomeFailure('Error'.tr);
    }
  }

  HomeState _handleGetListTicket(Object data) {
    if (data is String) return HomeFailure(data );
    try {
      SearchListTicketResponse response = SearchListTicketResponse.fromJson(data as Map<String,dynamic>);
      listTicket = response.listTicket!;
      totalPager = response.totalPage![0].totalRecords!;

      return GetListBannerSuccess();
    } catch (e) {
      print(e.toString());
      return HomeFailure('Error'.tr);
    }
  }
}