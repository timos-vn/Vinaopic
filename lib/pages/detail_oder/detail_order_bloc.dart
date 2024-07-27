import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/log.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/models/network/request/creates_customer_request.dart';
import 'package:vinaoptic/models/network/request/send_invoice_request.dart';
import 'package:vinaoptic/models/network/request/update_order_request.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'package:vinaoptic/models/network/response/item_order_detail_response.dart' as itemOrder;
import 'detail_order_event.dart';
import 'detail_order_state.dart';

class DetailOrderBloc extends Bloc<DetailOrderEvent,DetailOrderState>{

  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();


  num total=0;
  num ck = 0;
  String _dob = '';

  String unitId = '';
  String get dob => Utils.parseStringDateToString(
      _dob, Const.DATE_SV_FORMAT, Const.DATE_SV_FORMAT);
  DateTime _dobDate = DateTime.now();
  DateTime get dobDate => _dobDate;
  List<itemOrder.Master> listMaster = [];
  List<itemOrder.Detail> listProduct = [];


  DetailOrderBloc(this.context) : super(DetailOrderInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    unitId = box.read(Const.UNITS_ID);

    on<CheckDataEvent>(_checkDataEvent);
    on<PickDate>(_pickDate);
    on<OrderBillEvent>(_orderBillEvent);
    on<UpdateOrderEvent>(_updateOrderEvent);
    on<CheckListProductOrderEvent>(_checkListProductOrderEvent);
    on<CalculatorMoneyEvent>(_calculatorMoneyEvent);
    on<CalculatorMoneyItemDetailEvent>(_calculatorMoneyItemDetailEvent);
    on<CreatesCustomerEvent>(_createsCustomerEvent);
    on<GetItemDetailEvent>(_getItemDetailEvent);
  }

  void _checkDataEvent(CheckDataEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    if(event.listItemScanData != null && event.listItemDetail == null){
      event.listItemScanData!.forEach((element) {
        num chietKhau = (element.gia! * element.tlCk!)/100;
        ck = ck + element.tlCk!;
        total = total + (element.gia! - chietKhau) * element.soLuong!;
      });
    }
    else if(event.listItemScanData == null && event.listItemDetail != null){

      event.listItemDetail!.forEach((element) {
        num chietKhau = (element.giaNt2! * element.tlCk!)/100;
        ck = ck + element.tlCk!;
        total = total + (element.giaNt2! - chietKhau) * element.soLuong!;
      });
    }
    if(event.maKH == null){
      emitter(CheckScanDataSuccess());
    }else {
      emitter(DetailOrderInitial());
    }
  }

  void _pickDate(PickDate event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    _dobDate = event.dateTime;
    _dob = Utils.parseDateToString(_dobDate, Const.DATE_SV_FORMAT);
    emitter(PickDateSuccess());
  }

  void _orderBillEvent(OrderBillEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    Master master = Master(
        phone: event.phoneCustomer,
        fullName: event.nameCustomer,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        address:event.addressCustomer,
        dienGiai: event.note,
        maNt: 'VND',
        birthDay: event.birthDay,
        tyGia: 1
    );

    SendInvoiceRequest request = SendInvoiceRequest(
        data: SendInvoiceRequestBody(
            master: master,
            detail: event.listBillDetail
        )
    );

    DetailOrderState state = _handleOrderBill(await _networkFactory!.sendInvoices(request,_accessToken!));
    emitter(state);
  }

  void _updateOrderEvent(UpdateOrderEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    UpdateOrderRequest request = UpdateOrderRequest(
        sttRec: event.sttRec,
        detail: event.listBillDetail,
        cqDetail: event.cpDetail,
        image: event.image != null ?  Utils.base64Image(event.image!) : ''
    );
    DetailOrderState state = _handleUpdateOrderBill(await _networkFactory!.updateInvoice(request,_accessToken!));
    emitter(state);
  }

