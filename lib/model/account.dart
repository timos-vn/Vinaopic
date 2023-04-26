import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {

  final String userName;
  final String pass;
  final String codeUnit;
  final String nameUnit;
  final String codeStore;
  final String nameStore;

  AccountInfo(
      this.userName,
      this.pass,
      this.codeUnit,
      this.nameUnit,
      this.codeStore,
      this.nameStore
     );

  AccountInfo.fromDb(Map<String, dynamic> map)
      :
        userName = map['userName'],
        pass = map['pass'],
        codeUnit = map['codeUnit'],
        nameUnit = map['nameUnit'],codeStore = map['codeStore'],
        nameStore = map['nameStore'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['userName'] = userName;
    map['pass'] = pass;

    map['codeUnit'] = codeUnit;
    map['nameUnit'] = nameUnit; map['codeStore'] = codeStore;
    map['nameStore'] = nameStore;
    return map;
  }

  @override
  List<Object> get props => [
    userName,
    pass,
    codeUnit,
    nameUnit,
    codeStore,
    nameStore
  ];
}
