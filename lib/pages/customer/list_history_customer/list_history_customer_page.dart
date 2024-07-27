import 'package:flutter/material.dart';
import 'package:vinaoptic/core/values/colors.dart';

import 'component/phieu_kham_page.dart';
import 'component/phieu_mua_hang.dart';
import 'component/phieu_sua_chua.dart';

class ListHistoryCustomerPage extends StatefulWidget {
  final String? maKH;
  final String? nameCustomer;
  const ListHistoryCustomerPage({Key? key, this.maKH,this.nameCustomer}) : super(key: key);
  @override
  _ListHistoryCustomerPageState createState() => _ListHistoryCustomerPageState();
}

class _ListHistoryCustomerPageState extends State<ListHistoryCustomerPage> with TickerProviderStateMixin {

  List<String> categories = [ "Phiếu khám","Mua Hàng", "Sửa chữa"];
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử khách hàng',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 10),
              child: Text('${widget.nameCustomer??""} - ${widget.maKH??''}',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.normal,fontSize: 15),),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Container(
                  padding: EdgeInsets.all(4),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.8, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: white
                  ),
                  child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: Colors.grey,
                    labelColor: white,
                    labelStyle: TextStyle(fontWeight: FontWeight.normal),
                    //isScrollable: true,
                    //indicatorPadding: EdgeInsets.all(4),

                    indicator: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    tabs: List<Widget>.generate(categories.length, (int index) {
                      return new Tab(
                        text: categories[index].toString(),
                      );
                    }),
                  )),
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Text('Danh sách',style: TextStyle(color: Colors.grey,fontSize: 12),),
                Expanded(child: Divider())
              ],
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
                          return PhieuKhamPage(maKH: widget.maKH.toString());
                        }else if(index  == 1){
                          return PhieuMuaHangPage(maKH: widget.maKH.toString());
                        }else if(index == 2){
                          return PhieuSuaChuaPage(maKH: widget.maKH.toString());
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
