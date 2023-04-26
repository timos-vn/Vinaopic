// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:vinaoptic/core/untils/utils.dart';
// import 'package:vinaoptic/core/values/colors.dart';
// import 'package:vinaoptic/core/values/images.dart';
// import 'package:vinaoptic/pages/login/login_event.dart';
// import 'package:vinaoptic/pages/login/login_sate.dart';
// import 'package:vinaoptic/pages/sign_up/sign_up_bloc.dart';
// import 'package:vinaoptic/pages/sign_up/sign_up_event.dart';
// import 'package:vinaoptic/pages/sign_up/sign_up_state.dart';
// import 'package:vinaoptic/widget/button_widget.dart';
// import 'package:vinaoptic/widget/pending_action.dart';
// import 'package:vinaoptic/widget/text_field_widget.dart';
//
//
// class SignUpPage extends StatefulWidget {
//   final String phoneNumber;
//
//   const SignUpPage({Key key, this.phoneNumber}) : super(key: key);
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passWordController = TextEditingController();
//   FocusNode _phoneFocus = FocusNode();
//   FocusNode _passWordFocus = FocusNode();
//   SignUpBloc _signUpBloc;
//   String _errorPhone,_errorPassWord;
//
//   String verificationCode;
//
//   @override
//   void initState() {
//     super.initState();
//     _signUpBloc = SignUpBloc(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if(!Utils.isEmpty(widget.phoneNumber))
//       _phoneController.text = widget.phoneNumber;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: BlocProvider(
//           create: (context) => _signUpBloc,
//           child: BlocListener<SignUpBloc, SignUpState>(
//             listener: (context, state) {
//               if (state is SignUpFailure){
//                 Utils.showToast(state.error);}
//               if (state is SignUpSuccess){
//                 Utils.showToast('Đăng ký tài khoản thành công');
//                 Navigator.pop(context,_phoneController.text);
//               }
//               if (state is ValidatePhoneNumberError){
//                 _errorPhone = state.error;
//               }else if(state is ValidatePassWordError){
//                 _errorPassWord = state.error;
//               }
//             },
//             child: BlocBuilder<SignUpBloc, SignUpState>(builder: (
//               BuildContext context,
//               SignUpState state,
//             ) {
//               return Stack(
//                 children: <Widget>[
//                   GestureDetector(
//                       onTap: () =>
//                           FocusScope.of(context).requestFocus(new FocusNode()),
//                       child: Stack(fit: StackFit.expand, children: <Widget>[
//                         SingleChildScrollView(
//                             child: Container(
//                           width: double.infinity,
//                           alignment: Alignment.center,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.max,
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: 70.0,
//                                 ),
//                                 Image.asset(
//                                   icLogo,
//                                   height: 200.0,
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 buildInputPhoneNumber(context),
//                                 SizedBox(
//                                   height: 12.0,
//                                 ),
//                                 buildInputPassWord(context),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 buildSignUp(state, context),
//                               ]),
//                         )),
//                         Positioned(
//                           top: 50.0,
//                           left: 20.0,
//                           child: GestureDetector(
//                               onTap: () => Navigator.of(context).pop(),
//                               child: Icon(MdiIcons.arrowLeft)),
//                         ),
//                       ])),
//                   Visibility(
//                     visible: state is SignUpLoading,
//                     child: PendingAction(),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ));
//   }
//
//   Widget buildSignUp(SignUpState state, BuildContext context) {
//     return ButtonWidget(
//       title: 'Đăng ký',
//       onPressed: ()async
//           {
//             if( _phoneController.text.length > 4){
//               _signUpBloc.add(SignUp(_phoneController.text,_passWordController.text));
//             } else if(_phoneController.text.length < 4){
//               Utils.showToast('Vui lòng nhập tên đăng nhập của bạn');
//             }
//           }
//         );
//   }
//
//   Padding buildInputPhoneNumber(BuildContext context) {
//     return
//       Padding(
//         padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
//         child: TextFieldWidget(
//           color: Colors.black,
//         controller: _phoneController,
//         textInputAction: TextInputAction.next,
//         keyboardType: TextInputType.text,
//         labelText: 'Tài khoản',
//         focusNode: _phoneFocus,
//         errorText: _errorPhone,
//         onChanged: (text) => _signUpBloc.add(ValidateUserName(text)),
//       ),
//     );
//   }
//
//   Padding buildInputPassWord(BuildContext context) {
//     return
//       Padding(
//         padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
//         child: TextFieldWidget(
//           color: Colors.black,
//         controller: _passWordController,
//         textInputAction: TextInputAction.done,
//         keyboardType: TextInputType.text,
//         labelText: 'Mật khẩu',
//         focusNode: _passWordFocus,
//         errorText: _errorPassWord,
//         onChanged: (text) => _signUpBloc.add(ValidatePassWord(text)),
//       ),
//     );
//   }
//
//   Container buildConnectWithText(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             flex: 1,
//             child: Divider(
//               height: 3.0,
//               color: Colors.black,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10.0),
//             child: Text(
//               'Hoặc đăng nhập với',
//               style: TextStyle(
//                 fontSize: 12.0,
//                 color: black,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Divider(
//               height: 3.0,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
