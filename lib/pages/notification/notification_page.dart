
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as libGetX;
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/notification_response.dart';
import 'package:vinaoptic/widget/pending_action.dart';

import 'notification_bloc.dart';
import 'notification_event.dart';
import 'notification_sate.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  late NotificationBloc _bloc;
  late ScrollController _scrollController;
  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;
  List<NotificationDataResponse> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = NotificationBloc(context);
    // _bloc.add(GetListNotification());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _bloc.add(GetListNotification(isLoadMore: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc,NotificationState>(
      bloc: _bloc,
      listener: (context,state){
        if(state is GetListNotificationFailure){
          Utils.showCustomToast(context,Icons.warning_amber_outlined,state.error.toString());
        }
        if(state is UpdateNotificationFailure){
          Utils.showCustomToast(context,Icons.warning_amber_outlined,state.error.toString());
        }
        if(state is GetListNotificationSuccess){
          _list = _bloc.listNotification;
        }
        if(state is UpdateNotificationSuccess){
          //Utils.showToast('Successful'.tr);
        }
      },
      child: BlocBuilder<NotificationBloc,NotificationState>(
        bloc: _bloc,
        builder: (BuildContext context, NotificationState state){
          return Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              backgroundColor: mainColor,
              title: Text(
                'Notification'.tr,
                style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.white),
              ),
              leading:  Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: Icon(Icons.mark_chat_read,color: Colors.white,),
                  onPressed: () {
                    if(!Utils.isEmpty(_list)){
                      _bloc.add(UpdateAllNotificationEvent());
                      _bloc.add(GetListNotification());
                    }
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                      icon: Icon(Icons.delete_forever,color: Colors.white,),
                    onPressed: () async {
                      // if(!Utils.isEmpty(_list)){
                      //   final result = await showOkCancelAlertDialog(
                      //     context: context,
                      //     title: 'Thông báo'.tr,
                      //     message: 'AllowDeleteAll'.tr,
                      //     barrierDismissible: false,
                      //   );
                      //   if(result == OkCancelResult.ok){
                      //     _bloc.add(DeleteAllNotificationEvent());
                      //     _list.clear();
                      //   }
                      // }
                    },
                  ),
                ),
              ],
            ),
            body: buildPage(context,state),
          );
        },
      ),
    );
  }

  Widget buildPage(BuildContext context, NotificationState state) {
    int length = _list.length;
    if (state is GetListNotificationSuccess) {
      _hasReachedMax = length < _bloc.currentPage * 20;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Utils.isEmpty(_list) ? Center(child: Image.asset(noData,fit: BoxFit.contain,)) : Stack(
              children: [
                RefreshIndicator(
                  color: mainColor,
                  onRefresh: () => Future.delayed(Duration.zero).then((_) => _bloc.add(GetListNotification(isRefresh: true))),
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 5,bottom: MediaQuery.of(context).size.height * 0.1),
                    separatorBuilder: (context, index) => Container(height: 10,),
                    shrinkWrap: true,
                    itemCount: length == 0 ? length : _hasReachedMax ? length : length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= length ?
                      Container(
                        height: 100.0,
                        color: white,
                        child: PendingAction(),
                      )
                          :
                      Padding(
                        padding: const EdgeInsets.only(left: 6,right: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          child: Card(
                            borderOnForeground: true,
                            elevation: 5,
                            child: buildListTile(_list[index])
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: state is EmptyDataState,
                  child: Center(
                    child: Text('NoData'.tr),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: state is NotificationLoading,
            child: PendingAction(),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(NotificationDataResponse item) => Container(
    color: item.daDoc == true ? white : Colors.grey.withOpacity(0.3),
    child: ListTile(
      onTap: (){
        // _bloc.add(UpdateNotificationEvent(item.id));
        // _bloc.add(GetListNotification());
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.red,
        child: Icon(Icons.email_rounded,color: white,),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.tieuDe?.toString()??'',
            style: TextStyle(color: black,fontSize: 14,
                fontWeight:
                item.daDoc == true ? FontWeight.normal : FontWeight.bold),
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 4),
          Text(item.noiDung.toString(),style: TextStyle(fontSize: 12,),)
        ],
      ),
      trailing:Text(
        Utils.parseDateTToString(
            item.ngayTao.toString(),
            Const.DATE_SV,).split('T')[0].toString() + '\n' + '  '+ Utils.parseDateTToString(
          item.ngayTao.toString(),
          Const.DATE_SV,).split('T')[1].toString(),
        style: TextStyle(
            fontSize: 11.0,
            color: Colors.black,
            fontWeight: FontWeight.normal),
      ),
    ),
  );

  // void dismissSlidableItem(BuildContext context, int index, SlidableAction action,NotificationDataResponse item) {
  //   switch (action) {
  //     case SlidableAction.delete:
  //       showDialog( item,index);
  //       break;
  //   }
  // }
  //
  // void showDialog(NotificationDataResponse item,int index) async{
  //   _bloc.add(DeleteNotificationEvent(item.id));
  //   setState(() {
  //     _list.removeAt(index);
  //   });
  // }
}
