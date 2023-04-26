// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// enum SlidableAction { archive, share, more, delete, edit }
//
// class SlidableWidget<T> extends StatelessWidget {
//   final Widget child;
//   final bool showActionEdit;
//   final bool showActionMore;
//   final Function(SlidableAction action) onDismissed;
//
//   const SlidableWidget({
//     @required this.showActionEdit,
//     @required this.showActionMore,
//     @required this.child,
//     @required this.onDismissed,
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Slidable(
//         actionPane: SlidableDrawerActionPane(),
//         child: child,
//
//         /// left side
//        // actions: <Widget>[
//           // IconSlideAction(
//           //   caption: 'Archive',
//           //   color: Colors.blue,
//           //   icon: Icons.archive,
//           //   onTap: () => onDismissed(SlidableAction.archive),
//           // ),
//           // IconSlideAction(
//           //   caption: 'Share',
//           //   color: Colors.indigo,
//           //   icon: Icons.share,
//           //   onTap: () => onDismissed(SlidableAction.share),
//           // ),
//        // ],
//
//         /// right side
//         secondaryActions: <Widget>[
//           Visibility(
//             visible: showActionMore == true,
//             child: IconSlideAction(
//               caption: 'More',
//               color: Colors.black45,
//               icon: Icons.more_horiz,
//               onTap: () => onDismissed(SlidableAction.more),
//             ),
//           ),
//           Visibility(
//             visible: showActionEdit == true,
//             child: IconSlideAction(
//               caption: 'Edit',
//               color: Colors.black45,
//               icon: Icons.edit,
//               onTap: () => onDismissed(SlidableAction.edit),
//             ),
//           ),
//           IconSlideAction(
//             caption: 'Delete',
//             color: Colors.red,
//             icon: Icons.delete,
//             onTap: () => onDismissed(SlidableAction.delete),
//           ),
//         ],
//       );
// }
