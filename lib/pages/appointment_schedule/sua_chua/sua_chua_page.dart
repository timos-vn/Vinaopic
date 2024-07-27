import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/lich_hen_response.dart';
import 'package:vinaoptic/pages/appointment_schedule/appointment_schedule_bloc.dart';

import '../../../widget/pending_action.dart';
import '../../detail_appointment/detail_appointment_page.dart';
import '../appointment_schedule_event.dart';
import '../appointment_schedule_state.dart';




class FixPage extends StatefulWidget {
  @override
  _FixPagePageState createState() => _FixPagePageState();
}

class _FixPagePageState extends State<FixPage> {
  late ScrollController _scrollController;
  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;
  late AppointmentScheduleBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bloc = AppointmentScheduleBloc(context);
    _bloc.add(GetList(Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),status: '5'));
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _bloc.add(GetList(Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),isLoadMore: true,status: '5'));
      }
    });
  }

  List<AppointmentScheduleData> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AppointmentScheduleBloc,AppointmentScheduleState>(
            bloc: _bloc,
            listener: (context,state){
              if(state is GetListSuccess){
                _list = _bloc.list;
              }
            },
            child: BlocBuilder<AppointmentScheduleBloc,AppointmentScheduleState>(
              bloc: _bloc,
              builder: (BuildContext context, AppointmentScheduleState state){
                int length = _list.length;
                if (state is AppointmentScheduleFailure){}
                if (state is GetListSuccess){
                  _hasReachedMax = length < _bloc.currentPage * 10;
                }
                return Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
                        child: Column(
                          children: [
                            // Container(
                            //   height: 40,
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //           decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),borderRadius: BorderRadius.all(Radius.circular(16)), border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1))),
                            //           child: Row(
                            //             children: [
                            //               Icon(
                            //                 Icons.search,
                            //                 size: 25,
                            //                 color: Colors.black.withOpacity(0.5),
                            //               ),
                            //               SizedBox(width: 16,),
                            //               Expanded(
                            //                   child: Text(
                            //                     'Tìm kiếm',
                            //                     style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14,fontStyle: FontStyle.normal),
                            //                   )),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       SizedBox(width: 20,),
                            //       Icon(MdiIcons.sortVariant),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(height: 15,),
                            Expanded(
                              child: Utils.isEmpty(_list) ? Center(child: Image.asset(noData,fit: BoxFit.contain,)) : Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: ListView.separated(
                                    controller: _scrollController,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return index >= length
                                          ? Container(
                                        height: 100.0,
                                        color: white,
                                        child: PendingAction(),
                                      )
                                          : GestureDetector(
                                        onTap: () {
                                          pushNewScreen(context, screen: DetailAppointmentPage(sttRec: _list[index].sttRec.toString(),));
                                        },
                                        child: Card(
                                          color: Colors.white.withOpacity(0.9),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.all(Radius.circular(8))
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              width: double.infinity,
                                                              padding: EdgeInsets.all(10),
                                                              decoration: BoxDecoration(
                                                                  color: mainColor,
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(8),
                                                                    topLeft: Radius.circular(8),
                                                                  )
                                                              ),
                                                              child: Center(child: Text(
                                                                DateFormat('EEEE').format(DateTime.parse(_list[index].ngayCt.toString())).toString() == 'Monday' ? "Thứ 2"
                                                                    :
                                                                DateFormat('EEEE').format(DateTime.parse(_list[index].ngayCt.toString())).toString() == 'Tuesday' ? "Thứ 3"
                                                                    :
                                                                DateFormat('EEEE').format(DateTime.parse(_list[index].ngayCt.toString())).toString() == 'Wednesday' ? "Thứ 4"
                                                                    :
                                                                DateFormat('EEEE').format(DateTime.parse(_list[index].ngayCt.toString())).toString() == 'Thursday' ? "Thứ 5"
                                                                    :
                                                                DateFormat('EEEE').format(DateTime.parse(_list[index].ngayCt.toString())).toString() == 'Friday' ? "Thứ 6"
                                                                    :
                                                                DateFormat('EEEE').format(DateTime.parse(_list[index].ngayCt.toString())).toString() == 'Saturday' ? "Thứ 7"
                                                                    :
                                                                    "Chủ nhật"
                                                                ,

                                                                style: TextStyle(color: Colors.white),))),
                                                          SizedBox(height: 10,),
                                                          Text( DateFormat('yyyy-MM-dd').format(DateTime.parse(_list[index].ngayCt.toString())).split('-')[2].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                                          SizedBox(height: 10,),
                                                          Text('Tháng ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_list[index].ngayCt.toString())).split('-')[1].toString()}',style: TextStyle(color: Colors.grey)),
                                                          SizedBox(height: 10,),
                                                        ],
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 16),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(_list[index].tenKh??''),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('SĐT:'),
                                                              SizedBox(width: 4,),
                                                              Text(_list[index].dienThoai??'',style: TextStyle(color: Colors.grey,fontSize: 13),),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('Bác sĩ:'),
                                                              SizedBox(width: 4,),
                                                              Text(_list[index].tenBs??'',style: TextStyle(color: mainColor),),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                Icon(Icons.chevron_right),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) => Container(),
                                    itemCount: length == 0
                                        ? length
                                        : _hasReachedMax ? length : length + 1,),
                              ),
                            ),
                            SizedBox(height: 70,)
                          ],
                        ),
                      ),
                      // Visibility(
                      //   visible: state is GetLisCustomerEmpty,
                      //   child: Center(
                      //     child: Image.asset(noData,fit: BoxFit.contain,),
                      //   ),
                      // ),
                      Visibility(
                        visible: state is AppointmentScheduleLoading,
                        child: PendingAction(),
                      )
                    ],
                  ),
                );
              },
            )
        ));
  }

}
