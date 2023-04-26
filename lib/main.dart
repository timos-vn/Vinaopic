import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oktoast/oktoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vinaoptic/pages/splash/splash_screen.dart';

import 'models/database/dbhelper.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(() {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget  {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DatabaseHelper db;
  final key = const ValueKey('my overlay');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      key: key,
      child: OKToast(
        child: GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales:const [
            Locale('vi', 'VN'),
            // arabic, no country code
          ],
          title: 'SSE DMS',
          theme: ThemeData(
            visualDensity:  VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),//InfoCPNScreen
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
