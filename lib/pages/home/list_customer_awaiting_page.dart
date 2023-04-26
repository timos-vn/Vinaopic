// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as libGetX;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'package:vinaoptic/core/values/images.dart';
// import 'package:vinaoptic/models/network/response/get_list_awaiting_customer_response.dart';
// import 'package:vinaoptic/widget/pending_action.dart';
//
// import 'home_bloc.dart';
// import 'home_event.dart';
// import 'home_sate.dart';
//
// class ListCustomerAwaitingPage extends StatefulWidget {
//   @override
//   _ListCustomerAwaitingPageState createState() => _ListCustomerAwaitingPageState();
// }
//
// class _ListCustomerAwaitingPageState extends State<ListCustomerAwaitingPage> {
//   ScrollController _scrollController;
//   final _scrollThreshold = 200.0;
//   bool _hasReachedMax = true;
//   HomeBloc _bloc;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _bloc = HomeBloc(context);
//     _bloc.add(GetAllListCustomerAwait('',''));
//     _scrollController = ScrollController();
//
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//       if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
//         _bloc.add(GetAllListCustomerAwait('','',isLoadMore: true));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Khách hàng chờ khám'),
//         centerTitle: true,
//       ),
//         body: BlocListener<HomeBloc,HomeState>(
//             bloc: _bloc,
//             listener: (context,state){
//
//             },
//             child: BlocBuilder<HomeBloc,HomeState>(
//               bloc: _bloc,
//               builder: (BuildContext context, HomeState state){
//                 List<GetListAwaitingCustomerResponseData> _list = _bloc.list;
//                 int length = _list?.length ?? 0;
//                 if (state is GetAllListCustomerSuccess)
//                   _hasReachedMax = length < _bloc.currentPage * 10;//_bloc.maxPage
//                 else
//                   _hasReachedMax = false;
//                 return Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: Stack(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 40,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                       decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),borderRadius: BorderRadius.all(Radius.circular(16)), border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1))),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.search,
//                                             size: 25,
//                                             color: Colors.black.withOpacity(0.5),
//                                           ),
//                                           SizedBox(width: 16,),
//                                           Expanded(
//                                               child: Text(
//                                                 'Tìm kiếm',
//                                                 style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14,fontStyle: FontStyle.normal),
//                                               )),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 20,),
//                                   Icon(MdiIcons.sortVariant),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 0,),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.fromLTRB(2, 15, 2, 0),
//                                 child: ListView.separated(
//                                   controller: _scrollController,
//                                   padding: EdgeInsets.zero,
//                                   shrinkWrap: true,
//                                   physics: ClampingScrollPhysics(),
//                                   itemBuilder: (BuildContext context, int index) {
//                                     return index >= length
//                                         ?
//                                     Container(
//                                       height: 100.0,
//                                       color: white,
//                                       child: PendingAction(),
//                                     )
//                                         :
//                                     GestureDetector(
//                                       onTap: () {
//                                       },
//                                       child: demoTopRatedDr(
//                                         'https://source.unsplash.com/random?sig=$index',
//                                         _bloc.list[index].tenKh??'',
//                                         _bloc.list[index].maKh??'',
//                                         '',
//                                         _bloc.list[index].statusname??'',
//                                       ),
//                                     );
//                                   },
//                                   separatorBuilder: (BuildContext context, int index) => Container(),
//                                   itemCount: length == 0
//                                       ? length
//                                       : _hasReachedMax ? length : length + 1,),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Visibility(
//                         visible: state is GetLisCustomerEmpty,
//                         child: Center(
//                           child: Text('NoData'.tr),
//                         ),
//                       ),
//                       Visibility(
//                         visible: state is HomeLoading,
//                         child: PendingAction(),
//                       )
//                     ],
//                   ),
//                 );
//               },
//             )
//         ));
//   }
//   Widget demoTopRatedDr(String img, String name, String speciality, String rating, String desc) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       height: 90,
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
//                   Container(
//                     margin: EdgeInsets.only(top: 10),
//                     child: Text(
//                       name,
//                       style: TextStyle(
//                         color: Color(0xff363636),
//                         fontSize: 16,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w700,
//                       ),
//                       maxLines: 1, overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Flexible(
//                     child: Container(
//                       margin: EdgeInsets.only(top: 3),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 5),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       child: Text(
//                                         "Code: ",
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
//                                 //     "Code: ",
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
//                         Expanded(
//                           child: Container(
//                             child: Text(
//                               desc,
//                               style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontSize: 12,
//                                 fontFamily: 'Roboto',
//                               ),
//                               maxLines: 1, overflow: TextOverflow.ellipsis,
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
