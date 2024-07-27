import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as libGetX;
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_list_detail_customer_request.dart';
import 'package:vinaoptic/models/network/response/detail_customer_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'list_history_customer_event.dart';
import 'list_history_customer_state.dart';

class ListHistoryCustomerBloc extends Bloc<ListHistoryCustomerEvent,ListHistoryCustomerState>{

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
  List<HdlHistory> _list = [];
  List<HdlHistory> get list => _list;
  MainInfo mainInfo = MainInfo();

  ListHistoryCustomerBloc(this.context) : super(ListHistoryCustomerInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);


    on<GetListHistoryCustomerEvent>(_getListHistoryCustomerEvent);

  }

  void _getListHistoryCustomerEvent(GetListHistoryCustomerEvent event, Emitter<ListHistoryCustomerState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    emitter( (!isRefresh && !isLoadMore)
        ? ListHistoryCustomerLoading()
        : ListHistoryCustomerInitial());
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        ListHistoryCustomerState state = await handleCallApi(i,event.maKH,event.typeData);
        if (!(state is GetListHistoryCustomerSuccessful)) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    ListHistoryCustomerState state = await handleCallApi(_currentPage,event.maKH,event.typeData);
    emitter(state);
  }

  Future<ListHistoryCustomerState> handleCallApi(int pageIndex,String maKH,int typeData) async {
    ListDetailPromissoryNoteCustomerRequestBody requestBody = ListDetailPromissoryNoteCustomerRequestBody(
        pageIndex: pageIndex,
        pageCount: 10,
        typeData: typeData.toString(),
        maKh: maKH
    );
    ListHistoryCustomerState state = _handleLoadList(await _networkFactory!.getListDetailCustomer(requestBody,_accessToken!),pageIndex);
    return state;
  }


  ListHistoryCustomerState _handleLoadList(Object data, int pageIndex) {
    if (data is String) return ListHistoryCustomerFailure(data);
    try {
      DetailCustomerResponse response = DetailCustomerResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 10;
      mainInfo = response.data!.mainInfo!;
      List<HdlHistory> list = response.data!.hdlHistory!;
      if (!Utils.isEmpty(list) && _list.length >= (pageIndex - 1) * _maxPage + list.length) {
        _list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, list);
      } else {
        if (_currentPage == 1)
          _list = list;
        else
          _list.addAll(list);
      }
      if (Utils.isEmpty(_list))
        return EmptyDataState();
      else
        isScroll = true;
      return GetListHistoryCustomerSuccessful();
    } catch (e) {
      print(e.toString());
      return ListHistoryCustomerFailure('Error'.tr);
    }
  }

}