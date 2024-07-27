import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/log.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/response/item_scan.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'qr_code_event.dart';
import 'qr_code_sate.dart';

class QRCodeBloc extends Bloc<QRCodeEvent,QRCodeState>{


  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  bool isEnableScan = true;
  bool isGrantCamera = false;
  List<ItemScanData> listChildItemSelected = [];


  QRCodeBloc(this.context) : super(QRCodeInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);

    on<ScanItemEvent>(_scanItemEvent);
    on<GetCameraEvent>(_getCameraEvent);
  }

  void _scanItemEvent(ScanItemEvent event, Emitter<QRCodeState> emitter)async{
    emitter(QRCodeLoading());
    if (Utils.isEmpty(event.scanCode) || !isEnableScan || listChildItemSelected.indexWhere((e) => e.maVt  == event.scanCode) >= 0) {
      emitter(QRCodeInitial());
      return;
    }
    isEnableScan = false;
    Future.delayed(Duration(seconds: 3), () => isEnableScan = true);
    // List<BillDetail> listBillDetail = List();
    // listChildItemSelected.forEach((item) {
    //   listBillDetail.add(BillDetail(itemCode: item.itemCode, quantity: item.quantity));
    // });

    QRCodeState state = _handleScanItem(await _networkFactory!.scanCodeByShopUser(_accessToken.toString(),event.scanCode));
    emitter(state);
  }

  void _getCameraEvent(GetCameraEvent event, Emitter<QRCodeState> emitter)async{
    emitter(QRCodeLoading());
    Map<Permission, PermissionStatus> permissionRequestResult =
    await [Permission.camera].request();
    if (permissionRequestResult[Permission.camera] == PermissionStatus.granted) {
      isGrantCamera = true;
      emitter(GrantCameraPermission());
    } else {
      if (await Permission.camera.isPermanentlyDenied) {
        openAppSettings();
        emitter(QRCodeInitial());
      } else {
        isGrantCamera = false;
        emitter(QRCodeFailure('Vui lòng cấp quyền truy cập Camera'));
      }
    }
  }

  QRCodeState _handleScanItem(Object data) {
    if (data is String) return QRCodeFailure(data);
    try {
      ItemScan response = ItemScan.fromJson(data as Map<String,dynamic>);
      listChildItemSelected.add(response.data!);
      isEnableScan = true;
      return ScanItemSuccess();
    } catch (e) {
      logger.e(e.toString());
      return QRCodeFailure(e.toString());
    }
  }
}