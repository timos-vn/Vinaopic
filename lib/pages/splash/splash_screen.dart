import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';

import '../login/login_screen.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      dispose: (_)=> print('Dispose Splash Page'),
      init: SplashController(),
      builder: (_)=> Scaffold(
        backgroundColor: white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250.0,
                height: 200.0,
                child: Image.asset(
                  icLogo,
                ),
              ),
              Text(
                'Dịch vụ tận tình - giải pháp thông minh',
                style: TextStyle(
                  fontSize: 16,
                  color: blue,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}

class SplashController extends GetxController{
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Future.delayed(Duration(seconds: 2),()=> Get.off(LoginScreen(),transition: Transition.zoom));
  }
}
