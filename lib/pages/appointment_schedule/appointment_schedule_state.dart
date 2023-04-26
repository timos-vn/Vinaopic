import 'package:equatable/equatable.dart';

abstract class AppointmentScheduleState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppointmentScheduleInitial extends AppointmentScheduleState {

  @override
  String toString() => 'AppointmentScheduleInitial';
}
class AppointmentScheduleLoading extends AppointmentScheduleState {

  @override
  String toString() => 'AppointmentScheduleLoading';
}
class GetListSuccess extends AppointmentScheduleState {

  @override
  String toString() => 'GetListSuccess';
}

class AppointmentScheduleFailure extends AppointmentScheduleState {
  final String error;

  AppointmentScheduleFailure(this.error);

  @override
  String toString() => 'AppointmentScheduleFailure { error: $error }';
}
class AppointmentScheduleEmpty extends AppointmentScheduleState {

  @override
  String toString() {
    return 'AppointmentScheduleEmpty{}';
  }
}