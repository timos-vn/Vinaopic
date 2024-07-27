import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/widget/pending_action.dart';
import 'detail_oder_history_event.dart';
import 'detail_order_history_bloc.dart';
import 'detail_order_history_sate.dart';

class DetailHistoryPage extends StatefulWidget {
  final String? sttRec;
  final String? nameCustomer;
  final String? maKH;
  final String? date;
  final String? bacsy;

  const DetailHistoryPage({Key? key, this.sttRec,this.nameCustomer,this.maKH,this.date,this.bacsy}) : super(key: key);
  @override
  _DetailHistoryPageState createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> with TickerProviderStateMixin {
  List<String> categories = ["Kết quả", "LS Sửa chữa"];
  late TabController tabController;

  late DetailOrderHistoryBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: categories.length);
    _bloc = DetailOrderHistoryBloc(context);
    _bloc.add(GetDataDetail(widget.sttRec.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailOrderHistoryBloc,DetailOrderHistoryState>(
      bloc: _bloc,
      listener: (context,state){
      },
      child: BlocBuilder<DetailOrderHistoryBloc,DetailOrderHistoryState>(
        bloc: _bloc,
        builder: (BuildContext context, DetailOrderHistoryState state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Lịch sử hoạt động',style: TextStyle(color: Colors.black),),
              centerTitle: true,
            ),
            body: buildPage(context, state),
          );
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,DetailOrderHistoryState state){
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25,bottom: 10),
                child: Text('${widget.nameCustomer??""} - ${widget.maKH??''}',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.normal,fontSize: 15),),
              ),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 0),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    //Text('Danh sách đơn mua hàng',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                  ),
                  child: TabBarView(
                      controller: tabController,
                      children: List<Widget>.generate(categories.length, (int index) {
                        if (index == 0) {
                          return Utils.isEmpty(_bloc.list) ? Container() : buildPageReport(context, categories, index);
                        }else //if (index == 1)
                        {
                          return buildPageFix(context, categories, index);
                        }
                        // else {
                        //   return DetailCustomerPage(maKH: widget.maKH,typeView: false,);
                        // }
                      })),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: state is CustomerLoading,
          child: PendingAction(),
        ),
      ],
    );
  }

  Widget buildPageReport(BuildContext context,  List<String>  detailDataReport, int i) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text('Thông số về: Chỉnh quang',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:  Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cầu'),
                            Text('(SPH)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trụ'),
                            Text('(CYL)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trục'),
                            Text('(AX)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cộng'),
                            Text('(ADD)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('TL'),
                            Text('(VA)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpCong?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTl?.toString()??'')),
                      ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtCong?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTl?.toString()??'')),
                      ),
                    ]),
                  ]
              ),
              SizedBox(height: 10,),
              Text('Thông số về: Nhược thị',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cầu'),
                            Text('(SPH)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:Column(
                          children: [
                            Text('Trụ'),
                            Text('(CLY)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trục'),
                            Text('(AX)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cộng'),
                            Text('(ADD)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Đế'),
                            Text('(BASE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Center(child: Text('Thị lực')),
                      // ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpCong?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTl?.toString()??'')),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(child: Text(_bloc.list[0].cqMpTl?.toString()??'')),
                      // ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtCong?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTl?.toString()??'')),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(child: Text(_bloc.list[0].cqMtTl?.toString()??'')),
                      // ),
                    ]),
                  ]
              ),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('TL'),
                            Text('(VA)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),

                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMpTl?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      )
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].cqMtTl?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      )
                    ]),
                  ]
              ),
              SizedBox(height: 10,),
              Text('Thông số về: Áp tròng',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cầu'),
                            Text('(SPH)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trụ'),
                            Text('(CYL)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trụ'),
                            Text('(AX)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('BC'),
                            Text('',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('DIA'),
                            Text('',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Center(child: Text('Thị lực')),
                      // ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMpCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMpTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMpTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMpBc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMpDia?.toString()??'')),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(child: Text(_bloc.list[0].cqMpTl?.toString()??'')),
                      // ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMtCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMtTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMtTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMtBc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMtDia?.toString()??'')),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(child: Text(_bloc.list[0].cqMtTl?.toString()??'')),
                      // ),
                    ]),
                  ]
              ),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('TL'),
                            Text('(VA)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),

                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMpTl?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      )
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].atMtTl?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      )
                    ]),
                  ]
              ),
              SizedBox(height: 10,),
              Text('Thông số về: Lăng kính',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cầu'),
                            Text('(SPH)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trụ'),
                            Text('(CYL)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Trục'),
                            Text('(AX)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Cộng'),
                            Text('(ADD)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('TL'),
                            Text('(VA)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Center(child: Text('Thị lực')),
                      // ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpCong?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpTl?.toString()??'')),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(child: Text(_bloc.list[0].cqMpTl?.toString()??'')),
                      // ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtCau?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtTru?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtTruc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtCong?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtTl?.toString()??'')),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(child: Text(_bloc.list[0].cqMtTl?.toString()??'')),
                      // ),
                    ]),
                  ]
              ),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Mắt'),
                            Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('Ngang'),
                            Text('',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Đáy'),
                            Text('ngang',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Dọc'),
                            Text('',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('Đáy'),
                            Text('(dọc)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text('')),
                      ),

                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpNgang?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpDay1?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpDoc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMpDay2?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      )
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtNgang?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtDay1?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtDoc?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_bloc.list[0].lkMtDay2?.toString()??'')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('')),
                      )
                    ]),
                  ]
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(child: Text('Ngày khám')),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(child: Text(widget.date != null? DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date.toString())): '')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(child: Text('Bác sỹ')),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(child: Text(widget.bacsy?.toString()??"")),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(child: Text('Kết luận')),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Center(child: Text('Thay kính')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 70,),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildPageFix(BuildContext context,  List<String>  detailDataReport, int i) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Thông tin giao dịch: #31072021',style: TextStyle(color: Colors.blue),),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.edit,size: 20,),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        height: 35,
                        child: Center(child: Text(' Tên kính  ')),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          height: 35,
                          // width: 32,
                          child: Center(child: Text(DateFormat("----").format(DateTime.now()).toString())),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Kiểu loại')),
                      ),
                      Container(
                        height: 35,
                        child: Center(child: Text("----")),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Chất liệu')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text( "----",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('Tình trạng & Yêu cầu',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                border: TableBorder.all(color: Colors.grey),

                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        height: 35,
                        child: Center(child: Text('Tình trạng')),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          height: 35,
                          // width: 32,
                          child: Center(child: Text(DateFormat("----").format(DateTime.now()).toString())),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Yêu cầu')),
                      ),
                      Container(
                        height: 35,
                        child: Center(child: Text("----")),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('NV sửa chữa')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text( "----",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('NV tư vấn')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text("----",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageBuy(BuildContext context,  List<String>  detailDataReport, int i) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text('Thông tin giao dịch: #01082021',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                  5: FlexColumnWidth(),
                  6: FlexColumnWidth(),

                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        width: 80,
                        child: Center(child: Text('Kính',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        //border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
                        columnWidths: {
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                          3: FlexColumnWidth(),
                          4: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  width: 60,
                                  child: Center(child: Text('Tên kính')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text( "G20s",style: TextStyle(fontSize: 12),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Kiểu loại')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("USA",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Chất liệu')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("Titan",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Màu sắc')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("Bạch kim",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Xuất sứ')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("Việt nam",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Gọng',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),

                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        //border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
                        columnWidths: {
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  width: 60,
                                  child: Center(child: Text('Tên')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text( "Gọng GK36",style: TextStyle(fontSize: 12),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Giá')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("2 tỷ",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Mô tả')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Khăn',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        //border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
                        columnWidths: {
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  width: 60,
                                  child: Center(child: Text('Tên')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text( "Khăn lau kiếng G11",style: TextStyle(fontSize: 12),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Giá')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("Tặng kèm",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Mô tả')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Vỏ bao',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        //border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
                        columnWidths: {
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  width: 60,
                                  child: Center(child: Text('Tên')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text( "Vỏ UTITAN",style: TextStyle(fontSize: 12),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Giá')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("Tặng kèm",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  height: 35,
                                  child: Center(child: Text('Mô tả')),
                                ),
                              ),
                              Container(
                                height: 35,
                                child:Center(child: Text("",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Thời gian bảo hành')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text("12 tháng",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Ngày mua hàng')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text("01/08/2021",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('Đơn giá')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text("4 tỷ vnđ",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('Tình trạng hoá đơn',style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10,),
              Table(
                border: TableBorder.all(color: Colors.grey),

                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        height: 35,
                        child: Center(child: Text('Tình trạng')),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          height: 35,
                          // width: 32,
                          child: Center(child: Text(DateFormat("Đã thanh toán").format(DateTime.now()).toString())),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        height: 35,
                        child: Center(child: Text('NV tư vấn')),
                      ),
                      Container(
                        height: 35,
                        child:Center(child: Text("----",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)) ,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }
}
