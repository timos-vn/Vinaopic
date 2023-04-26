import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:vinaoptic/models/network/request/update_order_request.dart';
import 'package:vinaoptic/models/network/response/item_order_detail_response.dart' as itemOrder;
import 'package:vinaoptic/models/network/request/send_invoice_request.dart';
import 'package:vinaoptic/models/network/response/item_scan.dart';

abstract class DetailOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class OrderBillEvent extends DetailOrderEvent {
  final List<Detail> listBillDetail;
  final String nameCustomer;
  final String phoneCustomer;
  final String addressCustomer;
  final String note;
  final String birthDay;

  OrderBillEvent(this.listBillDetail,this.nameCustomer,this.phoneCustomer,this.addressCustomer,this.note,this.birthDay);

  @override
  String toString() {
    return 'OrderBillEvent{listBillDetail: $listBillDetail}';
  }
}
class UpdateOrderEvent extends DetailOrderEvent {
  final List<UpdateOrderRequestDetail>? listBillDetail;
  final String? sttRec;
  final CqDetail? cpDetail;
  final File? image;
  UpdateOrderEvent({this.listBillDetail,this.sttRec,this.cpDetail,this.image});

  @override
  String toString() {
    return 'OrderBillEvent{listBillDetail: $listBillDetail}';
  }
}
class CheckListProductOrderEvent extends DetailOrderEvent {
  final List<ItemScanData> listBillDetail;
  CheckListProductOrderEvent(this.listBillDetail);

  @override
  String toString() {
    return 'CheckListProductOrderEvent{listBillDetail: $listBillDetail}';
  }
}
class GetListItemProductEvent extends DetailOrderEvent {
  final List<ItemScanData> listBillDetail;
  GetListItemProductEvent(this.listBillDetail);

  @override
  String toString() {
    return 'GetListItemProductEvent{listBillDetail: $listBillDetail}';
  }
}
class CheckDataEvent extends DetailOrderEvent {
  final String? maKH;
  final List<ItemScanData>? listItemScanData;
  final List<itemOrder.Detail>? listItemDetail;

  CheckDataEvent(this.maKH,{this.listItemScanData,this.listItemDetail});

  @override
  String toString() {
    return 'OrderBillEvent{maKH: $maKH}';
  }
}
class GetItemDetailEvent extends DetailOrderEvent {
  final String sttRec;


  GetItemDetailEvent(this.sttRec);

  @override
  String toString() {
    return 'GetItemDetailEvent{sttRec: $sttRec}';
  }
}
class CreatesCustomerEvent extends DetailOrderEvent {

  final String? phoneNumber;
  final String? fullName;
  final String? birthday;
  final int? sex;
  final String? address;
  final String? idCustomer;
  final String? email;
  final String? avatar;

  CreatesCustomerEvent({this.phoneNumber, this.fullName, this.birthday, this.sex, this.address, this.idCustomer, this.email, this.avatar});

  @override
  String toString() => 'CreatesCustomerEvent {}';
}
class PickDate extends DetailOrderEvent {

  final DateTime dateTime;

  PickDate(this.dateTime);

  @override
  String toString() {
    return 'PickDate{}';
  }
}
class CalculatorMoneyEvent extends DetailOrderEvent {
  final List<ItemScanData> listItemScanData;

  CalculatorMoneyEvent(this.listItemScanData);

  @override
  String toString() {
    return 'CalculatorMoneyEvent{}';
  }
}
class CalculatorMoneyItemDetailEvent extends DetailOrderEvent {
  final List<itemOrder.Detail> listItemScanData;

  CalculatorMoneyItemDetailEvent(this.listItemScanData);

  @override
  String toString() {
    return 'CalculatorMoneyItemDetailEvent{}';
  }
}