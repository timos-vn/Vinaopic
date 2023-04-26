// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'package:vinaoptic/core/values/images.dart';
// import 'package:vinaoptic/pages/detail_customer/detail_customer_page.dart';
// import 'package:vinaoptic/pages/detail_history/detail_history_page.dart';
// import 'package:vinaoptic/widget/pending_action.dart';
//
// import 'oder_history_event.dart';
// import 'order_history_bloc.dart';
// import 'order_history_sate.dart';
//
//
// class OrderHistoryPage extends StatefulWidget {
//   final AnimationController animationController;
//
//   const OrderHistoryPage({Key key, this.animationController}) : super(key: key);
//   @override
//   _OrderHistoryPageState createState() => _OrderHistoryPageState();
// }
//
// class _OrderHistoryPageState extends State<OrderHistoryPage> {
// String dropdownValue ="Phiếu Khám";
//   /// 1 mua 2 Khám
//   TabController tabController;
//   ScrollController _scrollController;
//   final _scrollThreshold = 200.0;
//   bool _hasReachedMax = true;
//   String dataType = '2';
//   OrderHistoryBloc _bloc;
//   List<String> _listPhieu = [
//     'Phiếu mua hàng',
//     'Phiếu khám',
//
//   ];
//   DateTime _selectedDate = DateTime.parse(Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"));
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bloc = OrderHistoryBloc(context);
//     _bloc.add(GetListCustomer(Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),dataType));
//     _scrollController = ScrollController();
//
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//       if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
//         _bloc.add(GetListCustomer(_selectedDate.toString(),DateTime.now().toString(),dataType,isLoadMore: true));
//       }
//     });
//   }
//
// void _select(String choice) {
//   if(choice == 'Phiếu khám'){
//     _bloc.list.clear();
//     _bloc.add(GetListCustomer(_selectedDate.toString(),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),'2'));
//     dataType = "2";
//   }else{
//     _bloc.list.clear();
//     _bloc.add(GetListCustomer(_selectedDate.toString(),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),'1'));
//     dataType = '1';
//   }
// }
//
//
// @override
//   Widget build(BuildContext context) {
//     return BlocListener<OrderHistoryBloc,OrderHistoryState>(
//       bloc: _bloc,
//         listener: (context,state){},
//       child: BlocBuilder<OrderHistoryBloc,OrderHistoryState>(
//         bloc: _bloc,
//         builder: (BuildContext context,OrderHistoryState state){
//           return buildPage(context, state);
//         },
//       ),
//     );
//   }
//
//   Widget buildPage(BuildContext context,OrderHistoryState state){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lịch sử đơn',style: TextStyle(color: Colors.black),),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Container(
//               width: 25,
//               child: PopupMenuButton(
//                 icon: Icon(Icons.tune,color: Colors.black,),
//                 onSelected: _select,
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (BuildContext context) {
//                   return _listPhieu.map((String choice) {
//                     return  PopupMenuItem<String>(
//                       value: choice,
//                       child: Text(choice),
//                     );}
//                   ).toList();
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             color: Colors.white,
//             height: double.infinity,
//             width: double.infinity,
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//               ),
//               child: buildPageReport(context),
//             ),
//           ),
//           Visibility(
//             visible: state is CustomerLoading,
//             child: PendingAction(),
//           )
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget buildPageReport(BuildContext context) {
//     return Column(
//       children: [
//         // Container(
//         //   color: Colors.white,
//         //   child: CalendarTimeline(
//         //     initialDate: _selectedDate,
//         //     firstDate: DateTime.now().add(Duration(days: -180)),
//         //     lastDate: DateTime.now().add(Duration(days: 90)),
//         //     onDateSelected: (date) {
//         //       _selectedDate = DateTime.parse(Jiffy(date, "dd-MM-yyyy").format("yyyy-MM-dd"));
//         //       if(dataType == '2'){
//         //         _bloc.list.clear();
//         //         _bloc.add(GetListCustomer(_selectedDate.toString(),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),'2'));
//         //         dataType = "2";
//         //       }else{
//         //         _bloc.list.clear();
//         //         _bloc.add(GetListCustomer(_selectedDate.toString(),Jiffy(DateTime.now(), "dd-MM-yyyy").format("yyyy-MM-dd"),'1'));
//         //         dataType = '1';
//         //       }
//         //     },
//         //     leftMargin: 20,
//         //     monthColor: Colors.blueGrey,
//         //     dayColor: Colors.black,
//         //     activeDayColor: Colors.white,
//         //     activeBackgroundDayColor: Colors.redAccent[100],
//         //     dotsColor: Color(0xFF333A47),
//         //     selectableDayPredicate: (date) => date.day != 23,
//         //     locale: 'vi',
//         //   ),
//         // ),
//         SizedBox(height: 20,),
//         Row(
//           children: [
//             Expanded(child: Divider()),
//             Text('Danh sách ${dataType == '2' ? 'Phiếu khám' : 'Phiếu mua hàng'}',style: TextStyle(color: Colors.blueGrey),),
//             Expanded(child: Divider()),
//           ],
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 10, 0, 80),
//             child: Utils.isEmpty(_bloc.list) ? Image.asset(noData,fit: BoxFit.contain,)
//                 :
//             ListView.separated(
//                 controller: _scrollController,
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (BuildContext context, int index) {
//                   return InkWell(
//                     focusColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                     splashColor: nearlyDarkBlue.withOpacity(0.2),
//                     onTap: () {
//                       if(dataType == '1'){ //mua
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailCustomerPage(maKH: _bloc.list[index].maKh,typeView: true,)));
//                       }else{
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHistoryPage(
//                           sttRec: _bloc.list[index].sttRec,
//                           nameCustomer: _bloc.list[index].tenKh,
//                           maKH: _bloc.list[index].maKh,
//                           date: _bloc.list[index].ngayCt,
//                           bacsy: _bloc.list[index].tenBs,
//                         )));
//                       }
//                     },
//                     child:  Padding(
//                       padding: const EdgeInsets.only(left: 15,right: 15),
//                       child: demoTopRatedDr(
//                         'https://source.unsplash.com/random?sig=$index',
//                         _bloc.list[index].tenKh??'',
//                         _bloc.list[index].dienThoai??'',
//                         DateFormat('yyyy-MM-dd').format(DateTime.parse(_bloc.list[index].ngayCt))??'',
//                         _bloc.list[index].tenBs??'',
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) => Container(),
//                 itemCount: _bloc.list.length),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget demoTopRatedDr(String img, String name, String speciality, String rating, String desc) {
//   var size = MediaQuery.of(context).size;
//   return Container(
//     height: 90,
//     // width: size.width,
//     margin: EdgeInsets.only(top: 10),
//     decoration: BoxDecoration(
//       color: Colors.blueGrey.withOpacity(0.3),
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.only(left: 20),
//           height: 90,
//           width: 50,
//           child:Image.network(img,fit: BoxFit.contain),
//         ),
//         Flexible(
//           child: Container(
//             margin: EdgeInsets.only(left: 20, top: 5,right: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 10),
//                   child: Text(
//                     name,
//                     style: TextStyle(
//                       color: Color(0xff363636),
//                       fontSize: 17,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w700,
//                     ),
//                     maxLines: 1, overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Flexible(
//                   child: Container(
//                     margin: EdgeInsets.only(top: 5),
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(top: 5),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     child: Text(
//                                       "SĐT: ",
//                                       style: TextStyle(
//                                         color: Colors.blueGrey,
//                                         fontSize: 12,
//                                         fontFamily: 'Roboto',
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                       speciality,
//                                       style: TextStyle(
//                                         color: Colors.blueGrey,
//                                         fontSize: 12,
//                                         fontFamily: 'Roboto',
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 3, left: size.width * 0.15),
//                           child: Row(
//                             children: [
//                               // Container(
//                               //   child: Text(
//                               //     "Phone: ",
//                               //     style: TextStyle(
//                               //       color: Colors.black,
//                               //       fontSize: 12,
//                               //       fontFamily: 'Roboto',
//                               //     ),
//                               //   ),
//                               // ),
//                               Container(
//                                 child: Text(
//                                   rating,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     fontFamily: 'Roboto',
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 5),
//                   child: Row(
//                     children: [
//                       Container(
//                         child: Text(
//                           "Bsy:  ",
//                           style: TextStyle(
//                             color: Colors.blueGrey,
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Text(
//                           desc,
//                           style: TextStyle(
//                             color: Colors.blueGrey,
//                             fontSize: 12,
//                             fontFamily: 'Roboto',
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }
