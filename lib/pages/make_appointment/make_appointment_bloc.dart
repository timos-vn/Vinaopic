import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/creates_customer_request.dart';
import 'package:vinaoptic/models/network/request/creates_make_appointment_request.dart';
import 'package:vinaoptic/models/network/response/info_store_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'make_appointment_event.dart';
import 'make_appointment_sate.dart';

class MakeAppointmentBloc extends Bloc<MakeAppointmentEvent,MakeAppointmentState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();


  DateTime _dateFrom = DateTime.now();
  DateTime get dateFrom => _dateFrom;
  String unitId = '';
  // List<InfoStoreResponseData> listInfoStore = [];
  List<String> listPhieu = ['Phiếu khám', 'Phiếu mua hàng', 'Phiếu sửa chữa'];
  // String _dob;
  // String get dob => Utils.parseStringDateToString(
  //     _dob, Const.DATE_SV_FORMAT, Const.DATE_SV_FORMAT);
  DateTime _dobDate = DateTime.now();
  DateTime get dobDate => _dobDate;
  late File file = File('');
  final imagePicker = ImagePicker();


  MakeAppointmentBloc(this.context) : super(MakeAppointmentInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<DateFrom>(_dateFromEvent);
    on<CreatesMakeAppointmentEvent>(_createsMakeAppointmentEvent);
    on<GetListStore>(_getListStore);
    on<CreatesCustomer>(_createsCustomer);
    on<UploadAvatarEvent>(_uploadAvatarEvent);
    on<PickDate>(_pickDate);
  }

  void _dateFromEvent(DateFrom event, Emitter<MakeAppointmentState> emitter)async{
    emitter(MakeAppointmentLoading());
    _dateFrom = event.date;
    emitter(PickDateSuccess());
    return;
  }

  void _createsMakeAppointmentEvent(CreatesMakeAppointmentEvent event, Emitter<MakeAppointmentState> emitter)async{
    print(file.path.isNotEmpty);
    print(file.path);
    emitter(MakeAppointmentLoading());
    CreatesMakeAppointmentRequestBody requestBody = CreatesMakeAppointmentRequestBody(
        phoneNumber: event.phoneNumber.trim(),
        fullName: event.fullName,
        date: event.date == null ? DateFormat('yyyy-MM-dd').format(DateTime.now()) : event.date,
        userId: int.parse(userID.toString()),
        address: event.address,
        birthDay: event.birthday,
        sex: event.sex,
        unit: unitId,
        store: event.idStore,
        dienGiai: event.note == null ? null :event.note ,
        status: event.status,
        traPhi: event.traPhi == true ? 1 : 0,
        email: event.email,
        image: file.path.isNotEmpty ? Utils.base64Image(file) : null  ,
        idProvince: event.idProvince,
        idDistrict: event.idDistrict,
        idCommune: event.idCommune,
        maKH: event.maKH.toString().trim(),
        createNewCustomer: event.createNewCustomer
    );
    MakeAppointmentState state = _handleCreateMakeAppointment(await _networkFactory!.createsMakeAppointment(requestBody,_accessToken!));
    emitter(state);
  }

  void _getListStore(GetListStore event, Emitter<MakeAppointmentState> emitter)async{
    emitter(MakeAppointmentLoading());
    MakeAppointmentState state = _handleGetListStore (await _networkFactory!.getListStore(_accessToken!, unitId));
    emitter(state);
  }

  void _createsCustomer(CreatesCustomer event, Emitter<MakeAppointmentState> emitter)async{
    emitter(MakeAppointmentLoading());
    CreatesCustomerRequestBody requestBody = CreatesCustomerRequestBody(
      phoneNumber:event.phoneNumber,
      fullName: event.fullName,
      birthday:event.birthday,
      address: event.address,
      sex: event.sex,
      email: event.email.toString(),
      avatar: event.avatar,
      idCustomer: event.phoneNumber,
    );
    MakeAppointmentState state = _handleCreateCustomer(await _networkFactory!.createsCustomer(requestBody,_accessToken!));
    emitter(state);
  }

  void _uploadAvatarEvent(UploadAvatarEvent event, Emitter<MakeAppointmentState> emitter)async{
    emitter(MakeAppointmentLoading());
    final image = await imagePicker.getImage(source: ImageSource.camera,imageQuality: 65);
    file = File(image!.path);
    print(file);
    emitter(PickAvatarSuccess());
  }

  void _pickDate(PickDate event, Emitter<MakeAppointmentState> emitter)async{
    emitter(MakeAppointmentLoading());
    _dobDate = event.dateTime;
    // _dob = Utils.parseDateToString(_dobDate, Const.DATE_SV_FORMAT);
    emitter(PickDateSuccess());
  }


  MakeAppointmentState _handleGetListStore(Object data){
    if (data is String) return MakeAppointmentFailure(data);
    try{
      InfoStoreResponse response = InfoStoreResponse.fromJson(data as Map<String,dynamic>);
      // listInfoStore = response.stores ?? [];
      return GetLisStoreSuccess();
    }
    catch(e){
      print(e.toString());
      return MakeAppointmentFailure(e.toString());
    }
  }
  MakeAppointmentState _handleCreateCustomer(Object data){
    if (data is String) return MakeAppointmentFailure(data);
    try{
      return CreatesNewCustomerSuccess();
    }
    catch(e){
      print(e.toString());
      return MakeAppointmentFailure(e.toString());
    }
  }
  MakeAppointmentState _handleCreateMakeAppointment(Object data){
    if (data is String) return MakeAppointmentFailure(data);
    try{
      return CreatesMakeAppointmentNewsSuccess();
    }
    catch(e){
      print(e.toString());
      return MakeAppointmentFailure(e.toString());
    }
  }
}