import 'package:equatable/equatable.dart';

abstract class MakeAppointmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatesMakeAppointmentEvent extends MakeAppointmentEvent {

  final String phoneNumber;
  final String fullName;
  final String birthday;
  final int sex;
  final String date;
  final String idStore;
  final String address;
  final String email;
  final String note;
  final String status;
  final bool traPhi;

  final String idProvince;
  final String idDistrict;
  final String idCommune;
  final String maKH;
  final int createNewCustomer;


  CreatesMakeAppointmentEvent(this.phoneNumber, this.fullName, this.birthday,
      this.sex,this.date,this.idStore, this.address,  this.email, this.note,this.status,this.traPhi,
  {required  this.idProvince,required this.idDistrict,required this.idCommune, required this.maKH, required this.createNewCustomer}
      );

  @override
  String toString() => 'CreatesMakeAppointmentEvent {}';
}
class PickDate extends MakeAppointmentEvent {

  final DateTime dateTime;

  PickDate(this.dateTime);

  @override
  String toString() {
    return 'PickDate{}';
  }
}
class UploadAvatarEvent extends MakeAppointmentEvent {
  final bool isUploadFromCamera;

  UploadAvatarEvent(this.isUploadFromCamera);

  @override
  String toString() {
    return 'UploadAvatarEvent{isUploadFromCamera: $isUploadFromCamera}';
  }
}
class CreatesCustomer extends MakeAppointmentEvent {

  final String phoneNumber;
  final String fullName;
  final String birthday;
  final int sex;
  final String address;
  final String idCustomer;
  final String email;
  final String avatar;

  CreatesCustomer(this.phoneNumber, this.fullName, this.birthday, this.sex, this.address, this.idCustomer, this.email, this.avatar);

  @override
  String toString() => 'CreatesCustomer {}';
}

class DateFrom extends MakeAppointmentEvent {
  final DateTime date;

  DateFrom(this.date);

  @override
  String toString() {
    // TODO: implement toString
    return 'DateFrom{}';
  }
}
class GetListStore extends MakeAppointmentEvent {

  @override
  String toString() {
    // TODO: implement toString
    return 'GetListStore{}';
  }
}