import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as libGetX;
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_all_customer_request.dart';
import 'package:vinaoptic/models/network/response/get_all_list_customer_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent,CustomerState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  bool isScroll = true;
  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  int get maxPage => _maxPage;
  int get currentPage => _currentPage;
  List<GetAllListCustomerResponseData> listCustomer = [];

  CustomerBloc(this.context) : super(CustomerInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);


    on<GetListCustomerEvent>(_getListCustomerEvent);

  }

  void _getListCustomerEvent(GetListCustomerEvent event, Emitter<CustomerState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    bool isReload = event.isReLoad??false;
    emitter (((!isRefresh && !isLoadMore))
        ? CustomerLoading()
        : CustomerInitial());
    if(isReload == true){
      _currentPage = 1;
      CustomerState state = await handleCallApi(_currentPage);
      emitter(state);
    }
    if (isRefresh == true || isReload == true) {

      for (int i = 1; i <= _currentPage; i++) {
        CustomerState state = await handleCallApi(i);
        if (!(state is GetListCustomerSuccessful)) return;
      }
      return;
    }
    if (isLoadMore && isScroll ==true) {
      isScroll = false;
      _currentPage++;
    }
    CustomerState state =  await handleCallApi(_currentPage);
    emitter(state);
  }

  Future<CustomerState> handleCallApi(int pageIndex) async {
    GetAllListCustomerRequestBody requestBody = GetAllListCustomerRequestBody(
      pageIndex: pageIndex,
      pageCount: 20
    );
    CustomerState state = _handleGetListAllListCustomer(await _networkFactory!.getAllListCustomer(requestBody,_accessToken!),pageIndex);
    return state;
  }

  CustomerState _handleGetListAllListCustomer(Object data,int pageIndex){
    if(data is String) return CustomerFailure("Error".tr);
    try{
      GetAllListCustomerResponse response = GetAllListCustomerResponse.fromJson(data as Map<String,dynamic>);
      _maxPage =  20;
      List<GetAllListCustomerResponseData> list = response.data ?? [];
      if (!Utils.isEmpty(list) && listCustomer.length >= (pageIndex - 1) * _maxPage + list.length) {
        listCustomer.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1) {
          listCustomer = list;
        } else
          listCustomer.addAll(list);
      }
      if (Utils.isEmpty(list))
        return EmptyDataState();
      else
        isScroll = true;
        return GetListCustomerSuccessful();
    }catch(e){
      print(e.toString());
      return CustomerFailure(e.toString().tr);
    }
  }

}