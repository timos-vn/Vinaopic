// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/untils/validator.dart';
// import 'package:vinaoptic/models/network/request/sign_up_request.dart';
// import 'package:vinaoptic/models/network/service/network_factory.dart';
// import 'package:vinaoptic/pages/sign_up/sign_up_event.dart';
// import 'package:vinaoptic/pages/sign_up/sign_up_state.dart';
//
//
// class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with Validators {
//   NetWorkFactory _networkFactory;
//   BuildContext context;
//   SharedPreferences _pref;
//   String _deviceToken;
//
//   SignUpBloc(this.context) {
//     _networkFactory = NetWorkFactory(context);
//   }
//   @override
//   SignUpState get initialState => InitialSignUpState();
//
//   @override
//   Stream<SignUpState> mapEventToState(
//     SignUpEvent event,
//   ) async* {
//     // TODO: Add Logic
//     if (_pref == null) {
//       _pref = await SharedPreferences.getInstance();
//     }
//     if (event is ValidateUserName) {
//       yield InitialSignUpState();
//       String error = checkUsername(context, event.userName);
//       yield ValidatePhoneNumberError(error);
//     }
//     if (event is ValidatePassWord) {
//       yield InitialSignUpState();
//       String error = checkPass(context, event.passWord);
//       yield ValidatePassWordError(error);
//     }
//     if (event is SignUp) {
//       yield SignUpLoading();
//
//       SignUpRequestBody request = SignUpRequestBody(
//           username: event.phoneNumber,
//         password: event.passWord
//       );
//       SignUpState state = _handleSignUp(await _networkFactory.signUp(request));
//       yield state;
//     }
//   }
//
//   SignUpState _handleSignUp(Object data) {
//     if (data is String) return SignUpFailure(data ??'Có lỗi xảy ra');
//     try {
//       return SignUpSuccess();
//     } catch (e) {
//       print(e.toString());
//       return SignUpFailure('Có lỗi xảy ra');
//     }
//   }
// }
