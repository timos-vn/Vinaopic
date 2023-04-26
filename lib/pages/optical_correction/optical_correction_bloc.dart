import 'dart:io';
import 'package:get/get.dart' as libGet;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'optical_correction_event.dart';
import 'optical_correction_state.dart';

class OpticalCorrectionBloc extends Bloc<OpticalCorrectionEvent,OpticalCorrectionState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();
  late File file = File('');
  final imagePicker =  ImagePicker();

  OpticalCorrectionBloc(this.context) : super(OpticalCorrectionInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);

    on<UploadAvatarEvent>(_uploadAvatarEvent);
  }

  void _uploadAvatarEvent(UploadAvatarEvent event, Emitter<OpticalCorrectionState> emitter)async{
    emitter(OpticalCorrectionLoading());
    final image = await imagePicker.getImage(source: ImageSource.camera,imageQuality: 65);
    file = File(image!.path);
    emitter(PickAvatarSuccess());
  }
}