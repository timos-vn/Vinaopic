import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {

  @override
  String toString() => 'LoginInitial';
}
class ChangeLanguageSuccess extends LoginState {
  final String nameLng;

  ChangeLanguageSuccess(this.nameLng);
  @override
  String toString() {
    return 'ChangeLanguageSuccess{nameLng: $nameLng}';
  }
}

class GetPrefsSuccess extends LoginState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}
class SaveEventSuccess extends LoginState{

  @override
  String toString() {
    return 'SaveEventSuccess{}';
  }
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {

  @override
  String toString() {
    return 'LoginSuccess{}';
  }
}
class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ValidateErrorHostId extends LoginState {
  final String error;

  ValidateErrorHostId(this.error);

  @override
  String toString() => 'ValidateErrorHostId { error: $error }';
}

class ValidateErrorUsername extends LoginState {
  final String error;

  ValidateErrorUsername(this.error);

  @override
  String toString() => 'ValidateErrorUsername { error: $error }';
}

class ValidateErrorPassword extends LoginState {
  final String error;

  ValidateErrorPassword(this.error);

  @override
  String toString() => 'ValidateErrorPassword { error: $error }';
}
class GetInfoCompanySuccessful extends LoginState {
  @override
  String toString() => 'GetInfoCompanySuccessful';
}

class GetInfoUnitsSuccessful extends LoginState {
  @override
  String toString() => 'GetInfoUnitsSuccessful';
}

class GetInfoStoreSuccessful extends LoginState {
  @override
  String toString() => 'GetInfoStoreSuccessful';
}

class ConfigStoreSuccessful extends LoginState {
  @override
  String toString() => 'ConfigStoreSuccessful';
}
class ConfigSuccessful extends LoginState {
  @override
  String toString() => 'ConfigSuccessful';
}
class GetInfoUserFromDbSuccessful extends LoginState {
  final String userName;
  final String passWord;
  final String codeUnit;
  final String nameUnit;
  final String codeStore;
  final String nameStore;

  GetInfoUserFromDbSuccessful({required this.userName,required this.passWord, required this.codeUnit, required this.nameUnit, required this.codeStore, required this.nameStore});

  @override
  String toString() => 'GetInfoUserFromDbSuccessful { userName: $userName }';
}