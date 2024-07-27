import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/models/network/response/detail_appointment_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'detail_appointment_event.dart';
import 'detail_appointment_sate.dart';

class DetailAppointmentBloc extends Bloc<DetailAppointmentEvent,DetailAppointmentState>{


  String? unitId;
  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  DateTime _dateFrom = DateTime.now();
  DateTime get dateFrom => _dateFrom;

  List<DetailAppointmentResponseData> listDetailAppointment = [];

  DetailAppointmentBloc(this.context) : super(DetailAppointmentInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<GetDetailAppointment>(_getDetailAppointment);

  }

  void _getDetailAppointment(GetDetailAppointment event, Emitter<DetailAppointmentState> emitter)async{
   emitter(DetailAppointmentLoading());
   DetailAppointmentState state = _handleGetListStore (await _networkFactory!.getDetailAppointment(_accessToken.toString(), event.sttRec));
   emitter(state);
  }

  DetailAppointmentState _handleGetListStore(Object data){
    if (data is String) return DetailAppointmentFailure(data);
    try{
      DetailAppointmentResponse response = DetailAppointmentResponse.fromJson(data as Map<String,dynamic>);
      listDetailAppointment = response.data!;
      return GetDetailAppointmentSuccess();
    }
    catch(e){
      print(e.toString());
      return DetailAppointmentFailure(e.toString());
    }
  }
}