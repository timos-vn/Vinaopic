// import 'package:flutter/material.dart';
// import 'package:vinaoptic/core/values/colors.dart';
//
// class AreaView extends StatelessWidget {
//   const AreaView({
//     Key key,
//     this.imagepath,
//     this.animationController,
//     this.animation,this.nameDoctor,this.specialized
//   }) : super(key: key);
//
//   final String imagepath;
//   final AnimationController animationController;
//   final Animation<dynamic> animation;
//   final String nameDoctor;
//   final String specialized;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController,
//       builder: (BuildContext context, Widget child) {
//         return FadeTransition(
//           opacity: animation,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation.value), 0.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: white,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     bottomLeft: Radius.circular(8.0),
//                     bottomRight: Radius.circular(8.0),
//                     topRight: Radius.circular(8.0)),
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                       color: grey.withOpacity(0.4),
//                       offset: const Offset(1.1, 1.1),
//                       blurRadius: 10.0),
//                 ],
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   focusColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   hoverColor: Colors.transparent,
//                   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                   splashColor: nearlyDarkBlue.withOpacity(0.2),
//                   onTap: () {},
//                   child: Stack(
//                     children: <Widget>[
//                       Image.network(imagepath??'https://theme.hstatic.net/1000392226/1000521831/14/page_slider_img1.jpg?v=4251',fit: BoxFit.contain,width: double.infinity,),
//                       Positioned(
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             padding: EdgeInsets.only(top: 5,bottom: 5),
//                             height: 50,
//                             width: double.infinity,
//                             color: Colors.black.withOpacity(0.5),
//                             child: Column(
//                               children: [
//                                 Text('BS. $nameDoctor',style: TextStyle(color: Colors.white),),
//                                 SizedBox(height: 5,),
//                                 Text('Chuyên ngành: $specialized',style: TextStyle(color: Colors.white,fontSize: 11),)
//                               ],
//                             ),
//                           )
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
