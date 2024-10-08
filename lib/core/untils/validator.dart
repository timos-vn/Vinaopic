import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'utils.dart';

class Validators{
  static final RegExp _phoneRegex = RegExp(r'(\+84|0)\d{9}$');
  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String? checkHotId(BuildContext context, String username) {
    if (Utils.isEmpty(username)) {
      return 'HotIdIsNotEmpty'.tr;
    }  else {
      return null;
    }
  }

  String? checkUsername(BuildContext context, String username) {
    if (Utils.isEmpty(username)) {
      return 'Vui lòng điền tên đăng nhập';
    } else if (username.length < 4) {
      return 'Tên đăng nhập quá ngắn';
    } else {
      return null;
    }
  }

  String? checkPass(BuildContext context, String password) {
    if (Utils.isEmpty(password)) {
      return 'Vui lòng điền mật khẩu';
    } else if (password.length < 4) {
      return 'Mật khẩu quá ngắn';
    } else {
      return null;
    }
  }

  String? checkPhoneNumber2(BuildContext context, String phoneNumber) {
    if (Utils.isEmpty(phoneNumber)) return null;
    if (!_phoneRegex.hasMatch(phoneNumber)) {
      return 'Số điện thoại không đúng định dạng ';
    } else {
      return null;
    }
  }

  String? checkEmail(BuildContext context, String email) {
    if (Utils.isEmpty(email)) {
      return 'PlsInputEmail'.tr;
    } else if (!_emailRegex.hasMatch(email)) {
      return 'EmailNotValid'.tr;
    } else {
      return null;
    }
  }
}