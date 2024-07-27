import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/list_order_response.dart';
import 'package:vinaoptic/pages/detail_oder/detail_order_page.dart';
import 'package:vinaoptic/pages/main/main_bloc.dart';
import 'package:vinaoptic/pages/option_input/options_input_pages.dart';
import 'package:vinaoptic/widget/pending_action.dart';

import 'cart_bloc.dart';
import 'cart_event.dart';
import 'cart_sate.dart';

class CartPage extends StatefulWidget {

  CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage>{
  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;
  late CartBloc _bloc;
  String _dateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dataType = "1";
  String dropdownValue ="Chưa thanh toán";
  String _dateOrder = '';
  List<String> choices = <String>[
    "Chưa thanh toán",
    "Đã thanh toán",
  ];
  late MainBloc _mainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CartBloc(context);
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));


    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
       _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType,isLoadMore: true));
      }
    });
  }

  void _select(String choice) {
    _mainBloc.list.clear();
    if(choice == 'Chưa thanh toán'){
      dataType = '1';
      _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else{
      dataType = '2';
      _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc,CartState>(
      bloc: _bloc,
      listener: (context,state){
        if(state is GetListOrderSuccess){
          _mainBloc.list.clear();
          _mainBloc.list = _bloc.list;
        }
      },
      child: BlocBuilder<CartBloc,CartState>(
        bloc: _bloc,
        builder: (BuildContext context,CartState state){
          List<OrderResponseData> _list = _mainBloc.list;
          int length = _list.length;
          if (state is CartFailure){}
          if (state is GetListOrderSuccess){
            _hasReachedMax = length < _bloc.currentPage * 10;
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Text(dataType == '1' ? 'ĐH chưa thanh toán' : 'ĐH đã thanh toán',style: TextStyle(color: Colors.white),),
              centerTitle: true,
              actions: [
                GestureDetector(
                    onTap: ()=>  showDialog(
                        context: context,
                        builder: (context) => OptionsInputPage()).then(
                            (value){
                          if(value != '' && value != 'null' && value != null){
                            print(value);
                            _bloc.add(GetListOrderEvent(value[0],value[1],dataType));
                          }
                        }),
                    child: Icon(Icons.calendar_today)),
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 25,
                    child: PopupMenuButton(
                      icon: Icon(MdiIcons.sortVariant),
                      onSelected: _select,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context) {
                        return choices.map((String choice) {
                          return  PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );}
                        ).toList();
                      },
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Container(
                      //   child: Calendar(
                      //     startOnMonday: true,
                      //     weekDays: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
                      //     events: Utils.events,
                      //     isExpandable: false,
                      //     eventDoneColor: Colors.green,
                      //     selectedColor: Colors.pink,
                      //     hideBottomBar: true,
                      //     todayColor: Colors.blue,onDateSelected: (DateTime date){
                      //     _dateOrder = Jiffy(date).format('yyyy-MM-dd');
                      //     _bloc.add(GetListOrderEvent(_dateOrder,_dateOrder,dataType));
                      //   },
                      //     eventListBuilder: (BuildContext context, List<NeatCleanCalendarEvent> _selectesdEvents) {
                      //       return new Container();
                      //     },
                      //     eventColor: Colors.grey,
                      //     locale: 'vi_VN',
                      //     todayButtonText: 'Heute',hideTodayIcon: true,
                      //     expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                      //     dayOfWeekStyle: TextStyle(
                      //         color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
                      //   ),
                      // ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Text('Danh sách đơn hàng',style: TextStyle(color: Colors.grey),),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Expanded(
                        child: Utils.isEmpty(_bloc.list) ? Image.asset(noData,fit: BoxFit.contain,) : Container(
                          height: double.infinity,
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 0,top: 10),
                          color: Colors.grey.withOpacity(.1),
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 5,bottom: 80),
                            controller: _scrollController,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailOrderPage(
                                    nameCustomer: _mainBloc.list[index].tenKh,
                                    phoneCustomer: _mainBloc.list[index].dienThoai,
                                    addressCustomer: _mainBloc.list[index].diaChi,
                                    maKH: _mainBloc.list[index].maKh,
                                    typeView: _mainBloc.list[index].dataType,
                                    sttRec: _mainBloc.list[index].sttRec,
                                    dienGiai: _mainBloc.list[index].dienGiai,
                                  )));
                                },
                                child: Card(
                                  elevation: 10,
                                  semanticContainer: true,
                                  margin: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                  shadowColor: Colors.blueGrey.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 6,top: 10,bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                                              borderRadius:const BorderRadius.all( Radius.circular(6),)
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding:const EdgeInsets.only(left: 10,right: 3,top: 6,bottom: 5),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Điện thoại: ${_bloc.list[index].dienThoai.toString().trim()}',
                                                  textAlign: TextAlign.left,
                                                  style:const TextStyle(fontWeight: FontWeight.normal,fontSize: 11,color: Colors.blueGrey),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Khách ${_bloc.list[index].tenKh.toString().trim()}',
                                                        textAlign: TextAlign.left,
                                                        style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const Text('Bsy khám:',style: TextStyle(color: Colors.grey,fontSize: 11),),
                                                    const SizedBox(width: 3,),
                                                    Expanded(child: Text('${_bloc.list[index].tenBs.toString().trim()}', style: const TextStyle(color: Colors.grey,fontSize: 12),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                    ],
                  ),
                  Visibility(
                    visible: state is CartLoading,
                    child: PendingAction(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget demoTopRatedDr(String img, String name, String speciality, String rating, String desc) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      // width: size.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 90,
            width: 50,
            child:Image.network(img,fit: BoxFit.contain),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 5,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "SĐT: ",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      speciality,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3, left: size.width * 0.15),
                            child: Row(
                              children: [
                                // Container(
                                //   child: Text(
                                //     "Phone: ",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 12,
                                //       fontFamily: 'Roboto',
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  child: Text(
                                    rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Bsy:  ",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            desc,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.delete_forever,color: Colors.blueGrey,),
          )),
        ],
      ),
    );
  }
}