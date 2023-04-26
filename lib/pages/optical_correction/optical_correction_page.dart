import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_data_table_plus/lazy_data_table_plus.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/models/network/request/update_order_request.dart';
import 'package:vinaoptic/widget/pending_action.dart';

import 'optical_correction_bloc.dart';
import 'optical_correction_event.dart';
import 'optical_correction_state.dart';

class FormChinhQuangPage extends StatefulWidget {

  const FormChinhQuangPage({Key? key,}) : super(key: key);
  @override
  _FormChinhQuangPageState createState() => _FormChinhQuangPageState();
}

class _FormChinhQuangPageState extends State<FormChinhQuangPage> with TickerProviderStateMixin {

  final pdPhaiController = TextEditingController();
  final FocusNode pdPhaiFocus = FocusNode();

  final pdPhai2Controller = TextEditingController();
  final FocusNode pdPhai2Focus = FocusNode();

  final pdTrai2Controller = TextEditingController();
  final FocusNode pdTrai2Focus = FocusNode();

  late OpticalCorrectionBloc _bloc;

  CqDetail? cpDetail;

  List<double> listCau = [];
  List<double> listTru = [];
  List<double> listTruc = [];
  List<double> congThem = [
    0.50,0.75,1.00,1.25,1.75,2.00,2.25,2.50,2.75,3.00,3.25,3.50,3.75,4.00
  ];
  List<double> thiLuc = [
    0.5,1,1.5,2,3,4,5,6,7,8,9,12,15
  ];

  void truc(){
    for(double i = 0; i<=180 ; i ++){
      listTruc.add(i);
    }
  }

  void cau(){
    double startIndex = 25.0;
    double endIndex = -25.0;
    double value = 0.5;
    for(double i = endIndex; i <= startIndex; i+=value){
      if(i == -8.0 && i < -1){
        value = 0.25;
      }else if(i == -0.25){
        value = 0.13;
      }else if (i == -0.12){
        value = 0.12;
      }else if(i == 0.00){
        value = 0.12;
      }else if(i == 0.12){
        value = 0.13;
      }else if(i == 0.25){
        value = 0.25;
      }else if(i == 8){
        value = 0.5;
      }
      if(i >= -8.0 && i <= 8.0){
        listTru.add(i);
      }
      listCau.add(i);
    }
  }

  Widget textField(TextEditingController controller,FocusNode focusNode){
    return Container(
      child: TextField(
        maxLines: 1,
        //obscureText: true,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 10,left: 10),
          hintText: '0',
          hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12),
        ),
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
        //textInputAction: TextInputAction.none,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OpticalCorrectionBloc(context);
    cau();truc();


  }

  double _valueCau = 0.0;
  double _valueTru = 0.00;
  double _valueTruc = 0.00;
  double _valueAdd = 0.00;
  double _valueThiLuc = 0.00;
  double _valueCauT = 0.00;
  double _valueTruT = 0.00;
  double _valueTrucT = 0.00;
  double _valueAddT = 0.00;
  double _valueThiLucT = 0.00;

  bool nhinXa = false;
  bool nhinGan = false;
  bool nhinTrung = false;

  bool donTrong = false;
  bool daTrong = false;

  bool haiTrong = false;
  bool glas = false;

  bool matDat = false;
  bool valuefirst = false;
  bool hapMau = false;
  bool plastic = false;
  bool phanCuc = false;
  bool matMau = false;
  bool doiMau = false;

