import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/untils/validator.dart';
import 'package:vinaoptic/model/account.dart';
import 'package:vinaoptic/models/database/dbhelper.dart';
import 'package:vinaoptic/models/network/request/login_request.dart';
import 'package:vinaoptic/models/network/response/info_store_response.dart';
import 'package:vinaoptic/models/network/response/info_units_response.dart';
import 'package:vinaoptic/models/network/response/login_response.dart';
import 'package:vinaoptic/models/network/service/network_factory.dart';
import 'login_event.dart';
import 'login_sate.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> with Validators{

  NetWorkFactory? _networkFactory;
  BuildContext context;
  String? _accessToken;
  String? _refreshToken;

  final box = GetStorage();

  String _username = '';
  String get username => _username;
  String?  _errorUsername, _errorPass;
  DatabaseHelper db = DatabaseHelper();
  List<String> _listUnitsName = [];
  List<String> get listUnitsName => _listUnitsName;
  List<String> _listUnitsId = [];
  List<String> get listUnitsId => _listUnitsId;

  List<String> _listStoreName = [];
  List<String> get listStoreName => _listStoreName;
  List<String> _listStoreId = [];
  List<String> get listStoreId => _listStoreId;

  List<AccountInfo> listAccountInfo =[];

  List<InfoStoreResponseData> listInfoStore =[];
  List<InfoUnitsResponseData> listInfoUnits = [];

  String userName = '';
  String passWord = '';
  String codeUnit = '';
  String nameUnit = '';
  String codeStore = '';
  String nameStore = '';

  LoginBloc(this.context) : super(LoginInitial()){
    _networkFactory = NetWorkFactory(context);
    on<GetPrefsLoginEvent>(_getPrefs);
    on<SaveUserNamePassWordEvent>(_saveUserNamePassWordEvent);
    on<ValidateUsername>(_checkValidateUserName);
    on<ValidatePass>(_checkValidatePassWord);
    on<Login>(_login);
    on<GetUnits>(_getUnits);
    on<Config>(_config);
    on<ConfigStore>(_configStore);
    on<GetStore>(_getStore);
    on<Loading>(_loading);
    on<SaveEvent>(_saveEvent);
  }

  void _getPrefs(GetPrefsLoginEvent event, Emitter<LoginState> emitter)async{
    // emitter(LoginInitial());
    // _pref = await SharedPreferences.getInstance();
    // _accessToken = _pref!.getString(Const.ACCESS_TOKEN) ?? "";
    // _refreshToken = _pref!.getString(Const.REFRESH_TOKEN) ?? "";
    emitter(GetPrefsSuccess());
  }

  void _saveEvent(SaveEvent event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    pushService();
    emitter(SaveEventSuccess());
  }

  void _checkValidateUserName(ValidateUsername event, Emitter<LoginState> emitter) async{
    emitter(LoginInitial());
    String? error = checkUsername(context, event.username) ?? '';
    emitter(ValidateErrorUsername(error));
  }

  void _checkValidatePassWord(ValidatePass event, Emitter<LoginState> emitter) async{
    emitter(LoginInitial());
    String? error = checkPass(context, event.pass) ?? '';
    emitter(ValidateErrorPassword(error));
  }

  void _saveUserNamePassWordEvent(SaveUserNamePassWordEvent event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
        listAccountInfo = await getListAccountInfoFromDb();
        if(!Utils.isEmpty(listAccountInfo)){
          emitter(GetInfoUserFromDbSuccessful(
            userName: listAccountInfo[0].userName,
            passWord: listAccountInfo[0].pass,
            codeUnit:  listAccountInfo[0].codeUnit,
            nameUnit:  listAccountInfo[0].nameUnit,
            codeStore:  listAccountInfo[0].codeStore,
            nameStore:  listAccountInfo[0].nameStore
          ));
        }
    emitter(LoginInitial());
  }

  void _login(Login event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    LoginRequestBody request = LoginRequestBody(
      username: event.username,
      password: event.password,
    );
    LoginState state = _handleLogin(await _networkFactory!.login(request),event.savePassword,event.username,event.password);
    emitter(state);
  }

  void _getUnits(GetUnits event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    LoginState state = _handleGetUnits(await _networkFactory!.getUnits(_accessToken!));
    emitter(state);
  }

  void _config(Config event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    box.write(Const.UNITS_ID, event.unitId.toString());
    LoginState state = _handleConfig(await _networkFactory!.config(_accessToken!,event.unitId),event.unitId,event.unitName);
    emitter(state);
  }

  void _configStore(ConfigStore event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    LoginState state = _handleConfigStore(await _networkFactory!.configStore(_accessToken!,event.storeId),event.storeId,event.storeName);
    emitter(state);
  }

  void _getStore(GetStore event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
    LoginState state = _handleGetStore(await _networkFactory!.getListStore(_accessToken!,event.unitId));
    emitter(state);
  }

  void _loading(Loading event, Emitter<LoginState> emitter)async{
    emitter(LoginLoading());
  }

  LoginState _handleLogin(Object data,bool savePassword,String username,String pass) {
    if (data is String) return LoginFailure(data);
    try {
      LoginResponse response = LoginResponse.fromJson(data as Map<String,dynamic>);
      _accessToken = response.accessToken.toString();
      _refreshToken = response.refreshToken.toString();
      _username = response.user!.userName.toString().trim();

      userName = username;
      passWord = pass;

      box.write(Const.ACCESS_TOKEN, _accessToken.toString());
      box.write(Const.REFRESH_TOKEN, _refreshToken.toString());

      box.write(Const.USER_ID, response.user?.userId.toString());
      box.write(Const.USER_NAME, userName.toString());
      box.write(Const.PHONE_NUMBER, response.user?.phoneNumber.toString());
      box.write(Const.CODE, response.user?.code.toString());
      box.write(Const.CODE_NAME, response.user?.codeName.toString());
      box.write(Const.EMAIL, response.user?.email.toString());

      pushService();
      return LoginSuccess();
    } catch (e) {
      print(e.toString());
      return LoginFailure(e.toString());
    }
  }

  void checkUsernameBloc(String username) {
    String? _tempErrUsername = checkUsername(context, username);
    if (_errorUsername != _tempErrUsername) {
      _errorUsername = _tempErrUsername;
      add(ValidateUsername(username));
    }
  }

  void checkPassBloc(String pass) {
    String? _tempErrPass = checkPass(context, pass);
    if (_errorPass != _tempErrPass) {
      _errorPass = _tempErrPass;
      add(ValidatePass(pass));
    }
  }

  LoginState _handleGetStore(Object data){
    if (data is String) return LoginFailure(data);
    try {
      _listStoreName.clear();
      _listStoreId.clear();
      InfoStoreResponse response = InfoStoreResponse.fromJson(data as Map<String,dynamic>);
      listInfoStore = response.stores!;
      Const.listInfoStore = response.stores!;
      listInfoStore.forEach((element) {
        _listStoreName.add(element.storeName!);
        _listStoreId.add(element.storeId!);
      });

      if(_listStoreName.length == 1){
        codeStore = _listStoreName[0];
        nameStore = _listStoreId[0];
      }

      return GetInfoStoreSuccessful();
    } catch (e) {
      print(e.toString());
      return LoginFailure('${e.toString()}');
    }
  }

  LoginState _handleGetUnits(Object data){
    if (data is String) return LoginFailure(data);
    try {
      InfoUnitsResponse response = InfoUnitsResponse.fromJson(data as Map<String,dynamic>);
      listInfoUnits = response.units!;
      listInfoUnits.forEach((element) {
        _listUnitsName.add(element.unitName!);
        _listUnitsId.add(element.unitId!);
      });

      if(_listUnitsName.length == 1){
        codeUnit = _listUnitsId[0];
        nameUnit = _listUnitsName[0];
      }

      return GetInfoUnitsSuccessful();
    } catch (e) {
      print(e.toString());
      return LoginFailure("${e.toString()}");
    }
  }

  LoginState _handleConfigStore(Object data,String storeCode, String storeName){
    if (data is String) return LoginFailure(data);
    try {
      codeStore = storeCode;
      nameStore = storeName;
      return ConfigStoreSuccessful();
    } catch (e) {
      print(e.toString());
      return LoginFailure(':${e.toString()}');
    }
  }

  LoginState _handleConfig(Object data, String codeUnit, String nameUnit){
    if (data is String) return LoginFailure(data);
    try {
      codeUnit = codeUnit;
      nameUnit = nameUnit;
      _listUnitsName.clear();
      _listUnitsId.clear();
      return ConfigSuccessful();
    } catch (e) {
      print(e.toString());
      return LoginFailure(':${e.toString()}');
    }
  }

  void pushService() async{
    AccountInfo _accountInfo = new AccountInfo(
        userName,
        passWord,
        codeUnit, nameUnit, codeStore, nameStore
    );
    await db.saveAccount(_accountInfo);
    listAccountInfo = await getListAccountInfoFromDb();
    if(!Utils.isEmpty(listAccountInfo)){
      db.updateAccountInfo(_accountInfo);
    }
  }

  Future<List<AccountInfo>> getListAccountInfoFromDb() {
    return db.fetchAllAccountInfo();
  }
}