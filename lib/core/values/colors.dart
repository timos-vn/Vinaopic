import 'package:flutter/material.dart';

final primaryColor = Color(0xffe74b32);

final whiteAccentColor = Color(0xffFAFAFA);

const Color transparent = Colors.transparent;
const Color accent = Color(0xff5c616e);
const Color black = Colors.black;
const Color blackBlur = Colors.black45;
const Color white = Colors.white;
const Color lightBlue = Colors.lightBlue;
const Color blueAccent = Colors.blueAccent;
const Color greenAccent = Colors.greenAccent;
const Color dark_text = Color(0xFFB8B8B8);
const Color grey = Colors.grey;
Color? grey_200 = Colors.grey[200];
Color? grey_100 = Colors.grey[100];
const Color red = Colors.red;
const Color blue = Color(0xff1F346D);
const Color nearlyDarkBlue = Color(0xFF2633C5);
const Color orange =  Color(0xfffb9d14);
Color textFieldColor = const Color.fromRGBO(168, 160, 149, 0.6);
const Color backgroundColor = const Color(0xffeeeeee);
const Color whiteColor = const Color(0XFFFFFFFF);
const Color blackColor = const Color(0XFF242A37);
const Color greyColor = const Color(0XFFF1F2F6);
const Color greyColor2 = Colors.grey;
const Color activeColor = const Color(0xFFF44336);
const Color redColor = const Color(0xFFFF0000);
const Color buttonStop = const Color(0xFFF44336);
const Color secondary = const Color(0xFFFF8900);
const Color facebook = const Color(0xFF4267b2);
const Color googlePlus = const Color(0xFFdb4437);
const Color yellow = Colors.pinkAccent;
const Color green1 = Colors.lightGreen;
const Color green2 = Colors.green;
const Color blue1 = Colors.lightBlue;
const Color blue2 = Colors.blue;
const Color tim = Colors.deepPurple;
const Color greenColor = const Color(0xFF00c497);
const Color tim2 = Colors.deepPurpleAccent;
final mainColor = HexColor("#5685FE");


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

const MaterialColor jetblack =
    const MaterialColor(0xff000000, const <int, Color>{
  50: const Color(0xff000000),
  100: const Color(0xff000000),
  200: const Color(0xff000000),
  300: const Color(0xff000000),
  400: const Color(0xff000000),
  500: const Color(0xff000000),
  600: const Color(0xff000000),
  700: const Color(0xff000000),
  800: const Color(0xff000000),
  900: const Color(0xff000000),
});
