import 'package:get/get.dart' as libGet;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_list_order_request.dart';
import 'package:vinaoptic/models/network/response/list_order_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'cart_event.dart';
import 'cart_sate.dart';

class CartBloc extends Bloc<CartEvent,CartState>{

  String? unitId;
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();



  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  bool isScroll = true;
  int get maxPage => _maxPage;
  int get currentPage => _currentPage;
  List<OrderResponseData> _list = [];
  List<OrderResponseData> get list => _list;


  CartBloc(this.context) : super(CartInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<GetListOrderEvent>(_getListOrderEvent);

  }

  void _getListOrderEvent(GetListOrderEvent event, Emitter<CartState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    emitter((!isRefresh && !isLoadMore)
        ? CartLoading()
        : CartInitial());
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        CartState state = await handleCallApi(i,event.dateFrom,event.dateTo,event.dataType);
        if (!(state is GetListOrderSuccess)) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    CartState state = await handleCallApi(_currentPage,event.dateFrom,event.dateTo,event.dataType);
    emitter(state);
  }


  Future<CartState> handleCallApi(int pageIndex,String dateForm, String dateTo,String dataType) async {
    OrderRequestBody request = new OrderRequestBody(
        pageIndex: pageIndex,
        pageCount: 10,
        userId: int.parse(userID.toString()),
        dateForm: dateForm,
        dateTo: dateTo,
        dataType: dataType,units: unitId ///2 Kham
    );

    CartState state = _handleLoadList(
        await _networkFactory!.getListOrder(request,_accessToken.toString()), pageIndex);
    return state;
  }

  CartState _handleLoadList(Object data, int pageIndex) {
    if (data is String) return CartFailure(data);
    try {
      OrderResponse response = OrderResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 10;//response.pageIndex ?? Const.MAX_COUNT_ITEM;
      List<OrderResponseData> list = response.data!;

      if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
        _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1)
          _list = list;
        else
          _list.addAll(list);
      }
      if (Utils.isEmpty(_list))
        return GetLisOrderEmpty();
      else
        isScroll = true;
      return GetListOrderSuccess();
    } catch (e) {
      print(e.toString());
      return CartFailure('Error'.tr);
    }
  }
}