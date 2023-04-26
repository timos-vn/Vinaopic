import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {

  @override
  String toString() => 'AccountInitial';
}

class AccountLoading extends AccountState {

  @override
  String toString() => 'AccountInitial';
}


class AccountFailure extends AccountState {
  final String error;

  AccountFailure(this.error);

  @override
  String toString() => 'AccountFailure { error: $error }';
}

class LogOutAccountSuccess extends AccountState {

  @override
  String toString() {
    return 'LogOutAccountSuccess{}';
  }
}