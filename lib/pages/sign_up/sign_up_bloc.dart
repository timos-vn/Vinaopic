import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vinaoptic/core/untils/validator.dart';
import 'package:vinaoptic/models/network/request/sign_up_request.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'package:vinaoptic/pages/sign_up/sign_up_event.dart';
import 'package:vinaoptic/pages/sign_up/sign_up_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with Validators {
  NetWorkFactory? _networkFactory;
  BuildContext context;


  SignUpBloc(this.context) : super(InitialSignUpState()){
    _networkFactory = NetWorkFactory(context);
    on<ValidateUserName>(_validateUserName);
    on<ValidatePassWord>(_validatePassWord);
    on<SignUp>(_signUp);
  }


  void _validateUserName(ValidateUserName event, Emitter<SignUpState> emitter)async{
    emitter(InitialSignUpState());
    String? error = checkUsername(context, event.userName);
    emitter(ValidatePhoneNumberError(error.toString().replaceAll('null', '')));
  }
  void _validatePassWord(ValidatePassWord event, Emitter<SignUpState> emitter)async{
    emitter(InitialSignUpState());
    String? error = checkPass(context, event.passWord);
    emitter(ValidatePassWordError(error.toString().replaceAll('null', '')));
  }

  void _signUp(SignUp event, Emitter<SignUpState> emitter)async{
    emitter(SignUpLoading());
    SignUpRequestBody request = SignUpRequestBody(
        username: event.phoneNumber,
        password: event.passWord
    );
    SignUpState state = _handleSignUp(await _networkFactory!.signUp(request));
    emitter(state);
  }


  SignUpState _handleSignUp(Object data) {
    if (data is String) return SignUpFailure(data);
    try {
      return SignUpSuccess();
    } catch (e) {
      print(e.toString());
      return SignUpFailure('Có lỗi xảy ra');
    }
  }
}
