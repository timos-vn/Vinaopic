import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as libGetX;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/animation/fade_animation.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/pages/main/main_page.dart';
import 'package:vinaoptic/widget/text_field_widget.dart';
import '../sign_up/sign_up_page.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_sate.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen>  with TickerProviderStateMixin{

  late TextEditingController usernameController;
  late FocusNode usernameFocus;
  late TextEditingController passwordController;
  late FocusNode passwordFocus;
  bool isChecked = false;
  late LoginBloc _loginBloc;
  String unitName='';
  String unitId='';
  String key='';
  bool showLoading = false;
  String storeName ='',storeId='';
  String errorPass = '', errorUsername = '';
  int step = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkVersion();
    _loginBloc = LoginBloc(context);
    _loginBloc.add(GetPrefsLoginEvent());
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();

    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: BlocProvider(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if(state is GetPrefsSuccess){
                _loginBloc.add(SaveUserNamePassWordEvent());
              }
              else if (state is LoginSuccess) {
                step = 2;
                _loginBloc.add(GetUnits());
              }
              else if (state is LoginFailure) {
                Utils.showCustomToast(context,Icons.warning,state.error.toString());
              }
              else if(state is GetInfoUnitsSuccessful){
                if(_loginBloc.listUnitsName.length == 1){
                  unitId = _loginBloc.listUnitsId[0].trim();
                  unitName = _loginBloc.listUnitsName[0].trim();
                  _loginBloc.add(Config(unitId,unitName));
                }
              }
              else if(state is ConfigSuccessful){
                _loginBloc.add(GetStore(unitId.toString()));
              }
              else if(state is GetInfoStoreSuccessful){
                if(_loginBloc.listStoreName.length == 1){
                  storeName = _loginBloc.listStoreName[0].trim();
                  storeId = _loginBloc.listStoreId[0].trim();
                  _loginBloc.add(ConfigStore(storeId,storeName));
                }
              }
              else if (state is GetInfoUserFromDbSuccessful){
                usernameController.text = state.userName;
                passwordController.text = state.passWord;
                unitId = state.codeUnit;
                unitName = state.nameUnit;
                storeName = state.nameStore;
                storeId = state.codeStore;
              }
              else if(state is SaveEventSuccess){
                libGetX.Get.off(MainPage(
                  unitName: unitName.toString(),
                  userName: _loginBloc.username.toString(),
                  listInfoUnitsID: _loginBloc.listUnitsId,
                  listInfoUnitsName: _loginBloc.listUnitsName,
                  storeName: storeName.toString(),
                  storeId: storeId.toString(),
                ),transition: libGetX.Transition.zoom);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(builder: (BuildContext context, LoginState state,) {

              if (state is ValidateErrorUsername) errorUsername = state.error;
              if (state is ValidateErrorPassword) errorPass = state.error;

              return buildPage(context, state);
            }),
          ),
        ));
  }

  Widget buildPage(BuildContext context, LoginState state){
    return Scaffold(
      backgroundColor: white,//grey_100.withOpacity(0.9),
      body: GestureDetector(
        onTap: () {FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.4),
                    ]
                )),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: step == 2 ? CrossAxisAlignment.start :CrossAxisAlignment.start,
                mainAxisAlignment: step == 2 ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: <Widget>[
                  Visibility(
                    visible: step == 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // FadeAnimation(
                        //   0.2,
                          Text(
                            "Brand New Perspective",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        // FadeAnimation(
                        //   0.4,
                          Text(
                            "Let's start with our unique collection.",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        // ),
                        SizedBox(
                          height: 100,
                        ),
                        // FadeAnimation(
                        //   0.6,
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                step = 1;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  "Bắt đầu",
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),//),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: step == 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // FadeAnimation(
                        //   0.3,
                          buildInputUserName(context),//),
                        const SizedBox(height: 20,),
                        // FadeAnimation(
                        //   0.5,
                          buildInputPassword(context),//),
                        SizedBox(
                          height: 40,
                        ),
                        // FadeAnimation(
                        //   0.7,
                          GestureDetector(
                            onTap: (){
                              if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                                _loginBloc.add(Login(usernameController.text,passwordController.text,false));
                              }else{
                                Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng nhập đủ thông tin');
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: state is LoginLoading ?  SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )  : Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),//),
                        SizedBox(height: 30),
                        // FadeAnimation(1.4, _divider()),
                        // SizedBox(height: 30),
                        // // FadeAnimation(0.9,
                            _createAccountLabel(),
                        // // ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: step == 2,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  // FadeAnimation(
                                  //     0.1,
                                      Text('${'Xin Chào'.tr} ${_loginBloc.username}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),//),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // FadeAnimation(
                                  //   0.3,
                                    Text('Xin vui lòng kiểm tra thông tin để tiếp tục'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),//),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                // FadeAnimation(
                                //     0.5,
                                    buildInputUnitName(context),//),
                                SizedBox(
                                  height: 25,
                                ),
                                // FadeAnimation(
                                //   0.7,
                                  buildInputStoreName(context),//),
                                SizedBox(
                                  height: 80,
                                ),
                                // FadeAnimation(
                                //     1.0,
                                    GestureDetector(
                                      onTap: (){
                                        if( !Utils.isEmpty(unitName) && !Utils.isEmpty(storeName)  ){
                                          _loginBloc.add(SaveEvent());
                                        }else{
                                          Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng nhập đủ thông tin');
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(50)),
                                        child: Center(
                                          child:state is LoginLoading ?  SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                            ),
                                          )  : Text(
                                            "Tiếp tục",
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),//),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),
          Text('hoặc',style: TextStyle(color: Colors.white),),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(phoneNumber: usernameController.text,))).then((value){
          if(!Utils.isEmpty(value)){
            setState(() {
              usernameController.text = value;
            });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.only(left: 15,right: 15,bottom: 0),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bạn chưa có tài khoản ?',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600,color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Đăng ký ngay',
              style:TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildInputUserName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: TextFieldWidget(
        focusNode:  usernameFocus,
        controller: usernameController,
        color: Colors.white,
        textInputAction: TextInputAction.next,
        errorText: errorUsername,
        hintText: 'Tên tài khoản',
        onChanged: (text) => _loginBloc.checkUsernameBloc(text!),
        keyboardType: TextInputType.text,
        prefixIcon: Icons.account_circle,
        onSubmitted: (text) => Utils.navigateNextFocusChange(context,  usernameFocus,  passwordFocus),
      ),
    );
  }

  Padding buildInputPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: TextFieldWidget(
        color: Colors.white,
        controller: passwordController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        isPassword: true,
        errorText: errorPass,
        hintText: 'Mật khẩu',
        prefixIcon: Icons.vpn_key,
        onChanged: (text) => _loginBloc.checkPassBloc(text!),
        focusNode: passwordFocus,
      ),
    );
  }

  Widget buildInputUnitName(BuildContext context) {
    return InkWell(
      onTap:(){
        key = 'Unit';
        if(!Utils.isEmpty(_loginBloc.listUnitsName)){
          _loginBloc.listUnitsName.length == 1 ? null :
          showBottomSheetSettingsPanel(context, 'Unit'.tr ,buildSettings(context,_loginBloc.listUnitsName,_loginBloc.listUnitsId));
        }
      },
      child: Container(
        // height: 40,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.pin_drop,color: Colors.white,size: 20,),
                      SizedBox(width: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(!Utils.isEmpty(unitName) ? unitName : 'Unit'.tr,
                          style: TextStyle(fontSize: 13,color:  Colors.white),),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_drop_down,color: Colors.white,size: 20,)
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.white,
              thickness: 1,
            ),
            Visibility(
              visible: Utils.isEmpty(unitName),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DoNotEmpty'.tr,
                  style: TextStyle(color: Colors.red,fontSize: 8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInputStoreName(BuildContext context) {
    return InkWell(
      onTap: (){
        key = 'Store';
        showBottomSheetSettingsPanel(
            context, 'Store'.tr,buildSettings(context, _loginBloc.listStoreName,_loginBloc.listStoreId));
      },
      child: Container(
        // height: 40,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(MdiIcons.storefront,color: Colors.white,size: 20,),
                      SizedBox(width: 15,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(!Utils.isEmpty(storeName) ? storeName : 'Store'.tr,style: TextStyle(fontSize: 13,color: Colors.white),),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_drop_down,color: Colors.white,size: 20,)
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.white,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetSettingsPanel(BuildContext context,String title ,Widget propertyWidget){
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        builder: (builder){
          return Container(
            height: MediaQuery.of(context).copyWith().size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)
                )
            ),
            margin: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
              builder: (BuildContext context,StateSetter myState){
                return Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 0),
                  child: Container(
                    decoration:const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 8,right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: ()=> Navigator.pop(context),
                                  child: const Icon(Icons.close,color: Colors.white,)),
                              const Text('Thêm tuỳ chọn',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                              InkWell(
                                  onTap: ()=> Navigator.pop(context),
                                  child: Icon(Icons.clear,color: mainColor,)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Divider(color: Colors.blueGrey,),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  // color: Colors.blueGrey,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                child: propertyWidget,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
    ).then((value)async{
      if(value != null){
        print(value[2]);
        print(key);
        if(key =='Unit'){
          setState(() {
            unitName = value[1].toString();
            unitId = value[2];
            storeName = '';
            _loginBloc.add(Config(unitId,unitName));
          });
        }
        else if(key =='Store'){
          setState(() {
            storeName = value[1];
            storeId = value[2];
          });
          _loginBloc.add(ConfigStore(storeId,storeName));
        }
      }
    });
  }



  Widget buildSettings(BuildContext context,List<String> listName, List<String> listID) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
          return ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index)=>Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,),
                child: Divider(),
              ),

              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: ()=> Navigator.pop(context,[index,listName[index].toString(),listID[index].toString()]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0,right: 10),
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(listName[index].toString(),style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                          Text(listID[index].toString(),style: TextStyle(color: blue.withOpacity(0.5)),),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: listName.length
          );
        });
  }
}
