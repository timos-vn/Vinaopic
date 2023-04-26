// import 'package:equatable/equatable.dart';
//
// abstract class NewsState extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class NewsInitial extends NewsState {
//
//   @override
//   String toString() => 'NewsInitial';
// }
//
// class NewsFailure extends NewsState {
//   final String error;
//
//   NewsFailure(this.error);
//
//   @override
//   String toString() => 'NewsFailure { error: $error }';
// }
//
// class RefreshNewsSuccess extends NewsState {
//
//   @override
//   String toString() {
//     return 'RefreshNewsSuccess{}';
//   }
// }