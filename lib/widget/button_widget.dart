import 'package:flutter/material.dart';
import 'package:vinaoptic/core/values/colors.dart';

class ButtonWidget extends StatelessWidget {
  final Color? backgroundColor;
  final String title;
  final VoidCallback onPressed;
  final double? radius;
  final bool modeFlatButton;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  ButtonWidget(
      {this.backgroundColor,
      required this.title,
      required this.onPressed,
      this.radius,
      this.modeFlatButton = false,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [mainColor, Color(0xff8CC63F)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: white,
            fontSize: 16.0
          ),
        ),
      ),
    );
  }
}
