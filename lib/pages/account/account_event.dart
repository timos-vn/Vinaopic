import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class LogOutAccount extends AccountEvent{

  @override
  String toString() {
    return 'LogOutAccount{}';
  }
}
class GetInfoAccount extends AccountEvent{

  @override
  String toString() {
    return 'GetInfoAccount{}';
  }
}
