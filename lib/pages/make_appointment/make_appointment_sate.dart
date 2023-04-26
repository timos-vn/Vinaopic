import 'package:equatable/equatable.dart';

abstract class MakeAppointmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class MakeAppointmentInitial extends MakeAppointmentState {

  @override
  String toString() => 'NewsInitial';
}

class MakeAppointmentLoading extends MakeAppointmentState {

  @override
  String toString() => 'MakeAppointmentLoading';
}
class CreatesNewCustomerSuccess extends MakeAppointmentState {

  @override
  String toString() {
    return 'CreatesNewCustomerSuccess{}';
  }
}
class PickAvatarSuccess extends MakeAppointmentState {

  PickAvatarSuccess();

  @override
  String toString() {
    return 'PickAvatarSuccess{}';
  }
}
class MakeAppointmentFailure extends MakeAppointmentState {
  final String error;

  MakeAppointmentFailure(this.error);

  @override
  String toString() => 'NewsFailure { error: $error }';
}

class CreatesMakeAppointmentNewsSuccess extends MakeAppointmentState {

  @override
  String toString() {
    return 'CreatesMakeAppointmentNewsSuccess{}';
  }
}

class GetLisStoreSuccess extends MakeAppointmentState {

  @override
  String toString() {
    return 'GetLisStoreSuccess{}';
  }
}

class PickDateSuccess extends MakeAppointmentState {
  @override
  String toString() {
    // TODO: implement toString
    return 'PickDateSuccess{}';
  }
}