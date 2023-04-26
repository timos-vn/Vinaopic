import 'package:equatable/equatable.dart';

abstract class DetailAppointmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class GetDetailAppointment extends DetailAppointmentEvent {
  final String sttRec;

  GetDetailAppointment(this.sttRec);

  @override
  String toString() {
    // TODO: implement toString
    return 'GetDetailAppointment{}';
  }
}