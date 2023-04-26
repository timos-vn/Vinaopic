import 'package:equatable/equatable.dart';

abstract class DetailOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailOrderInitial extends DetailOrderState {

  @override
  String toString() => 'DetailOrderInitial';
}

class DetailOrderFailure extends DetailOrderState {
  final String error;

  DetailOrderFailure(this.error);

  @override
  String toString() => 'DetailOrderFailure { error: $error }';
}
class DetailOrderLoading extends DetailOrderState {
  @override
  String toString() => 'DetailOrderLoading';
}

class SendInvoiceSuccess extends DetailOrderState {

  @override
  String toString() {
    return 'SendInvoiceSuccess{}';
  }
}
class UpdateOrderSuccess extends DetailOrderState {

  @override
  String toString() {
    return 'UpdateOrderSuccess{}';
  }
}

class CheckScanDataSuccess extends DetailOrderState {

  @override
  String toString() {
    return 'SendInvoiceSuccess{}';
  }
}

class CheckListProductSuccess extends DetailOrderState {

  @override
  String toString() {
    return 'CheckListProductSuccess{}';
  }
}
class CalculatorMoneySuccess extends DetailOrderState {

  @override
  String toString() {
    return 'CalculatorMoneySuccess{}';
  }
}
class PickDateSuccess extends DetailOrderState {
  @override
  String toString() {
    // TODO: implement toString
    return 'PickDateSuccess{}';
  }
}
class CreateNewsCustomerSuccess extends DetailOrderState {

  @override
  String toString() {
    return 'CreateNewsCustomerSuccess{}';
  }
}
class GetDetailOrderSuccess extends DetailOrderState {

  @override
  String toString() {
    return 'GetDetailOrderSuccess{}';
  }
}
