import 'package:equatable/equatable.dart';

abstract class CustomerState extends Equatable {
  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {

  @override
  String toString() => 'CustomerInitial';
}

class CustomerFailure extends CustomerState {
  final String error;

  CustomerFailure(this.error);

  @override
  String toString() => 'CustomerFailure { error: $error }';
}

class CustomerLoading extends CustomerState {
  @override
  String toString() => 'CustomerLoading';
}

class GetListCustomerSuccessful extends CustomerState {
  @override
  String toString() => 'GetListCustomerSuccessful';
}
class EmptyDataState extends CustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'EmptyDataState{}';
  }
}