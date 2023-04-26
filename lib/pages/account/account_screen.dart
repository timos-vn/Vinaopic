import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart' as libGetX;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/pages/main/main_bloc.dart';
import 'package:vinaoptic/pages/support_contact/support_contact_screen.dart';
import 'package:vinaoptic/widget/custom_clip_path.dart';
import 'package:vinaoptic/widget/pending_action.dart';
import 'dart:io' show Platform, exit;

import '../login/login_screen.dart';
import 'account_bloc.dart';
import 'account_event.dart';
import 'account_sate.dart';

class AccountScreen extends StatefulWidget {
  final int? point;
  final String? userName;
  final String? phone;
  final String? version;

  const AccountScreen({Key? key,this.point,this.userName,this.phone,this.version}) : super(key: key);
  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> with TickerProviderStateMixin {

  late AccountBloc _bloc;
  late MainBloc _mainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _bloc = AccountBloc(context);
    // _bloc.add(GetInfoAccount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AccountBloc,AccountState>(
            bloc: _bloc,
            listener: (context, state){
              if(state is LogOutAccountSuccess){
                libGetX.Get.offAll(LoginScreen());
              }
            },
            child: BlocBuilder<AccountBloc,AccountState>(
              bloc: _bloc,
              builder: (BuildContext context, AccountState state){
                return buildPage(context,state);
              },
            )
        ));
  }

  Widget buildPage(BuildContext context,AccountState state){
    return Stack(
      children: <Widget>[
        Container(
          color: dark_text.withOpacity(0.1),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue.withOpacity(0.8), Colors.blue.withOpacity(0.5)])),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(MdiIcons.hexagonMultipleOutline,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text('${widget.userName?.toString()??_bloc.userName.toString()}',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          ),
                          GestureDetector(
                              //onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(phoneNumber: widget.phone,nameCustomer: widget.userName?.toString() ?? _bloc.userName?.toString(),))),
                              child: Icon(Icons.edit,color: Colors.white,size: 20,)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: SingleChildScrollView(
                // reverse: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        ClipPath(
                          clipper: Customshape(),
                          child: Container(
                            height: 105,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.all(Radius.circular(15)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blue.withOpacity(0.8), Colors.blue.withOpacity(0.5)])),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          left: 0,right: 0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: ()=> Utils.showCustomToast(context,Icons.warning_amber_outlined,'Tính năng sắp ra mắt'),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: mainColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(MdiIcons.pizza,color: mainColor,size: 30,),
                                          Text('Vinaoptic ID',style: TextStyle(fontSize: 12,color: mainColor,fontWeight: FontWeight.bold),),
                                          Container(
                                            height: 24,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: mainColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                            ),
                                            child: Center(
                                              child: Text('0 điểm',style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()=> Utils.showCustomToast(context,Icons.warning_amber_outlined,'Tính năng sắp ra mắt'),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color:  Colors.deepOrange.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(MdiIcons.disqus,color: Colors.deepOrange,size: 30),
                                          Text('Newbie',style: TextStyle(fontSize: 12,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                                          Container(
                                            height: 24,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                            ),
                                            child: Center(
                                              child: Text('0 điểm',style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    //onTap: ()=>pushNewScreen(context, screen: PromotionsScreen(),withNavBar: false),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(Radius.circular(12))
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(MdiIcons.sale,color: Colors.indigo,size: 30),
                                          Text('Mã giảm giá',style: TextStyle(fontSize: 12,color: Colors.indigo,fontWeight: FontWeight.bold),),
                                          Container(
                                            height: 24,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                            ),
                                            child: Center(
                                              child: Text('${0} coupon',style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),),
                      ],
                    ),
                    SizedBox(height: 15,),
                    buildMenu(context),
                   // buildMenu(context),
                    SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                  ],
                ),
              ))
            ],
          ),
        ),
        Visibility(
          visible:state is AccountLoading,
          child: PendingAction(),
        ),
      ],
    );
  }

  Widget buildMenu(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        InkWell(
          // onTap: ()=>
          //     pushNewScreen(context, screen: AboutTimosScreen(),withNavBar: false),
          child: Container(
            padding: EdgeInsets.all(15),
            // height: 20,
            color: Colors.white,
            width: double.infinity,
            child: Row(
              children: [
                Icon(MdiIcons.alertOctagonOutline,color: mainColor,),
                SizedBox(width: 15,),
                Text('Thông tin về Vinaoptic', ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.all(15),
          // height: 20,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: ()=> Utils.showCustomToast(context,Icons.warning_amber_outlined,'Tính năng sắp ra mắt'),
                child: Row(
                  children: [
                    Icon(MdiIcons.walletOutline,color: mainColor,),
                    SizedBox(width: 15,),
                    Text('Tích điểm',style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(MdiIcons.accountMultiplePlusOutline,color: Colors.white,),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              InkWell(
                onTap: ()=> Utils.showCustomToast(context,Icons.warning_amber_outlined,'Tính năng sắp ra mắt'),
                child: Row(
                  children: [
                    Icon(MdiIcons.accountMultiplePlusOutline,color: mainColor,),
                    SizedBox(width: 15,),
                    Text('Giới thiệu và nhận ưu đãi',),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.all(15),
          // height: 20,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: ()=> Utils.showCustomToast(context,Icons.warning_amber_outlined,'Tính năng sắp ra mắt'),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined,color: mainColor,),
                    SizedBox(width: 15,),
                    Text('Hộp thư',),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(MdiIcons.accountMultiplePlusOutline,color: Colors.white,),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              Row(
                children: [
                  Icon(MdiIcons.alertRhombusOutline,color: mainColor,),
                  SizedBox(width: 15,),
                  Text('Chính sách & điều khoản',),
                ],
              ),
              Row(
                children: [
                  Icon(MdiIcons.accountMultiplePlusOutline,color: Colors.white,),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              InkWell(
                // onTap: ()=> pushNewScreen(context, screen: SupportContactScreen(),withNavBar: false),
                child: Row(
                  children: [
                    Icon(MdiIcons.helpRhombusOutline,color: mainColor,),
                    SizedBox(width: 15,),
                    Text('Hỗ trợ',),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.all(15),
          // height: 20,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                //onTap: ()=> pushNewScreen(context, screen: SettingScreen(phone: widget.phone,nameCustomer: widget.userName,),withNavBar: false),
                child: Row(
                  children: [
                    Icon(Icons.settings,color: mainColor,),
                    SizedBox(width: 15,),
                    Text('Cài đặt',),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(MdiIcons.accountMultiplePlusOutline,color: Colors.white,),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              InkWell(
                onTap: (){
                  _showConfirm(context);
                },
                child: Row(
                  children: [
                    Icon(MdiIcons.power,color: Colors.red,),
                    SizedBox(width: 15,),
                    Text('Đăng xuất',),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text('Phiên bản ${'1.0.0'}',style:  TextStyle(color: Colors.grey,fontSize: 13),),
        ),
      ],
    );
  }

  void _showConfirm(BuildContext context) {
    List<Widget> actions = [
      FlatButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
        child: Text('No'.tr,
            style:  TextStyle(
              color: Colors.orange,
              fontSize: 14,
            )),
      ),
      FlatButton(
        onPressed: () {
          _bloc.add(LogOutAccount());
        },
        child: Text('Yes'.tr,
            style:  TextStyle(
              color: Colors.orange,
              fontSize: 14,
            )),
      ),
    ];

    Utils.showDialogTwoButton(
        context: context,
        title: 'Notice'.tr,
        contentWidget: Text(
          'ExitApp'.tr,
          style: TextStyle(fontSize: 14, color: black),
        ),
        actions: actions);
  }
}
