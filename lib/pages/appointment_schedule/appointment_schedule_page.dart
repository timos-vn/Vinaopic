import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/pages/appointment_schedule/sua_chua/sua_chua_page.dart';

import 'cho_kham/cho_kham_page.dart';
import 'cho_tu_van/cho_tu_van_page.dart';
import 'da_hoan_thanh/da_hoan_thanh_page.dart';
import 'huy/huy_page.dart';
import 'lap/lap_page.dart';

class AppointmentSchedulePage extends StatefulWidget {
  @override
  _AppointmentSchedulePageState createState() => _AppointmentSchedulePageState();
}

class _AppointmentSchedulePageState extends State<AppointmentSchedulePage> with TickerProviderStateMixin {
  List<String> categories = [ "Lịch hẹn","Khám", "Tư vấn","Sửa chữa","Hoàn thành","Huỷ"];
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }

  Widget buildPage(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                  padding: EdgeInsets.all(4),
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.8, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: white
                  ),
                  child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: Colors.grey,
                    labelColor: white,
                    labelStyle: TextStyle(fontWeight: FontWeight.normal),
                    isScrollable: true,
                    //indicatorPadding: EdgeInsets.all(4),

                    indicator: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    tabs: List<Widget>.generate(categories.length, (int index) {
                      return new Tab(
                        text: categories[index].toString(),
                      );
                    }),
                  )),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    )
                ),
                child: TabBarView(
                    controller: tabController,
                    children: List<Widget>.generate(categories.length, (int index) {
                      for (int i = 0; i <= categories.length; i++) {
                        if (index == 0) {
                          return LapPage();
                        }else if(index  == 1){
                          return ChoKhamPage();
                        }else if(index == 2){
                          return ChoTuVanPage();
                        }else if(index == 3){
                          return FixPage();
                        }else if(index == 4){
                          return DaHoanThanhPage();
                        }else if(index == 5){
                          return HuyPage();
                        }
                      }
                      return Text('');
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
