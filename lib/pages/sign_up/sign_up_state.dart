import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSignUpState extends SignUpState {}

class SignUpLoading extends SignUpState {
  @override
  String toString() => 'SignUpLoading';
}

class CheckAccountLoading extends SignUpState {
  @override
  String toString() => 'CheckAccountLoading';
}

class SignUpSuccess extends SignUpState {

  @override
  String toString() => 'SignUpSuccess';
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);

  @override
  String toString() => 'SignUpFailure { error: $error }';
}

class ValidatePhoneNumberError extends SignUpState {
  final String error;

  ValidatePhoneNumberError(this.error);

  @override
  String toString() => 'ValidatePhoneNumberError { error: $error }';
}
class ValidatePassWordError extends SignUpState {
  final String error;

  ValidatePassWordError(this.error);

  @override
  String toString() => 'ValidatePassWordError { error: $error }';
}
