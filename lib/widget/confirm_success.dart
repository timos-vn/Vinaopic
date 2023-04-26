// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as libGetX;
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:vinaoptic/core/values/colors.dart';
//
// class ConfirmSuccessPage extends StatefulWidget {
//   final String title;
//   final String content;
//   final int type;
//
//   const ConfirmSuccessPage({Key key, this.title, this.content, this.type}) : super(key: key);
//   @override
//   _ConfirmSuccessPageState createState() => _ConfirmSuccessPageState();
// }
//
// class _ConfirmSuccessPageState extends State<ConfirmSuccessPage> {
//   TextEditingController contentController = TextEditingController();
//   int groupValue = 0;
//   FocusNode focusNodeContent = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.only(left: 30, right: 30),
//             child: Container(
//               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
//               height: widget.type == 0 ? 250  : 270,
//               width: double.infinity,
//               child: Material(
//                   animationDuration: Duration(seconds: 3),
//                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 20,),
//                       Icon((widget.type == 0 || widget.type == 2) ? MdiIcons.checkCircle :MdiIcons.alertCircleOutline ,color: mainColor,size: 70,),
//                       SizedBox(height: 15,),
//                       Text(widget.title,style:  TextStyle(fontWeight: FontWeight.w600,),),
//                       SizedBox(height: 10,),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10,right: 10),
//                         child: Text(widget.content,style:  TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
//                       ),
//                       SizedBox(height: 30,),
//                       _submitButton(context),
//                     ],
//                   )),
//             ),
//           ),
//         ));
//   }
//   Widget _submitButton(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.pop(context,);
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 40,right: 40),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.symmetric(vertical: 10),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(15)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: Colors.grey.shade200,
//                     offset: Offset(2, 4),
//                     blurRadius: 5,
//                     spreadRadius: 2)
//               ],
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [mainColor, mainColor])),
//           child: Text(
//             'Xác nhận',
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
