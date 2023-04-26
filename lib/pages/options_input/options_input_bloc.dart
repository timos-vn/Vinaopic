// ignore_for_file: unnecessary_null_comparison
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/untils/const.dart';
import '../../core/untils/utils.dart';
import 'options_input_event.dart';
import 'options_input_state.dart';

class OptionsInputBloc extends Bloc<OptionsInputEvent, OptionsInputState> {
  BuildContext context;
  String? _accessToken;
  String get accessToken => _accessToken!;
  String? _refreshToken;
  String get refreshToken => _refreshToken!;

  int _statusCode = 0;
  int get statusCode => _statusCode;
  String? statusName;
  DateTime _dateFrom = DateTime.now().subtract(const Duration(days: 7));
  DateTime _dateTo = DateTime.now();
  DateTime get dateFrom => _dateFrom;
  DateTime get dateTo => _dateTo;

  int status = 0;

  OptionsInputBloc(this.context) : super(InitialOptionsInputState()){
    on<OptionsInputEvent>(_inputDateFromTo);
    on<PickGenderStatus>(_pickGenderStatus);
  }

  void _inputDateFromTo(OptionsInputEvent event, Emitter<OptionsInputState> emitter)async{
    emitter(InitialOptionsInputState());
    if (event is DateFrom) {
      _dateFrom = event.date;
      if (_dateTo == null) {
        emitter(PickDateSuccess());
        return;
      }
    }
    if (event is DateTo) {
      _dateTo = event.date;
      if (_dateFrom == null) {
        emitter(PickDateSuccess());
        return;
      }
    }
    if (_dateFrom.add(const Duration(hours: -23)).isAfter(_dateTo)) {
      _dateTo = DateTime.now();
      emitter(WrongDate());
      return;
    }
  }

  void _pickGenderStatus(PickGenderStatus event, Emitter<OptionsInputState> emitter)async{
    emitter(InitialOptionsInputState());
    statusName = event.statusName;
    _statusCode = event.statusCode!;
    emitter(PickGenderStatusSuccess());
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

}