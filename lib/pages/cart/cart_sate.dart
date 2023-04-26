import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {

  @override
  String toString() => 'CartInitial';
}

class CartFailure extends CartState {
  final String error;

  CartFailure(this.error);

  @override
  String toString() => 'CartFailure { error: $error }';
}
class CartLoading extends CartState {
  @override
  String toString() => 'CartLoading';
}

class GetListOrderSuccess extends CartState {

  @override
  String toString() {
    return 'GetListOrderSuccess{}';
  }
}
class GetLisOrderEmpty extends CartState {

  @override
  String toString() {
    return 'GetLisOrderEmpty{}';
  }
}