  Widget checkbox({required String title,required bool initValue,required Function(bool boolValue) onChanged}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Checkbox(value: initValue, onChanged: (b) => onChanged(b!))
        ]);
  }

  Widget checkboxL({required String title,required bool initValue,required Function(bool boolValue) onChanged}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(value: initValue, onChanged: (b) => onChanged(b!)),
          Text(title),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text('Thông số về chỉnh quang',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          leading: GestureDetector(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back,color: Colors.white,),
          ),
        ),
        body:BlocListener<OpticalCorrectionBloc,OpticalCorrectionState>(
          bloc: _bloc,
            listener: (context,state){},
            child: BlocBuilder<OpticalCorrectionBloc,OpticalCorrectionState>(
              bloc: _bloc,
              builder: (BuildContext context, OpticalCorrectionState state){
                return buildPage(context,state);
              },
            )
        ));
  }

  Widget buildPage(BuildContext context, OpticalCorrectionState state){
    return Stack(
      children: <Widget>[
        buildPageReport(context),
        Visibility(
          visible: state is OpticalCorrectionLoading,
          child: PendingAction(),
        ),
      ],
    );
  }

  List<String> listHeaderRow = [
    'Phải','Trái',
  ];

  List<String> listHeaderTitle=[
    "Cầu",
    "Trụ",
    "Trục",
    "Cộng thêm",
    "Thị lự",
  ];
  List<String> listHeaderDesc=[
    "(SPH)",
    "(CYL)",
    "(AX)",
    "(ADD)",
    "(VA) /10",
  ];

  Widget PupopMenu(int i, int j){
    return (i == 0 && j == 0) ?
    PopupMenuButton(
      onSelected: (value) {
        setState(() {
          _valueCau = double.parse(value.toString());
          print(_valueCau);
        });
      },
      child: Center(child: Text(_valueCau.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context) {
        return listCau.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ) :
    (i == 0 && j == 1) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueTru = double.parse(value.toString());
        });
      },
      child: Center(child: Text(_valueTru.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return listTru.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ) :
    (i == 0 && j == 2) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueTruc = double.parse(value.toString());
        });
      },
      child: Center(child: Text(_valueTruc.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return listTruc.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ) :
    (i == 0 && j == 3) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueAdd  = double.parse(value.toString());
        });
      },
      child: Center(child: Text(_valueAdd.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return congThem.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ) :
    (i == 0 && j == 4) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueThiLuc = double.parse(value.toString());
        });
      },
      child: Center(child: Text('${_valueThiLuc.toString()} /10',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return thiLuc.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text('${choice.toString()} /10'),
          );}
        ).toList();
      },
    ) :
    (i == 1 && j == 0) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueCauT = double.parse(value.toString());
          print(_valueCauT);
        });
      },
      child: Center(child: Text(_valueCauT.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return listCau.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ):
    (i == 1 && j == 1) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueTruT = double.parse(value.toString());
        });
      },
      child: Center(child: Text(_valueTruT.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return listTru.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ):
    (i == 1 && j == 2) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueTrucT = double.parse(value.toString());
        });
      },
      child: Center(child: Text(_valueTrucT.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return listTruc.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ):
    (i == 1 && j == 3) ?
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueAddT  = double.parse(value.toString());
        });
      },
      child: Center(child: Text(_valueAddT.toString(),style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return congThem.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text(choice.toString()),
          );}
        ).toList();
      },
    ) :
    PopupMenuButton(
      // icon: Icon(MdiIcons.sortVariant),
      //onSelected: _select,
      onSelected: (value) {
        setState(() {
          _valueThiLucT = double.parse(value.toString());
        });
      },
      child: Center(child: Text('${_valueThiLucT.toString()} /10',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)),
      padding: EdgeInsets.zero,
      // initialValue: choices[_selection],
      itemBuilder: (BuildContext context) {
        return thiLuc.map((double choice) {
          return  PopupMenuItem<String>(
            value: choice.toString(),
            child: Text('${choice.toString()} /10'),
          );}
        ).toList();
      },
    )
    ;
  }

  Widget buildPageReport(BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 25),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1. Thông số về mắt',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Container(
                height: 170,
                padding: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: LazyDataTable(
                  rows: listHeaderRow.length,
                  columns: listHeaderTitle.length,
                  tableDimensions: LazyDataTableDimensions(
                    cellHeight: 50,
                    cellWidth: 100,
                    columnHeaderHeight: 60,
                    rowHeaderWidth: 75,
                  ),
                  tableTheme: LazyDataTableTheme(
                    columnHeaderBorder: Border.all(color: Colors.black38),
                    rowHeaderBorder: Border.all(color: Colors.black38),
                    cellBorder: Border.all(color: Colors.black38),
                    cornerBorder: Border.all(color: Colors.black38),
                    columnHeaderColor: Colors.white60,
                    rowHeaderColor: Colors.white60,
                    cellColor: Colors.white,
                    cornerColor: Colors.white38,
                  ),
                  columnHeaderBuilder: (i) => Center(child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        Text('${listHeaderTitle[i]}'),
                        Text('${listHeaderDesc[i]}',style: TextStyle(fontSize: 11,color: Colors.grey),),
                      ],
                    ),
                  )),
                  rowHeaderBuilder: (i) => Center(child: Text("${listHeaderRow[i]}",style: TextStyle(color: i % 2 == 1 ? Colors.purple :  Colors.pink),)),
                  dataCellBuilder: (i, j) => Center(child: PupopMenu(i,j)),

                  cornerWidget: Center(child:  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        Text('Mắt'),
                        Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                      ],
                    ),
                  ),),
                ),
              ),
              SizedBox(height: 10,),
              Text('2. Thông số về KCDT (PD)',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Table(
                  border: TableBorder.all(), // Allows to add a border decoration around your table
                  children: [
                    TableRow(children :[
                      Container(
                        width: 220,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  Column(
                            children: [
                              Text('Mắt'),
                              Text('(EYE)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('PD/2'),
                            Text('(CYL)',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('PD'),
                            Text('',style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children :[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Center(child: Text('Phải',style: TextStyle(color: Colors.pink),)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Center(child: Utils.isEmpty(listTru) ? Container() : Container(
                          // width: 25,
                          child: textField(pdPhai2Controller,pdPhai2Focus),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Center(child: Utils.isEmpty(listTru) ? Container() : Container(
                          // width: 25,
                          child: textField(pdPhaiController,pdPhaiFocus),
                        )),
                      ),
                    ]),
                    TableRow(children :[
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Center(child: Text('Trái',style: TextStyle(color: Colors.purple),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Center(child: Utils.isEmpty(listTru) ? Container() : Container(
                          // width: 25,
                          child: textField(pdTrai2Controller,pdTrai2Focus),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Center(child: Utils.isEmpty(listCau) ? Container() : Container(
                        )),
                      ),
                    ]),
                  ]
              ),
              SizedBox(height: 10,),
              Text('3. Khoảng  nhìn',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                checkbox(
                    title: "Nhìn Xa",
                    initValue: nhinXa,
                    onChanged: (sts) => setState(() => nhinXa = sts)),
                checkbox(
                    title: "Nhìn Trung",
                    initValue: nhinTrung,
                    onChanged: (sts) => setState(() => nhinTrung = sts)),
                checkbox(
                    title: "Nhìn Gần",
                    initValue: nhinGan,
                    onChanged: (sts) => setState(() => nhinGan = sts)),
              ]),
              SizedBox(height: 10,),
              Text('4. Kính gọng',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      checkboxL(
                          title: "Đơn Tròng",
                          initValue: donTrong,
                          onChanged: (sts) => setState(() => donTrong = sts)),
                      checkbox(
                          title: "Đa Tròng",
                          initValue: daTrong,
                          onChanged: (sts) => setState(() => daTrong = sts)),

                    ]),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      checkboxL(
                          title: "Hai Tròng",
                          initValue: haiTrong,
                          onChanged: (sts) => setState(() => haiTrong = sts)),
                      checkbox(
                          title: "Glas",
                          initValue: glas,
                          onChanged: (sts) => setState(() => glas = sts)),

                    ]),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      checkboxL(
                          title: "Mắt đặt",
                          initValue: matDat,
                          onChanged: (sts) => setState(() => matDat = sts)),
                      checkbox(
                          title: "Mắt màu",
                          initValue: matMau,
                          onChanged: (sts) => setState(() => matMau = sts)),
                    ]),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      checkboxL(
                          title: "Plastic",
                          initValue: plastic,
                          onChanged: (sts) => setState(() => plastic = sts)),
                      checkbox(
                          title: "Phân cực",
                          initValue: phanCuc,
                          onChanged: (sts) => setState(() => phanCuc = sts)),
                    ]),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      checkboxL(
                          title: "Hấp màu",
                          initValue: hapMau,
                          onChanged: (sts) => setState(() => hapMau = sts)),
                      checkbox(
                          title: "Đổi màu",
                          initValue: doiMau,
                          onChanged: (sts) => setState(() => doiMau = sts)),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () => _showDialog(context),
                  child: Container(
                      width: 200,
                      height: 30,
                      child: Row(
                        children: [
                          Icon(MdiIcons.attachment,color: Colors.blueGrey,),
                          Text('${(_bloc.file.path.isNotEmpty && _bloc.file.path.toString() != '' && _bloc.file.path.toString() != 'null') ? '  Đã đính kèm 1 file' :  '  Attach file đính kèm'}',style: TextStyle(color: _bloc.file == null ? Colors.black : Colors.red),),
                        ],
                      )),
                ),
              ),
              SizedBox(height: 25,),
              buildButton(context),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Ảnh đại diện"),
            actions: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Thư viện"),
                    onPressed: () {
                      _bloc.add(UploadAvatarEvent(false));
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("Máy Ảnh"),
                    onPressed: () {
                      _bloc.add(UploadAvatarEvent(true));
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget buildButton(BuildContext context){
    return  GestureDetector(
      onTap: (){
        cpDetail = CqDetail(
            cqMpCau: _valueCau,
            cqMpTru: _valueTru,
            cqMpTruc: _valueTruc,
            cqMpCong: _valueAdd,cqMpTl: _valueThiLuc,
            cqMtCau: _valueCauT,cqMtTru: _valueTruT,cqMtTruc: _valueTruT,cqMtCong: _valueAddT,cqMtTl: _valueThiLucT,cqMpKcDt: !Utils.isEmpty(pdPhai2Controller.text) ? double.parse(pdPhai2Controller.text) : 0,
            cqMtKcDt: !Utils.isEmpty(pdTrai2Controller.text) ? double.parse(pdTrai2Controller.text) : 0,cqMpKcDtXa:!Utils.isEmpty(pdPhaiController.text) ? double.parse(pdPhaiController.text) :0,
            cqNx: nhinXa == true ? 1 : 0,
            cqNg: nhinGan == true ? 1 : 0,
            cqNt: nhinTrung == true ? 1 : 0,
            kg1t: donTrong == true ? 1 : 0,
            kgNt: daTrong == true ? 1 : 0,
            kgMd: matDat == true ? 1 : 0,
            kgMau: matMau == true ? 1 : 0,
            kgPla: plastic == true ? 1 :0,
            kgPc:  phanCuc == true ? 1 :0,
            kgHm: hapMau == true ? 1 :0,
            kgDm: doiMau == true ? 1 :0,
            kg2t: haiTrong == true ? 1 : 0,
            kgGlas: glas == true ? 1 : 0
        );
        Navigator.pop(context,[cpDetail,_bloc.file]);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Container(
          // width: 100.0,
          height: 45.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: mainColor
          ),
          child: Center(
            child: Text(
              'Xác nhận',
              style: TextStyle(fontSize: 16, color: white,),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}