// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'package:vinaoptic/core/values/images.dart';
// import 'package:vinaoptic/pages/detail_oder/detail_order_page.dart';
// import 'package:vinaoptic/widget/pending_action.dart';
//
// import 'detail_customer_bloc.dart';
// import 'detail_customer_event.dart';
// import 'detail_customer_sate.dart';
//
// class DetailCustomerPage extends StatefulWidget {
//   final String maKH;
//   final bool typeView;
//
//   const DetailCustomerPage({Key key, this.maKH,this.typeView}) : super(key: key);
//   @override
//   _DetailCustomerPageState createState() => _DetailCustomerPageState();
// }
//
// class _DetailCustomerPageState extends State<DetailCustomerPage> with TickerProviderStateMixin {
//
//   ScrollController _scrollController;
//   GetDetailCustomerBloc _bloc;
//   final _scrollThreshold = 200.0;
//   bool _hasReachedMax = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bloc = GetDetailCustomerBloc(context);
//     _scrollController = ScrollController();
//     _bloc.add(GetDataDetailCustomer(widget.maKH,1));
//
//
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//       if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
//         _bloc.add(GetDataDetailCustomer(widget.maKH,1,isLoadMore: true));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<GetDetailCustomerBloc,DetailCustomerState>(
//       bloc: _bloc,
//       listener: (context,state){
//       },
//       child: BlocBuilder<GetDetailCustomerBloc,DetailCustomerState>(
//         bloc: _bloc,
//         builder: (BuildContext context, DetailCustomerState state){
//           return buildPage(context, state);
//         },
//       ),
//     );
//   }
//
//   Widget buildPage(BuildContext context,DetailCustomerState state){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lịch sử mua hàng',style: TextStyle(color: Colors.black),),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             color: Colors.white,
//             height: double.infinity,
//             width: double.infinity,
//             child: Column(
//               children: [
//                 Visibility(
//                   visible: widget.typeView == true,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 25,bottom: 20),
//                     child: Utils.isEmpty(_bloc.mainInfo ) ? Container() : Text('${_bloc.mainInfo.tenKh??""} - ${_bloc.mainInfo.maKh??''}',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.normal,fontSize: 15),),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(child: Divider()),
//                     Text('Danh sách đơn mua hàng',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
//                     Expanded(child: Divider()),
//                   ],
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.9),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 10, 0, 80),
//                       child: ListView.separated(
//                           controller: _scrollController,
//                           padding: EdgeInsets.zero,
//                           itemBuilder: (BuildContext context, int index) {
//                             return InkWell(
//                               focusColor: Colors.transparent,
//                               highlightColor: Colors.transparent,
//                               hoverColor: Colors.transparent,
//                               borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                               splashColor: nearlyDarkBlue.withOpacity(0.2),
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailOrderPage(
//                                   nameCustomer: _bloc.mainInfo.tenKh,
//                                   phoneCustomer: _bloc.mainInfo.dienThoai,
//                                   addressCustomer: _bloc.mainInfo.diaChi,
//                                   maKH: _bloc.mainInfo.maKh,
//                                   typeView: 3,
//                                   sttRec: _bloc.list[index].sttRec,
//                                   dienGiai: _bloc.list[index].noiDung,
//                                 )));
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 15,right: 15),
//                                 child: demoTopRatedDr(
//                                   'https://source.unsplash.com/random?sig=$index',
//                                   _bloc.list[index].soCt??'',
//                                   DateFormat('yyyy-MM-dd').format(DateTime.parse(_bloc.list[index].ngayCt))??'',
//                                   '',
//                                   _bloc.list[index].noiDung??'',
//                                 ),
//                               ),
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) => Container(),
//                           itemCount: _bloc.list.length),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: state is GetDetailCustomerLoading,
//             child: PendingAction(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget demoTopRatedDr(String img, String name, String speciality, String rating, String desc) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       height: 90,
//       // width: size.width,
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: EdgeInsets.only(left: 20),
//             height: 90,
//             width: 50,
//             child:Image.network(img,fit: BoxFit.contain),
//           ),
//           Flexible(
//             child: Container(
//               margin: EdgeInsets.only(left: 20, top: 5,right: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                       child: Container(
//                         margin: EdgeInsets.only(top: 5),
//                         child: Row(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: Text(
//                                 'Code:   ',
//                                 style: TextStyle(
//                                   color: Color(0xff363636),
//                                   fontSize: 17,
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 maxLines: 2, overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 10),
//                               child: Text(
//                                 name,
//                                 style: TextStyle(
//                                   color: Color(0xff363636),
//                                   fontSize: 17,
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 maxLines: 2, overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                   ),
//                   Flexible(
//                     child: Container(
//                       margin: EdgeInsets.only(top: 5),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 5),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       child: Text(
//                                         "Thời gian: ",
//                                         style: TextStyle(
//                                           color: Colors.blueGrey,
//                                           fontSize: 12,
//                                           fontFamily: 'Roboto',
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       child: Text(
//                                         speciality,
//                                         style: TextStyle(
//                                           color: Colors.blueGrey,
//                                           fontSize: 12,
//                                           fontFamily: 'Roboto',
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 3, left: size.width * 0.15),
//                             child: Row(
//                               children: [
//                                 // Container(
//                                 //   child: Text(
//                                 //     "Phone: ",
//                                 //     style: TextStyle(
//                                 //       color: Colors.black,
//                                 //       fontSize: 12,
//                                 //       fontFamily: 'Roboto',
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 Container(
//                                   child: Text(
//                                     rating,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                       fontFamily: 'Roboto',
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 5),
//                     child: Row(
//                       children: [
//                         Container(
//                           child: Text(
//                             "Nội dung:  ",
//                             style: TextStyle(
//                               color: Colors.blueGrey,
//                               fontSize: 12,
//                               fontFamily: 'Roboto',
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Text(
//                             desc,
//                             style: TextStyle(
//                               color: Colors.blueGrey,
//                               fontSize: 12,
//                               fontFamily: 'Roboto',
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
