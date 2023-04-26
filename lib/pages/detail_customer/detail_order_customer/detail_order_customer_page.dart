// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:snapping_sheet/snapping_sheet.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'package:vinaoptic/core/values/images.dart';
// import 'package:vinaoptic/extension/default_grabbing.dart';
// import 'package:vinaoptic/widget/pending_action.dart';
//
// import 'detail_order_customer_bloc.dart';
// import 'detail_order_customer_event.dart';
// import 'detail_order_customer_sate.dart';
//
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
//   GetDetailOrderCustomerBloc _bloc;
//   final fullNameController = TextEditingController();
//   final FocusNode fullNameFocus = FocusNode();
//
//   final dienGiaiController = TextEditingController();
//   final FocusNode dienGiaiFocus = FocusNode();
//   final phoneController = TextEditingController();
//   final FocusNode phoneFocus = FocusNode();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bloc = GetDetailOrderCustomerBloc(context);
//     _scrollController = ScrollController();
//     _bloc.add(GetDetailOrderDetailCustomer(widget.maKH));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: BlocListener<GetDetailOrderCustomerBloc,DetailOrderCustomerState>(
//           bloc: _bloc,
//           listener: (context,state){
//           },
//           child: BlocBuilder<GetDetailOrderCustomerBloc,DetailOrderCustomerState>(
//             bloc: _bloc,
//             builder: (BuildContext context, DetailOrderCustomerState state){
//               return buildPage(context, state);
//             },
//           ),
//         ));
//   }
//
//   Widget buildPage(BuildContext context,DetailOrderCustomerState state){
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 0),
//           child: SnappingSheet(
//             lockOverflowDrag: true,
//             snappingPositions: [
//               SnappingPosition.factor(
//                 positionFactor: 0.0,
//                 grabbingContentOffset: GrabbingContentOffset.top,
//               ),
//               SnappingPosition.factor(
//                 snappingCurve: Curves.elasticOut,
//                 snappingDuration: Duration(milliseconds: 1750),
//                 positionFactor: 0.2,
//               ),
//               // SnappingPosition.factor(positionFactor: 0.9),
//             ],
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   color: mainColor,
//                   height: double.infinity,
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 36,left: 16,right: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 InkWell(
//                                     onTap:()=>Navigator.pop(context),
//                                     child: Icon(Icons.arrow_back_outlined,color: Colors.white,)),
//                                 Icon(MdiIcons.microsoftOnenote,color: mainColor,),
//                               ],
//                             ),
//                             Expanded(child: Center(child: Text('Đơn hàng',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),))),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 15,),
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.only(left: 0,right: 0,top: 16,bottom: 20),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.9),
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20)
//                               )
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius: BorderRadius.circular(10),
//                                           child: Image.asset(
//                                             icLogo,
//                                             height: 70,
//                                             width: 70,
//                                           ),
//                                         ),
//                                         SizedBox(width: 10,),
//                                         Expanded(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Expanded(child: Text('Khách hàng:')),
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Container(
//                                                       padding: EdgeInsets.all(5),
//                                                       decoration: BoxDecoration(
//                                                           color: Colors.grey.withOpacity(0.3),
//                                                           borderRadius: BorderRadius.circular(30)
//                                                       ),
//                                                       child: Align(
//                                                         alignment: Alignment.center,
//                                                         child: Text(fullNameController.text??''),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                               SizedBox(height: 8,),
//                                               Row(
//                                                 children: [
//                                                   Expanded(child: Text('Số điện thoại:')),
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Container(
//                                                       padding: EdgeInsets.all(5),
//                                                       decoration: BoxDecoration(
//                                                           color: Colors.grey.withOpacity(0.3),
//                                                           borderRadius: BorderRadius.circular(30)
//                                                       ),
//                                                       child: Align(
//                                                         alignment: Alignment.center,
//                                                         child: Text(phoneController.text?.trim()??''),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(height: 10,),
//                                     Row(
//                                       children: [
//                                         Text('Diễn giải:'),
//                                         SizedBox(width: 15,),
//                                         Expanded(
//                                           child: Container(
//                                             padding: EdgeInsets.only(left: 16,right: 10,top: 10,bottom: 10),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.grey.withOpacity(0.3),
//                                                 borderRadius: BorderRadius.circular(30)
//                                             ),
//                                             child: Align(
//                                               alignment: Alignment.center,
//                                               child: Text(dienGiaiController.text??'',style: TextStyle(fontSize: 11),),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 20,),
//                               Row(
//                                 children: [
//                                   Expanded(child: Divider()),
//                                   Text('Danh sách sản phẩm',style: TextStyle(color: Colors.grey,fontSize: 12),),
//                                   Expanded(child: Divider()),
//                                 ],
//                               ),
//                               _bloc.list == null ? Container() :
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 30),
//                                   child: ListView.separated(
//                                       itemBuilder: (BuildContext context, int index) {
//                                         return Card(
//                                           color: Colors.white.withOpacity(0.9),
//                                           elevation: 1,
//                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
//                                           child: Stack(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.all(10.0),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Expanded(
//                                                         child: Container(
//                                                           child: Column(
//                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                             mainAxisAlignment: MainAxisAlignment.start,
//                                                             children: [
//                                                               Container(
//                                                                   width: 150,
//                                                                   height: 100,
//                                                                   padding: EdgeInsets.all(2),
//                                                                   decoration: BoxDecoration(
//                                                                       color: Colors.transparent,
//                                                                       borderRadius: BorderRadius.only(
//                                                                         topRight: Radius.circular(2),
//                                                                         topLeft: Radius.circular(2),
//                                                                         bottomRight:  Radius.circular(2),
//                                                                         bottomLeft:  Radius.circular(2),
//                                                                       )
//                                                                   ),
//                                                                   child:  Container(
//                                                                       decoration: BoxDecoration(
//                                                                           color: Colors.white,
//                                                                           borderRadius: BorderRadius.all(Radius.circular(40))
//                                                                       ),
//                                                                       child:// _listChildItemScan[index].imageUrl == null ?
//                                                                       Image.network('https://product.hstatic.net/1000392226/product/ct0101sa-003_2bfad2c052a64f01946e51ed2c5c67b2_large.jpg',fit: BoxFit.fill,)
//                                                                     //:Image.network(_listChildItemScan[index].imageUrl ,fit: BoxFit.fill, )  ,
//                                                                   )
//                                                               ),
//                                                               SizedBox(height: 10,),
//                                                               Row(
//                                                                 mainAxisSize: MainAxisSize.min,
//                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                                 children: <Widget>[
//                                                                   Container(
//                                                                     child: Text(
//                                                                       Utils.formatTotalMoney(_bloc.list[index].soLuong).toString(),
//                                                                       textAlign: TextAlign.center,
//                                                                       style: TextStyle(
//                                                                           fontSize: 12, color: black, fontWeight: FontWeight.bold),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         )),
//                                                     Expanded(
//                                                         flex: 2,
//                                                         child: Padding(
//                                                           padding: const EdgeInsets.only(left: 16),
//                                                           child: Column(
//                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                       child: Text('SP:')),
//                                                                   Expanded(
//                                                                       flex: 3,
//                                                                       child: Text(_bloc.list[index].tenVt??"",style: TextStyle(color: mainColor))),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(height: 10,),
//                                                               Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                       child: Text('MSP:')),
//                                                                   Expanded(
//                                                                       flex: 3,
//                                                                       child: Text(_bloc.list[index].maVt??'',style: TextStyle(color: Colors.grey))),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(height: 10,),
//                                                               // Row(
//                                                               //   children: [
//                                                               //     Expanded(
//                                                               //         child: Text('XS:')),
//                                                               //     Expanded(
//                                                               //         flex: 3,
//                                                               //         child: Text(_bloc.list[index].nuocSx,style: TextStyle(color: Colors.grey))),
//                                                               //   ],
//                                                               // ),
//                                                               SizedBox(height: 10,),
//                                                               // Row(
//                                                               //   children: [
//                                                               //
//                                                               //     Expanded(
//                                                               //         child: Text('Giá:')),
//                                                               //     Expanded(
//                                                               //         flex: 3,
//                                                               //         child: Text("${Utils.formatTotalMoney(_listChildItemScan[index].gia??0).toString()} vnđ",style: TextStyle(color: Colors.red))),
//                                                               //   ],
//                                                               // ),
//                                                               SizedBox(height: 10,),
//                                                               Row(
//                                                                 children: [
//
//                                                                   Expanded(
//                                                                       child: Text('CK:')),
//                                                                   // Expanded(
//                                                                   //     flex: 3,
//                                                                   //     child: Text("${_listChildItemScan[index].tlCk?.toString()??''} %",style: TextStyle(color: Colors.grey),)),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(height: 10,),
//                                                             ],
//                                                           ),
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                       separatorBuilder: (BuildContext context, int index) => Container(),
//                                       itemCount: _bloc.list.length),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             grabbingHeight: 50,
//             grabbing: DefaultGrabbing(),
//             sheetBelow: SnappingSheetContent(
//               // childScrollController: scrollController,
//                 draggable: false,
//                 child: Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   color: Colors.white,
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     reverse: false,
//                     children: [
//                       // Padding(
//                       //   padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
//                       //   child: Row(
//                       //     children: [
//                       //       Expanded(
//                       //         child: Column(
//                       //           children: [
//                       //             Row(
//                       //               children: [
//                       //                 Text('Tổng:  ',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
//                       //                 Text('${Utils.formatTotalMoney(_bloc.total)} vnđ',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
//                       //               ],
//                       //             ),
//                       //             SizedBox(height: 10,),
//                       //             Row(
//                       //               children: [
//                       //                 Text('Tạm tính:  ',style: TextStyle(color: Colors.grey,),),
//                       //                 Text('${Utils.formatTotalMoney(_bloc.total)} vnđ',style: TextStyle(color: Colors.grey,),),
//                       //               ],
//                       //             ),
//                       //             SizedBox(height: 10,),
//                       //             Row(
//                       //               children: [
//                       //                 Text('Thuế:  ',style: TextStyle(color: Colors.grey,),),
//                       //                 Text('0',style: TextStyle(color: Colors.grey,),),
//                       //               ],
//                       //             ),
//                       //             SizedBox(height: 10,),
//                       //             Row(
//                       //               children: [
//                       //                 Text('Chiết khấu:  ',style: TextStyle(color: Colors.grey,),),
//                       //                 Text('${Utils.formatTotalMoney(_bloc.ck??0)}%',style: TextStyle(color: Colors.grey,),),
//                       //               ],
//                       //             ),
//                       //           ],
//                       //         ),
//                       //       ),
//                       //       Column(
//                       //         crossAxisAlignment: CrossAxisAlignment.end,
//                       //         mainAxisAlignment: MainAxisAlignment.end,
//                       //         children: [
//                       //           Container(height: 45,),
//                       //           InkWell(
//                       //             onTap: () {
//                       //               if(!Utils.isEmpty(_listChildItemScan)){
//                       //                 if(widget.typeView == 1){
//                       //                   List<UpdateOrderRequestDetail> _listItemUpdate = new List<UpdateOrderRequestDetail>();
//                       //                   _bloc.listProduct.forEach((element) {
//                       //                     UpdateOrderRequestDetail _itemUpdate = UpdateOrderRequestDetail(
//                       //                         soLuong: element.soLuong.toInt(),giaNt2: element.giaNt2,tlCk: element.tlCk,maVt: element.maVt,maKho: element.maKho
//                       //                     );
//                       //                     _listItemUpdate.add(_itemUpdate);
//                       //                   });
//                       //                   _bloc.add(UpdateOrderEvent(_listItemUpdate,widget.sttRec,cpDetail,image));
//                       //                 }
//                       //                 else {
//                       //                   if(Utils.isEmpty(fullNameController.text) && Utils.isEmpty( phoneController.text )&& Utils.isEmpty(addressController.text) && Utils.isEmpty(dienGiaiController.text)){ //&&  == null &&  == null
//                       //                     ShowOnDialogInputInfo();
//                       //                   }
//                       //                   else{
//                       //                     List<itemSendInvoice.Detail> _list = List();
//                       //                     _listChildItemScan.forEach((element) {
//                       //                       itemSendInvoice.Detail item = itemSendInvoice.Detail(
//                       //                         soLuong: element.soLuong.toInt(),
//                       //                         gia: element.gia,
//                       //                         tlCk: element.tlCk,
//                       //                         maVt: element.maVt,
//                       //                         maKho: element.maKho,
//                       //                       );
//                       //                       _list.add(item);
//                       //                     });
//                       //                     _bloc.add(OrderBillEvent(
//                       //                         _list,fullNameController.text,phoneController.text,addressController.text,dienGiaiController.text
//                       //                     ));
//                       //                   }
//                       //                 }
//                       //               }
//                       //               else{
//                       //                 Utils.showToast('Vui lòng thêm sản phẩm vào đơn hàng');
//                       //               }
//                       //             },
//                       //             child: Container(
//                       //               padding: EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
//                       //               decoration: BoxDecoration(
//                       //                   color: mainColor,
//                       //                   borderRadius: BorderRadius.all(Radius.circular(20))
//                       //               ),
//                       //               child: Center(
//                       //                 child: Text(widget.typeView == 1 ? "Cập nhật" : 'Đặt hàng',style: TextStyle(color: Colors.white),),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //     ],
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 )
//             ),
//           ),
//         ),
//         Visibility(
//           visible: state is GetDetailOrderCustomerLoading,
//           child: PendingAction(),
//         ),
//       ],
//     );
//   }
// }
