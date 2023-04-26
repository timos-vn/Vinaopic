// import 'package:equatable/equatable.dart';
//
// abstract class DoctorState extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class DoctorInitial extends DoctorState {
//
//   @override
//   String toString() => 'DoctorInitial';
// }
//
// class DoctorFailure extends DoctorState {
//   final String error;
//
//   DoctorFailure(this.error);
//
//   @override
//   String toString() => 'DoctorFailure { error: $error }';
// }
// class DoctorLoading extends DoctorState {
//   @override
//   String toString() => 'DoctorLoading';
// }
//
// class GetListDoctorSuccess extends DoctorState {
//
//   @override
//   String toString() {
//     return 'GetListDoctorSuccess{}';
//   }
// }
// class GetLisDoctorEmpty extends DoctorState {
//
//   @override
//   String toString() {
//     return 'GetLisDoctorEmpty{}';
//   }
// }