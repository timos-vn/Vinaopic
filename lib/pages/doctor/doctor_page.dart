// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'area_list_view.dart';
// import 'doctor_bloc.dart';
// import 'doctor_event.dart';
// import 'doctor_state.dart';
//
// class Doctor extends StatefulWidget {
//   final AnimationController animationController;
//
//   const Doctor({Key key, this.animationController}) : super(key: key);
//   @override
//   _DoctorState createState() => _DoctorState();
// }
//
// class _DoctorState extends State<Doctor>  with TickerProviderStateMixin{
//   ScrollController _scrollController;
//   final _scrollThreshold = 200.0;
//   bool _hasReachedMax = true;
//   final ScrollController scrollController = ScrollController();
//   double topBarOpacity = 0.0;
//   AnimationController animationController;
//
//   List<String> areaListData1 = <String>[
//     'https://theme.hstatic.net/1000392226/1000521831/14/page_slider_img4.jpg?v=4251',
//     'https://theme.hstatic.net/1000392226/1000521831/14/page_slider_img1.jpg?v=4251',
//     'https://theme.hstatic.net/1000392226/1000521831/14/page_slider_img2.jpg?v=4251',
//     'https://theme.hstatic.net/1000392226/1000521831/14/page_slider_img3.jpg?v=4251',
//   ];
//
//   DoctorBloc _bloc;
//
//
//   @override
//   void initState() {
//     _bloc = DoctorBloc(context);
//     _bloc.add(GetListDoctorEvent());
//     _scrollController = ScrollController();
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 2000), vsync: this);
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//       if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
//         _bloc.add(GetListDoctorEvent(isLoadMore: true));
//       }
//     });
//     // topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget.animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
//     scrollController.addListener(() {
//       if (scrollController.offset >= 24) {
//         if (topBarOpacity != 1.0) {
//           setState(() {
//             topBarOpacity = 1.0;
//           });
//         }
//       } else if (scrollController.offset <= 24 &&
//           scrollController.offset >= 0) {
//         if (topBarOpacity != scrollController.offset / 24) {
//           setState(() {
//             topBarOpacity = scrollController.offset / 24;
//           });
//         }
//       } else if (scrollController.offset <= 0) {
//         if (topBarOpacity != 0.0) {
//           setState(() {
//             topBarOpacity = 0.0;
//           });
//         }
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<DoctorBloc,DoctorState>(
//       bloc: _bloc,
//       listener: (context,state){},
//       child: BlocBuilder<DoctorBloc,DoctorState>(
//         bloc: _bloc,
//         builder: (BuildContext context, DoctorState state){
//           int length = _bloc.list?.length ?? 0;
//           if (state is GetListDoctorSuccess){
//             _hasReachedMax = length < _bloc.currentPage * 10;
//           }
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Bác sỹ',style: TextStyle(color: Colors.black),),
//               centerTitle: true,
//             ),
//             body: Stack(
//               children: <Widget>[
//                 Container(
//                   color: Colors.white,
//                   height: double.infinity,
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: Color(0xFFFFFFFF),
//                             ),
//                             child:  Padding(
//                               padding: EdgeInsets.only(
//                                 bottom: 62 + MediaQuery.of(context).padding.bottom,
//                               ),
//                               child: AspectRatio(
//                                 aspectRatio: 1.0,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 8.0, right: 8),
//                                   child: Utils.isEmpty(_bloc.list) ? Container() : GridView(
//                                     controller: _scrollController,
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16, top: 16, bottom: 16),
//                                     physics: const BouncingScrollPhysics(),
//                                     scrollDirection: Axis.vertical,
//                                     children: List<Widget>.generate(
//
//                                       _bloc.list.length,
//                                           (int index) {
//                                         final int count = _bloc.list.length;
//                                         final Animation<double> animation =
//                                         Tween<double>(begin: 0.0, end: 1.0).animate(
//                                           CurvedAnimation(
//                                             parent: animationController,
//                                             curve: Interval((1 / count) * index, 1.0,
//                                                 curve: Curves.fastOutSlowIn),
//                                           ),
//                                         );
//                                         animationController.forward();
//                                         return AreaView(
//                                           imagepath: Utils.isEmpty(_bloc.list[index].avatar)? 'https://theme.hstatic.net/1000392226/1000521831/14/page_slider_img1.jpg?v=4251':_bloc.list[index].avatar,
//                                           animation: animation,
//                                           animationController: animationController,
//                                         );
//                                       },
//                                     ),
//                                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       mainAxisSpacing: 24.0,
//                                       crossAxisSpacing: 24.0,
//                                       childAspectRatio: 1.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
