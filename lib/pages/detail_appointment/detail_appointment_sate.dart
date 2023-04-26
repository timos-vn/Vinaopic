import 'package:equatable/equatable.dart';

abstract class DetailAppointmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailAppointmentInitial extends DetailAppointmentState {

  @override
  String toString() => 'NewsInitial';
}

class DetailAppointmentLoading extends DetailAppointmentState {

  @override
  String toString() => 'DetailAppointmentLoading';
}

class DetailAppointmentFailure extends DetailAppointmentState {
  final String error;

  DetailAppointmentFailure(this.error);

  @override
  String toString() => 'DetailAppointmentFailure { error: $error }';
}


class GetDetailAppointmentSuccess extends DetailAppointmentState {

  @override
  String toString() {
    return 'GetDetailAppointmentSuccess{}';
  }
}
