import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../models/network/response/info_store_response.dart';

class Const {
  /// DF server
  // ignore: non_constant_identifier_names
  static  String HOST_URL = "https://api-vinaoptic.sse.net.vn";
  // ignore: non_constant_identifier_names
  static  int PORT_URL = 0;

  /// DF base URL Dio
  static const String HOST_GOOGLE_MAP_URL = "https://maps.googleapis.com/maps/api/";

  /// DF name router
  static const String SplashPageRouter = '/SplashPageRouter';
  static const String LoginPageRouter = '/LoginPageRouter';
  static const String MainPageRouter = '/MainPageRouter';
  static const String HomePageRouter = '/HomePageRouter';
  static const String ReportPageRouter = '/ReportPageRouter';
  static const String ApprovalPageRouter = '/ApprovalPageRouter';
  static const String OrderPageRouter = '/OrderPageRouter';
  static const String SettingPageRouter = '/SettingPageRouter';

  static const HOME = 0;
  static const QR_CODE = 1;
  static const NEW_CUSTOMER = 2;
  static const CART = 3;
  static const NEWS = 4;

  static const String ACTION_UPDATE = '1';
  static const String ACTION_DELETE = '4';
  static const String TYPE_ONE = '1';
  static const String TYPE_ALL = '0';

  static const String BAR_CHART = 'bar';
  static const String PIE_CHART = 'pie';
  static const String LINE_CHART = 'line';

  static const String CHART = 'C';
  static const String TABLE = 'G';

  static TextInputFormatter FORMAT_DECIMA_NUMBER = FilteringTextInputFormatter.deny(RegExp('[\\-|\\ |\\/|\\*|\$|\\#|\\+|\\|]'));
  static const String DATE_FORMAT = "dd/MM/yyyy";
  static const String DATE_TIME_FORMAT_LOCAL = "dd/MM/yyyy HH:mm:ss";
  static const String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
  static const String DATE_FORMAT_1 = "dd-MM-yyyy";
  static const String DATE_SV = "yyyy-MM-dd'T'HH:mm:ss";
  static const String DATE_SV_FORMAT = "yyyy/MM/dd";
  static const String DATE_SV_FORMAT_1 = "MM/dd/yyyy";
  static const String DATE_SV_FORMAT_2 = "yyyy-MM-dd";
  static const String DATE = "EEE";
  static const String DAY = "dd";
  static const String YEAR = "yyyy";
  static const String TIME = "hh:mm aa";
  static const String REFRESH = "REFRESH";
  static const String DEFAULT_LANGUAGE = 'Default Language';
  static const String CODE_LANGUAGE = 'Code Lang';
  static const String Name_LANGUAGE = 'Name Lang';
  static const String DEVICE_TOKEN = "Device Token";
  static const String TOPIC = "TOPIC";

  static const int MAX_COUNT_ITEM = 10;

  static const String ACCESS_TOKEN = "Token";
  static const String REFRESH_TOKEN = "Refresh token";
  static const String USER_ID = 'User id';
  static const String ID_UNIT = 'Unit id';
  static const String PASS_WORD = 'Password';
  static const String USER_NAME = "User name";
  static const String FULL_NAME = "Full name";
  static const String HOST_ID = "Host id";
  static const String CODE = "Code";
  static const String CODE_NAME = "Code name";
  static const String ROLE = "Role";
  static const String PHONE_NUMBER = "Phone number";
  static const String EMAIL = "Email";
  static const String COMPANIES_NAME = 'Company name';
  static const String UNITS_NAME = 'Unit name';
  static const String STORES_NAME = 'Store name';
  static const String COMPANIES_ID = 'Company id';
  static const String UNITS_ID = 'Unit id';
  static const String DOB = "dob";
  static const String STORES_ID = 'Store id';
  static const String LIST_TIME_NAME = 'List Time Name';
  static const String LIST_TIME_ID = 'List Time Id';

  static GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();
// static const String UNITS = 'Unit';
// static const String STORES = 'Store';
/// Data
  static List<InfoStoreResponseData> listInfoStore = [];
}
