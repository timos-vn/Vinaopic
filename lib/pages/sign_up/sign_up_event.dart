// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// @immutable
// abstract class SignUpEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class ValidateUserName extends SignUpEvent {
//   final String userName;
//
//   ValidateUserName(this.userName);
//
//   @override
//   String toString() =>
//       'ValidateUserName { userName: $userName }';
// }
//
// class ValidatePassWord extends SignUpEvent {
//   final String passWord;
//
//   ValidatePassWord(this.passWord);
//
//   @override
//   String toString() =>
//       'ValidatePassWord { passWord: $passWord }';
// }
//
//
// class SignUp extends SignUpEvent {
//   final String phoneNumber;
//   final String passWord;
//
//   SignUp(this.phoneNumber,this.passWord);
//
//
//   @override
//   String toString() => 'SignUp { phoneNumber: $phoneNumber,passWord: $passWord }';
// }