  void _checkListProductOrderEvent(CheckListProductOrderEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    if(!Utils.isEmpty(listProduct)){
      List<itemOrder.Detail> _listItemCheck = [];

      event.listBillDetail.forEach((element) {
        var contain = listProduct.where((itemProduct){
          if(itemProduct.maVt.toString().trim() == element.maVt.toString().trim()){
            itemOrder.Detail _item = itemOrder.Detail(
                maVt: itemProduct.maVt.toString().trim(),dvt: itemProduct.dvt,soLuong: (itemProduct.soLuong! + element.soLuong!),
                giaNt2: itemProduct.giaNt2,tienNt2: itemProduct.tienNt2,tlCk: itemProduct.tlCk,ckNt: itemProduct.ckNt,
                maKho: itemProduct.maKho,tenVt: itemProduct.tenVt,nuocSx: itemProduct.nuocSx
            );
            _listItemCheck.add(_item);
          }
          if(itemProduct.maVt.toString().trim() != element.maVt.toString().trim()){
            itemOrder.Detail _item = itemOrder.Detail(
                maVt: element.maVt.toString().trim(),dvt: element.dvt,soLuong: (element.soLuong),
                giaNt2: element.gia,tienNt2: 0,tlCk: element.tlCk,ckNt: 0,
                maKho: element.maKho,tenVt: element.tenVt,nuocSx: element.nuocSx
            );
            _listItemCheck.add(_item);
          }
          return true;
        });
        print("CTN: ${contain.toString()}");
        // listProduct.forEach((itemProduct) {
        //   if (itemProduct.maVt.toString().trim() == element.maVt.toString().trim()) {
        //     itemOrder.Detail _item = itemOrder.Detail(
        //         maVt: itemProduct.maVt.toString().trim(),dvt: itemProduct.dvt,soLuong: (itemProduct.soLuong + element.soLuong),
        //         giaNt2: itemProduct.giaNt2,tienNt2: itemProduct.tienNt2,tlCk: itemProduct.tlCk,ckNt: itemProduct.ckNt,
        //         maKho: itemProduct.maKho,tenVt: itemProduct.tenVt,nuocSx: itemProduct.nuocSx
        //     );
        //     _listItemCheck.add(_item);
        //   }
        //   else{
        //     itemOrder.Detail _item = itemOrder.Detail(
        //         maVt: element.maVt.toString().trim(),dvt: element.dvt,soLuong: ( element.soLuong),
        //         giaNt2: element.gia,tienNt2: 0,tlCk: element.tlCk,ckNt: 0,
        //         maKho: element.maKho,tenVt: element.tenVt,nuocSx: element.nuocSx
        //     );
        //     _listItemCheck.add(_item);
        //   }
        // });
      });

      _listItemCheck.forEach((e) {
        listProduct.removeWhere((pro) => pro.maVt.toString().trim() == e.maVt.toString().trim());
        print("SL ItemCheck: ${e.soLuong}");
        listProduct.add(e);
      });
    }
    else{

      List<itemOrder.Detail> _listItemCheck = [];
      print('CheckLeng: ${ event.listBillDetail.length}');
      event.listBillDetail.forEach((element) {
        itemOrder.Detail _item = itemOrder.Detail(
            maVt: element.maVt.toString().trim(),dvt: element.dvt,soLuong: (element.soLuong),
            giaNt2: element.gia,tienNt2: 0,tlCk: element.tlCk,ckNt: 0,
            maKho: element.maKho,tenVt: element.tenVt,nuocSx: element.nuocSx
        );
        _listItemCheck.add(_item);
      });
      _listItemCheck.forEach((e) {
        //listProduct.removeWhere((pro) => pro.maVt.trim() == e.maVt.trim());
        print("SL ItemCheck1: ${e.soLuong}");
        listProduct.add(e);
      });
    }
    emitter(GetDetailOrderSuccess());
  }

  void _calculatorMoneyEvent(CalculatorMoneyEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    total = 0;ck=0;
    event.listItemScanData.forEach((element) {
      num chietKhau = (element.gia! * element.tlCk!)/100;
      ck = ck + element.tlCk!;
      total = total + (element.gia! - chietKhau) * element.soLuong!;
    });
    print(total);
    emitter(CalculatorMoneySuccess());
  }

  void _calculatorMoneyItemDetailEvent(CalculatorMoneyItemDetailEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    total = 0;ck=0;
    event.listItemScanData.forEach((element) {
      num chietKhau = (element.giaNt2! * element.tlCk!)/100;
      ck = ck + element.tlCk!;
      total = total + (element.giaNt2! - chietKhau) * element.soLuong!;
    });
    print(total);
    emitter(CalculatorMoneySuccess());
  }

  void _createsCustomerEvent(CreatesCustomerEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    CreatesCustomerRequestBody requestBody = CreatesCustomerRequestBody(
      phoneNumber:event.phoneNumber,
      fullName: event.fullName??"",
      birthday:event.birthday??"",
      address: event.address??"",
      sex: event.sex??1,
      email: event.email??"",
      avatar: event.avatar??"",
      idCustomer: event.phoneNumber,
    );

    DetailOrderState state = _handleCreateCustomer(await _networkFactory!.createsCustomer(requestBody,_accessToken!));
    emitter(state);
  }

  void _getItemDetailEvent(GetItemDetailEvent event, Emitter<DetailOrderState> emitter)async{
    emitter(DetailOrderLoading());
    DetailOrderState state = _handleGetDetailOrder(await _networkFactory!.getDetailOrder(_accessToken!,event.sttRec));
    emitter(state);
  }

  DetailOrderState _handleGetDetailOrder(Object data){
    if (data is String) return DetailOrderFailure(data);
    try{
      itemOrder.ItemOrderDetailResponse response = itemOrder.ItemOrderDetailResponse.fromJson(data as Map<String,dynamic>);
      listMaster = response.data!.master!;
      listProduct = response.data!.detail!;
      return GetDetailOrderSuccess();
    }
    catch(e){
      print(e.toString());
      return DetailOrderFailure(e.toString());
    }
  }

  DetailOrderState _handleCreateCustomer(Object data){
    if (data is String) return DetailOrderFailure(data);
    try{
      return CreateNewsCustomerSuccess();
    }
    catch(e){
      print(e.toString());
      return DetailOrderFailure(e.toString());
    }
  }

  DetailOrderState _handleOrderBill(Object data) {
    if (data is String) return DetailOrderFailure(data);
    try {
      return SendInvoiceSuccess();
    } catch (e) {
      logger.e(e.toString());
      return DetailOrderFailure(e.toString());
    }
  }
  DetailOrderState _handleUpdateOrderBill(Object data) {
    if (data is String) return DetailOrderFailure(data );
    try {
      return UpdateOrderSuccess();
    } catch (e) {
      logger.e(e.toString());
      return DetailOrderFailure(e.toString());
    }
  }
}