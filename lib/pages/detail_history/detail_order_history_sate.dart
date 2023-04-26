import 'package:equatable/equatable.dart';

abstract class DetailOrderHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CustomerInitial extends DetailOrderHistoryState {

  @override
  String toString() => 'CustomerInitial';
}
class CustomerLoading extends DetailOrderHistoryState {

  @override
  String toString() => 'NewsInitial';
}
class GetListCustomerSuccess extends DetailOrderHistoryState {

  @override
  String toString() => 'GetListChoKhamSuccess';
}

class CustomerFailure extends DetailOrderHistoryState {
  final String error;

  CustomerFailure(this.error);

  @override
  String toString() => 'ChoKhamFailure { error: $error }';
}
class GetLisCustomerEmpty extends DetailOrderHistoryState {

  @override
  String toString() {
    return 'GetLisCustomerEmpty{}';
  }
}