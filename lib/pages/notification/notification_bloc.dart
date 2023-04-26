import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as libGetX;
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/response/notification_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'notification_event.dart';
import 'notification_sate.dart';

class NotificationBloc extends Bloc<NotificationEvent,NotificationState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  List<NotificationDataResponse> listNotification = [];
  bool isScroll = true;
  int _currentPage = 1;
  int _maxPage = Const.MAX_COUNT_ITEM;
  int get maxPage => _maxPage;
  int get currentPage => _currentPage;

  NotificationBloc(this.context) : super(NotificationInitial()) {
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    // unitId = box.read(Const.UNITS_ID);

    //   on<GetCountProduct>(_getCountProduct);
    //   on<GetListCustomerAwait>(_getListCustomerAwait);
    //   on<GetListOrderEventMain>(_getListOrderEventMain);
    }


    // void _getListNotification(GetListNotification event, Emitter<NotificationState> emitter) async {
    //   bool isRefresh = event.isRefresh;
    //   bool isLoadMore = event.isLoadMore;
    //   bool? isReload = event.isReLoad;
    //   emitter(((!isRefresh && !isLoadMore))
    //       ? NotificationLoading()
    //       : NotificationInitial());
    //   if (isReload == true) {
    //     _currentPage = 1;
    //     NotificationState state = await handleCallApi(_currentPage);
    //     emitter(state);
    //   }
    //   if (isRefresh == true || isReload == true) {
    //     for (int i = 1; i <= _currentPage; i++) {
    //       NotificationState state = await handleCallApi(i);
    //       if (!(state is GetListNotificationSuccess)) return;
    //     }
    //     return;
    //   }
    //   if (isLoadMore && isScroll == true) {
    //     isScroll = false;
    //     _currentPage++;
    //   }
    //   NotificationState state = await handleCallApi(_currentPage);
    //   emitter(state);
    // }

    void _updateNotificationEvent(UpdateNotificationEvent event, Emitter<NotificationState> emitter) async {
      emitter(NotificationLoading());
      // NotificationState state = _handleUpdateNotification(await _networkFactory!.updateNotification(_accessToken,event.notificationID));
      emitter(state);
    }

    // @override
    // Stream<NotificationState> mapEventToState(NotificationEvent event)async* {
    //   // TODO: implement mapEventToState
    //
    //   if(event is GetListNotification){
    //
    //   }
    //   if(event is UpdateNotificationEvent){
    //     yield NotificationLoading();
    //     //NotificationState state = _handleUpdateNotification(await _networkFactory.updateNotification(_accessToken,event.notificationID));
    //     yield state;
    //   }
    //   if(event is DeleteNotificationEvent){
    //     yield NotificationLoading();
    //     //NotificationState state = _handleUpdateNotification(await _networkFactory.deleteNotification(_accessToken,event.notificationID));
    //     yield state;
    //   }
    //   if(event is UpdateAllNotificationEvent){
    //     yield NotificationLoading();
    //     //NotificationState state = _handleUpdateNotification(await _networkFactory.updateAllNotification(_accessToken));
    //     yield state;
    //   }else if(event is DeleteAllNotificationEvent){
    //     yield NotificationLoading();
    //     //NotificationState state = _handleUpdateNotification(await _networkFactory.deleteAllNotification(_accessToken));
    //     yield state;
    //   }
    // }

    NotificationState _handleUpdateNotification(Object data) {
      if (data is String) return UpdateNotificationFailure("Error".tr);
      try {
        return UpdateNotificationSuccess();
      }
      catch (e) {
        return UpdateNotificationFailure(e
            .toString()
            .tr);
      }
    }

    // Future<NotificationState> handleCallApi(int pageIndex) async {
      // NotificationState state = _handleGetListNotification(await _networkFactory!.getListNotification(_accessToken,pageIndex,20),pageIndex);
      // return state;
    // }

    // NotificationState _handleGetListNotification(Object data,int pageIndex){
    //   if(data is String) return GetListNotificationFailure("Error".tr);
    //   try{
    //     NotificationResponse response = NotificationResponse.fromJson(data);
    //     _maxPage =  20;//Const.MAX_COUNT_ITEM
    //     List<NotificationDataResponse> list = response.data ?? List();
    //     if (!Utils.isEmpty(list) && listNotification.length >= (pageIndex - 1) * _maxPage + list.length) {
    //       listNotification.replaceRange((pageIndex - 1) * maxPage, list.length < _maxPage ? (pageIndex * list.length) : (pageIndex * maxPage), list);
    //     } else {
    //       if (_currentPage == 1) {
    //         listNotification = list;
    //       } else
    //         listNotification.addAll(list);
    //     }
    //     if (Utils.isEmpty(list))
    //       return EmptyDataState();
    //     else
    //       isScroll = true;
    //       return GetListNotificationSuccess();
    //   }catch(e){
    //     print(e.toString());
    //     return GetListNotificationFailure(e.toString().tr);
    //   }
    // }
}
