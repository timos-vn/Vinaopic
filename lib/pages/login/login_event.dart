import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {

  final String username;
  final String password;
  final bool savePassword;

  Login(this.username, this.password,this.savePassword);

  @override
  String toString() => 'Login {username: $username, password: $password,savePassword: $savePassword }';
}

class GetPrefsLoginEvent extends LoginEvent {
  @override
  String toString() => 'GetPrefsLoginEvent';
}

class ValidateHostId extends LoginEvent {
  final String hostId;

  ValidateHostId(this.hostId);

  @override
  String toString() => 'ValidateHostId { hostId: $hostId }';
}

class ValidateUsername extends LoginEvent {
  final String username;

  ValidateUsername(this.username);

  @override
  String toString() => 'ValidateUsername { username: $username }';
}

class ValidatePass extends LoginEvent {
  final String pass;

  ValidatePass(this.pass);

  @override
  String toString() =>
      'ValidatePass { pass: $pass }';
}

class CheckDB extends LoginEvent {
  @override
  String toString() => 'CheckDB { }';
}

class SaveLanguageEvent extends LoginEvent {

  final String codeLanguage;
  final String nameLanguage;

  SaveLanguageEvent(this.codeLanguage,this.nameLanguage);

  @override
  String toString() {
    return 'SaveLanguageEvent{codeLanguage: $codeLanguage,nameLanguage: $nameLanguage }';
  }
}

class Config extends LoginEvent{
  final String unitId;
  final String unitName;

  Config(this.unitId, this.unitName);

  @override
  String toString() => 'Config { unitId: $unitId}';
}
class SaveEvent extends LoginEvent{

  @override
  String toString() => 'ư { SaveEvent}';
}

class ConfigStore extends LoginEvent{
  final String storeId;
  final String storeName;

  ConfigStore(this.storeId,this.storeName);

  @override
  String toString() => 'ConfigStore { storeId: $storeId}';
}

class GetUnits extends LoginEvent{
  @override
  String toString() => 'GetUnits {}';
}

class GetStore extends LoginEvent{
  final String unitId;

  GetStore(this.unitId);

  @override
  String toString() => 'GetStore { unitId: $unitId}';
}

class Loading extends LoginEvent{
  @override
  String toString() => 'Loading {}';
}

class SaveUserNamePassWordEvent extends LoginEvent {

  @override
  String toString() {
    return 'SaveUserNamePassWordEvent{}';
  }
}
