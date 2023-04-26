// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:vinaoptic/core/values/colors.dart';
//
// class NewsPage extends StatefulWidget {
//   @override
//   _NewsPageState createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
//   List<String> categories = ["Tin mới", "Tin khuyến mại", "Tin tuyển dụng"];
//   TabController tabController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     tabController = TabController(vsync: this, length: categories.length);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: buildPage(context));
//   }
//
//   Widget buildPage(BuildContext context){
//     return Stack(
//       children: <Widget>[
//         Container(
//           color: mainColor,
//
//           height: double.infinity,
//           width: double.infinity,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 40,left: 16,right: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap:()=>Navigator.pop(context),
//                       child: Icon(Icons.arrow_back,color: Colors.white,),
//                     ),
//                     Text('Tin tức',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
//                     Icon(Icons.notifications_none,color: Colors.white,),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 25,),
//               Container(
//                 color: mainColor,
//                 padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
//                 child: Container(
//                     padding: EdgeInsets.all(4),
//                     height: 40,
//                     width: double.infinity,
//                     // decoration: BoxDecoration(border: Border.all(width: 0.8, color: white), borderRadius: BorderRadius.all(Radius.circular(16)), color: orange),
//                     child: TabBar(
//                       controller: tabController,
//                       unselectedLabelColor: white,
//                       labelColor: orange,
//                       labelStyle: TextStyle(fontWeight: FontWeight.normal),
//                       isScrollable: true,
//                       indicatorPadding: EdgeInsets.all(4),
//                       indicator: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                               color: Colors.white,
//                               width: 1.0
//                           ),
//                         ),
//                       ),
//                       tabs: List<Widget>.generate(categories.length, (int index) {
//                         return new Tab(
//                           text: categories[index].toString(),
//                         );
//                       }),
//                     )),
//               ),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20)
//                       )
//                   ),
//                   child: TabBarView(
//                       controller: tabController,
//                       children: List<Widget>.generate(categories.length, (int index) {
//                         for (int i = 0; i <= categories.length; i++) {
//                           if (i == index) {
//                             return buildPageReport(context, categories, index);
//                           }
//                         }
//                         return Text('');
//                       })),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Visibility(
//         //   visible:true,
//         //   child: PendingAction(),
//         // ),
//       ],
//     );
//   }
//
//   Widget buildPageReport(BuildContext context,  List<String>  detailDataReport, int i) {
//     // print('K+=> ${detailDataReport[i].id.toString()}');
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
//       child: Column(
//         children: [
//           Container(
//             height: 40,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),borderRadius: BorderRadius.all(Radius.circular(16)), border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1))),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.search,
//                           size: 25,
//                           color: Colors.black.withOpacity(0.5),
//                         ),
//                         SizedBox(width: 16,),
//                         Expanded(
//                             child: Text(
//                               'Tìm kiếm',
//                               style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14,fontStyle: FontStyle.normal),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 20,),
//                 Icon(MdiIcons.sortVariant),
//               ],
//             ),
//           ),
//           SizedBox(height: 15,),
//           Expanded(
//             child: ListView.separated(
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       //_reportBloc.add(GetListReportLayout(detailDataReport[i].reportList[index].id.toString(),detailDataReport[i].reportList[index].name.toString()));
//                     },
//                     child: Card(
//                       color: Colors.white.withOpacity(0.9),
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                                 child: Container(
//
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(Radius.circular(8))
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.all(Radius.circular(8))
//                                         ),
//                                         child: Image.network('https://vn-test-11.slatic.net/p/fe51bdad887308adf6d2bec56472edc5.jpg'),
//                                       )
//                                     ],
//                                   ),
//                                 )),
//                             Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 16),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text('Chung tay bảo vệ mắt cho con',style: TextStyle(fontWeight: FontWeight.bold),),
//                                       SizedBox(height: 10,),
//                                       Text('Lời đầu tiên Cty TNHH Kính mặt Việt Nam....',style: TextStyle(color: Colors.grey,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,),
//                                       SizedBox(height: 10,),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Icon(Icons.access_time,color: Colors.grey,size: 16,),
//                                               SizedBox(width: 4,),
//                                               Text('Một ngày trước',style: TextStyle(color: grey,fontSize: 11),),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Icon(Icons.remove_red_eye_outlined,color: Colors.grey,size: 16,),
//                                               SizedBox(width: 4,),
//                                               Text('959 view',style: TextStyle(color: grey,fontSize: 11),),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) => Container(),
//                 itemCount: categories.length),
//           ),
//         ],
//       ),
//     );
//   }
// }
