// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/services.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'package:vinaoptic/core/values/images.dart';
//
// class SupportContactScreen extends StatefulWidget {
//   @override
//   _SupportContactScreenState createState() => _SupportContactScreenState();
// }
//
// class _SupportContactScreenState extends State<SupportContactScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mainColor,
//         title: Text('Hỗ trợ',
//             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         leading: InkWell(
//             onTap: ()=> Navigator.pop(context),
//             child: Icon(Icons.arrow_back, color: Colors.white)),
//       ),
//       body: buildScreen(context),
//     );
//   }
//
//   Widget buildScreen(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       height: double.infinity,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16,right: 16),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     child: Image.asset(contact,fit: BoxFit.contain,),
//                   ),
//                   Divider(),
//                   SizedBox(height: 15,),
//                   Text('Liên hệ với chúng tôi',style:  TextStyle(fontWeight: FontWeight.w600),),
//                   SizedBox(height: 20,),
//                   Text('Trung tâm chăm sóc khách hàng'),//
//                   SizedBox(height: 10,),
//                   InkWell(
//                     onTap: () => launch("tel://02437365505"),
//                     child: Row(
//                       children: [
//                         Icon(MdiIcons.phoneClassic,color: Colors.blueGrey,),
//                         SizedBox(width: 10,),
//                         Text('02437365505 '),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Divider(),
//                   SizedBox(height: 10,),
//                   Text('Hòm thư điện tử'),
//                   SizedBox(height: 10,),
//                   InkWell(
//                     onTap: (){
//                       Clipboard.setData(new ClipboardData(text: 'info@vinaoptic.com.vn')).then((_){
//                         Utils.showToast('Copied info@vinaoptic.com.vn');
//                       });
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(MdiIcons.emailOutline,color: Colors.blueGrey,),
//                             SizedBox(width: 10,),
//                             Text('info@vinaoptic.com.vn'),
//                           ],
//                         ),
//                         Icon(MdiIcons.contentCopy,color: Colors.black,size: 18,),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Divider(),
//                   SizedBox(height: 10,),
//                   Text('Website'),
//                   SizedBox(height: 10,),
//                   GestureDetector(
//                     onTap: (){
//                       launch("https://kinhmatvietnam.vn");
//                     },
//                     child: Row(
//                       children: [
//                         Icon(MdiIcons.web,color: Colors.blueGrey,),
//                         SizedBox(width: 10,),
//                         Text('https://kinhmatvietnam.vn'),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Divider(),
//                   SizedBox(height: 10,),
//                   Text('Facebook'),
//                   SizedBox(height: 10,),
//                   GestureDetector(
//                     onTap: (){
//                       launch("https://www.facebook.com/Kinhmatvietnam.VinaOptic");
//                     },
//                     child: Row(
//                       children: [
//                         Icon(MdiIcons.facebook,color: Colors.blueGrey,),
//                         SizedBox(width: 10,),
//                         Expanded(child: Text('https://www.facebook.com/Kinhmatvietnam.VinaOptic',maxLines: 1,overflow: TextOverflow.ellipsis,)),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
