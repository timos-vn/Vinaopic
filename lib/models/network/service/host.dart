import 'package:vinaoptic/core/untils/const.dart';

class HostSingleton {
  String host = Const.HOST_URL;
  int port = Const.PORT_URL;

  static final HostSingleton _singleton = new HostSingleton._internal();


  factory HostSingleton() {

    return _singleton;
  }

  HostSingleton._internal() {}

  void showError(){
   print('test connection show Error');
   print( host +':'+ port.toString());
  }
}