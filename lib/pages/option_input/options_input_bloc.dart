import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'options_input_event.dart';
import 'options_input_state.dart';

class OptionsInputBloc extends Bloc<OptionsInputEvent, OptionsInputState> {
  String? unitId;
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  int _status = 0;
  int get status => _status;
  DateTime _dateFrom = DateTime.now().subtract(Duration(days: 7));
  DateTime _dateTo= DateTime.now();
  List<String> _listTimeId = [];
  List<String> _listTimeName = [];

  List<String> get listTimeId => _listTimeId;
  List<String> get listTimeName => _listTimeName;
  DateTime get dateFrom => _dateFrom;
  DateTime get dateTo => _dateTo;

  OptionsInputBloc(this.context) : super(InitialOptionsInputState()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<DateFrom>(_dateFromEvent);
    on<DateTo>(_dateToEvent);

  }

  bool checkDate() {
    if (dateFrom.isBefore(dateTo)) {
      return true;
    } else {
      return false;
    }
  }

   DateTime stringToDate(String date) {
     return DateTime.parse(date);
   }

  String getStringFromDate(DateTime date) {
    return Utils.parseDateToString(date, Const.DATE_FORMAT);
  }

  String getStringFromDateYMD(DateTime date) {
    return Utils.parseDateToString(date, Const.DATE_SV_FORMAT);
  }

  void _dateFromEvent(DateFrom event, Emitter<OptionsInputState> emitter)async{
    emitter(InitialOptionsInputState());
    _dateFrom = event.date;
    emitter(PickDateSuccess());
    return;
  }

  void _dateToEvent(DateTo event, Emitter<OptionsInputState> emitter)async{
    emitter(InitialOptionsInputState());
    _dateTo = event.date;
    emitter(PickDateSuccess());
    return;
  }
}