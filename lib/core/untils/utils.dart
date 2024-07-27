// import 'package:bmprogresshud/progresshud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'dart:convert';
import 'dart:io';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../widget/custom_toast.dart';
import '../values/colors.dart';

class Utils {

  static Future<DateTime?> dateTimePickerCustom(BuildContext context) async {
    DateTime? dateTime = DateTime.now();
    dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      type: OmniDateTimePickerType.date,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    return dateTime;
  }

  static String convertKeySearch(String keySearch) {
    String convertString = '';
    if(keySearch.contains(' ')){
      convertString = '';
      List<String> listConvert = keySearch.split(' ');
      print(listConvert.length);
      for (int index = 0;index < listConvert.length; index++) {
        if(index == 0){
          convertString = "{i} like N'%${listConvert[index]}%'";
        }else{
          convertString += " and {i} like N'%${listConvert[index]}%'";
        }
      }}
    else{
      convertString = convertString = "{i} like N'%$keySearch%'";
    }
    return convertString.toString();
  }

  static void showCustomToast(BuildContext context,IconData icon, String title){
    showToastWidget(
      customToast(context, icon, title),
      duration: const Duration(seconds: 3),
      onDismiss: () {},
    );
  }

  static void onLoading(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: new Center(child: CircularProgressIndicator(),)
        );
      },
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
    });
  }

  // static showLoadingHud(BuildContext context,GlobalKey<ProgressHudState> _hudKey) async {
  //   ProgressHud.of(context).show(ProgressHudType.loading, "loading...");
  //   await Future.delayed(const Duration(seconds: 1));
  //   _hudKey.currentState?.dismiss();
  // }

  static void onLoading2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Theme(data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                child: CupertinoActivityIndicator()),
          )
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
    });
  }



  static paint(Canvas canvas) {
    final p1 = Offset(50, 50);
    final p2 = Offset(250, 150);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  static String? base64Image(File file) {
    if (file == null) return null;
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showNotifySnackBar(BuildContext context, String text) {
    onWidgetDidBuild(() => showSnackBar(context, text));
  }


  static Future pushAndRemoveUtilPage(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
            (Route<dynamic> route) => false);
  }

  static void popUtilRoot(BuildContext context) {
    return Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  static void popUtil(BuildContext context) {
    return Navigator.of(context).popUntil((Route<dynamic> route) => false);
  }

  static Future pushAndRemoveUtilKeepFirstPage(
      BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  static navigateNextFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static bool isEmpty(Object text) {
    if (text is String) return text.isEmpty;
    if (text is List) return text.isEmpty;
    return text == null;
  }

  // static void showToast(String text) {
  //   if (Utils.isEmpty(text))
  //     return;
  //   Fluttertoast.showToast(msg: text, backgroundColor: accent,gravity: ToastGravity.CENTER,);
  // }

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

  static String formatNumber(num amount) {
    return isInteger(amount) ? amount.toStringAsFixed(0) : amount.toString();
  }

  static String formatMoney(dynamic amount) {
    return NumberFormat.simpleCurrency(locale: "vi_VN").format(amount)
        .replaceAll(' ', '').replaceAll('.', ' ')
        .replaceAll('₫', '');
  }

  static String formatTotalMoney(dynamic amount) {

    String totalMoney = NumberFormat.simpleCurrency(locale: "vi_VN").format(amount)
        .replaceAll(' ', '').replaceAll('.', '.')
        .replaceAll('₫', '').toString();
    if(totalMoney.split(' ').length == 1 || totalMoney.split(' ').length == 2){
      return totalMoney;
    }else{
      return totalMoney.split(' ')[0] + ' '+ totalMoney.split(' ')[1];
    }
  }

  static DateTime parseStringToDate(String dateStr, String format) {
    DateTime date = DateTime.now();
    try {
      date = DateFormat(format).parse(dateStr);
    } on FormatException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return date;
  }

  static String parseDateTToString(String dateInput,String format){
    String date = "";
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(dateInput);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(format);
    date = outputFormat.format(inputDate);
    return date;
  }

  static String parseStringDateToString(String dateSv, String fromFormat, String toFormat) {
    String date = "";
    try {
      date = DateFormat(toFormat, "en_US")
          .format(DateFormat(fromFormat).parse(dateSv));
    } on FormatException catch (e) {
      print(e);
    }
    return date;
  }
  static String parseDateToString(DateTime dateTime, String format) {
    String date = "";
    try {
      date = DateFormat(format).format(dateTime);
    } on FormatException catch (e) {
      print(e);
    }
    return date;
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget, ));
  }

  static void showSnackBar(BuildContext context, String text) {
    if (Utils.isEmpty(text))
      return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: primaryColor,
    );
    Scaffold.of(context).showBottomSheet((context) => snackBar);
  }

  static void showForegroundNotification(BuildContext context, String title, String text, {VoidCallback? onTapNotification}) {
    showOverlayNotification((context) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: SafeArea(
            bottom: false,
            child: InkWell(
              onTap: () {
                OverlaySupportEntry.of(context)!.dismiss();
                onTapNotification!();
              },
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(child: Image.asset(icLogo))),
                title: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(text),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context)!.dismiss();
                    }),
              ),
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 4000));
  }

  static void showDialogTwoButton(
      {required BuildContext context,
        String? title,
        required Widget contentWidget,
        required List<Widget> actions,
        bool dismissible = false}) =>
      showDialog(
          barrierDismissible: dismissible,
          context: context,
          builder: (context) {
            return AlertDialog(
                title: title != null ? Text(title) : null,
                content: contentWidget,
                actions: actions);
          });
}