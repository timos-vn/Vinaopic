import 'package:get/get.dart' as libGetX;
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/get_list_awaiting_request.dart';
import 'package:vinaoptic/models/network/request/get_list_order_request.dart';
import 'package:vinaoptic/models/network/response/get_list_awaiting_customer_response.dart';
import 'package:vinaoptic/models/network/response/list_order_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();


 // FirebaseMessaging _firebaseMessaging;
  int countNotifyUnRead = 0;
  String _deviceToken = '';
  int countApproval = 0;

  String unitId = '';
  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  bool isScroll = true;
  int get maxPage => _maxPage;
  int get currentPage => _currentPage;
  List<OrderResponseData> list = [];
  List<GetListAwaitingCustomerResponseData> listAwaitingCustomer = [];

  init(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
  }

  void setCountAfterRead() {
    countNotifyUnRead = countNotifyUnRead <= 0 ? 0 : countNotifyUnRead - 1;
  }

  Future<void> updateCount(int count) async {
    countApproval = countApproval - count;
  }

  MainBloc(this.context) : super(InitialMainState()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<GetCountProduct>(_getCountProduct);
    on<GetListCustomerAwait>(_getListCustomerAwait);
    on<GetListOrderEventMain>(_getListOrderEventMain);
  }

  // void _registerNotification() {
  //   if (Platform.isIOS) getIosPermission();
  //   _firebaseMessaging.configure(
  //     // ignore: missing_return
  //     onMessage: (Map<String, dynamic> message) {
  //       try {
  //         if(Platform.isAndroid){
  //           String title = message['notification']['title'];
  //           String body = message['notification']['body'];
  //           Utils.showForegroundNotification(context, title, body, onTapNotification: () {
  //             add(NavigateToNotification());
  //           });
  //         }else if(Platform.isIOS){
  //           String title = message['notification']['title'];
  //           String body = message['notification']['body'];
  //           // print(title);
  //           // print(body);
  //           // NotificationData data = NotificationData.fromJson(json.decode(
  //           //     Platform.isAndroid
  //           //         ? message['data']['payload']
  //           //         : message['payload']));
  //           Utils.showForegroundNotification(context, title, body, onTapNotification: () {
  //             add(NavigateToNotification());
  //           });
  //         }
  //         FlutterRingtonePlayer.play(
  //           android: AndroidSounds.notification,
  //           ios: IosSounds.triTone,
  //         );
  //         add(GetCountNoti());
  //         // add(GetCountNotiSMS());
  //       } catch (e) {
  //         logger.e(e.toString());
  //       }
  //     },
  //     // ignore: missing_return
  //     onResume: (Map<String, dynamic> message) {
  //       logger.d('on resume $message');
  //       add(NavigateToNotification());
  //     },
  //     // ignore: missing_return
  //     onLaunch: (Map<String, dynamic> message) {
  //       logger.d('on launch $message');
  //       add(NavigateToNotification());
  //     },
  //   );
  //   _firebaseMessaging.subscribeToTopic(Const.TOPIC);
  // }
  //
  // void getIosPermission() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     logger.d("Settings registered: $settings");
  //   });
  // }

  void _getCountProduct(GetCountProduct event, Emitter<MainState> emitter)async{
    emitter(InitializeDb());
    await updateCount(event.count);
    emitter(GetCountNotiSuccess());
  }

  void _getListCustomerAwait(GetListCustomerAwait event, Emitter<MainState> emitter)async{
    emitter(MainLoading());
    GetListAwaitingCustomer request = new GetListAwaitingCustomer(
      pageIndex: 1,
      pageCount: 10,
      dateForm: null,//dateForm,
      dateTo: null,//dateTo,
    );

    MainState state = _handleLoadListAwaitingCustomer(
        await _networkFactory!.getListAwaitingCustomer(request,_accessToken!));
    emitter(state);
  }

  void _getListOrderEventMain(GetListOrderEventMain event, Emitter<MainState> emitter)async{
    bool isRefresh = event.isRefresh;
    bool isLoadMore = event.isLoadMore;
    emitter((!isRefresh && !isLoadMore)
        ? MainLoading()
        : InitialMainState());
    if (isRefresh) {
      for (int i = 1; i <= _currentPage; i++) {
        MainState state = await handleCallApi(i,event.dateFrom,event.dateTo,event.dataType);
        if (!(state is GetListOrderSuccess)) return;
      }
      return;
    }
    if (isLoadMore) {
      isScroll = false;
      _currentPage++;
    }
    MainState state = await handleCallApi(_currentPage,event.dateFrom,event.dateTo,event.dataType);
    emitter(state);
  }

  void handleTypeNotification(String type) {
    switch (type) {
      default:
        add(NavigateProfile());
    }
  }


  MainState _handleLoadListAwaitingCustomer(Object data) {
    if (data is String) return MainFailure(data);
    try {
      GetListAwaitingCustomerResponse response = GetListAwaitingCustomerResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 10;
      listAwaitingCustomer = response.data!;
      print(listAwaitingCustomer.length);
      return GetListCustomerSuccess();
    } catch (e) {
      return MainFailure('Error'.tr);
    }
  }

  Future<MainState> handleCallApi(int pageIndex,String dateForm, String dateTo,String dataType) async {
    OrderRequestBody request = new OrderRequestBody(
        pageIndex: pageIndex,
        pageCount: 10,
        userId: int.parse(userID.toString()),
        dateForm: dateForm,
        dateTo: dateTo,
        dataType: dataType,units: unitId ///2 Kham
    );

    MainState state = _handleLoadList(
        await _networkFactory!.getListOrder(request,_accessToken!), pageIndex);
    return state;
  }

  MainState _handleLoadList(Object data, int pageIndex) {
    if (data is String) return MainFailure(data );
    try {
      OrderResponse response = OrderResponse.fromJson(data as Map<String,dynamic>);
      _maxPage = 10;//response.pageIndex ?? Const.MAX_COUNT_ITEM;
      List<OrderResponseData> listResponse = response.data!;

      if (!Utils.isEmpty(listResponse) && list.length >= (pageIndex - 1) * _maxPage + listResponse.length) {
        list.replaceRange((pageIndex - 1) * maxPage, pageIndex * maxPage, listResponse);
      } else {
        if (_currentPage == 1)
          list = listResponse;
        else
          list.addAll(listResponse);
      }
      if (Utils.isEmpty(list))
        return GetLisOrderEmpty();
      else
        isScroll = true;
      return GetListOrderSuccess();
    } catch (e) {
      print(e.toString());
      return MainFailure('Error'.tr);
    }
  }
}
