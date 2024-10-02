// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// import '../core/values/images.dart';
//
// class CustomCarousel extends StatefulWidget {
//   final List<String> items;
//
//   CustomCarousel({required this.items});
//
//   @override
//   _CustomCarouselState createState() => _CustomCarouselState();
// }
//
// class _CustomCarouselState extends State<CustomCarousel> {
//   int activeIndex = 0;
//   setActiveDot(index) {
//     setState(() {
//       activeIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: <Widget>[
//         SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: widget.items.length == 0
//               ? Image.asset(noWallpaper, fit: BoxFit.cover,)
//               : CarouselSlider(
//               items: widget.items.map((item) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Stack(
//                       children: <Widget>[
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child:
//                           Image(
//                             image: NetworkImage(item),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width,
//                           color: Colors.black.withOpacity(0.2),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }).toList(),
//               options: CarouselOptions(
//                 viewportFraction: 1.0,
//                 autoPlay: true,
//                 autoPlayInterval: Duration(seconds: 3),
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 // enlargeCenterPage: true,
//                 onPageChanged:(index,__){
//                   setActiveDot(index);
//                 },
//                 scrollDirection: Axis.horizontal,
//               )
//           ),
//         ),
//         Positioned(
//           left: 0,
//           right: 0,
//           bottom: 10,
//           child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: List.generate(widget.items.length, (idx) {
//                 return activeIndex == idx ? ActiveDot() : InactiveDot();
//               })),
//         )
//       ],
//     );
//   }
// }
//
// class ActiveDot extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: Container(
//         width: 25,
//         height: 8,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//     );
//   }
// }
//
// class InactiveDot extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: Container(
//         width: 8,
//         height: 8,
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//     );
//   }
// }
