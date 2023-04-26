import 'package:equatable/equatable.dart';

abstract class ListHistoryCustomerState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListHistoryCustomerInitial extends ListHistoryCustomerState {

  @override
  String toString() => 'ListHistoryCustomerInitial';
}

class ListHistoryCustomerFailure extends ListHistoryCustomerState {
  final String error;

  ListHistoryCustomerFailure(this.error);

  @override
  String toString() => 'ListHistoryCustomerFailure { error: $error }';
}

class ListHistoryCustomerLoading extends ListHistoryCustomerState {
  @override
  String toString() => 'ListHistoryCustomerLoading';
}

class GetListHistoryCustomerSuccessful extends ListHistoryCustomerState {
  @override
  String toString() => 'GetListHistoryCustomerSuccessful';
}
class EmptyDataState extends ListHistoryCustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'EmptyDataState{}';
  }
}