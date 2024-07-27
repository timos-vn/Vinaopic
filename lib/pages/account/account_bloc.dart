import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';

import 'account_event.dart';
import 'account_sate.dart';

class AccountBloc extends Bloc<AccountEvent,AccountState>{


  String? userID;
  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();
  String userName = '';

  AccountBloc(this.context) : super(AccountInitial()){
    _networkFactory = NetWorkFactory(context);
    _accessToken = box.read(Const.ACCESS_TOKEN);
    _refreshToken = box.read(Const.ACCESS_TOKEN);
    userID = box.read(Const.USER_ID);
    userName = box.read(Const.USER_NAME);
    on<DeleteAccountEvent>(_deleteAccountEvent);
  }

  void _deleteAccountEvent(DeleteAccountEvent event, Emitter<AccountState> emitter)async{
    emitter(AccountLoading());
    print(userName);
    AccountState state = _handleDeleteAccount(await _networkFactory!.deleteAccount(_accessToken!,userName.toString()));
    emitter(state);
  }

  AccountState _handleDeleteAccount(Object data) {
    if (data is String) return AccountFailure(data);
    try {
      return DeleteAccountSuccess();
    } catch (e) {
      return DeleteAccountSuccess();
    }
  }
}