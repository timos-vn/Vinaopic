import 'package:get/get.dart' as libGetX;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/item_scan.dart';
import 'package:vinaoptic/pages/detail_oder/detail_order_page.dart';
import 'package:vinaoptic/pages/qr_code/qr_code_bloc.dart';
import 'package:vinaoptic/pages/qr_code/qr_code_event.dart';
import 'package:vinaoptic/pages/qr_code/qr_code_sate.dart';
import 'package:vinaoptic/pages/search_product/search_product_page.dart';
import 'package:vinaoptic/widget/quantity_widget.dart';

class QRCodePage extends StatefulWidget {

  final int? typeView;

  QRCodePage({Key? key, this.typeView}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage>{
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late QRCodeBloc _bloc;
  bool resultSent = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = QRCodeBloc(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Quét mã sản phẩm",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              if(widget.typeView == 1){
                resultSent = true;
                Navigator.pop(context,[_bloc.listChildItemSelected]);
              }
              else{
                if(!Utils.isEmpty(_bloc.listChildItemSelected)){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailOrderPage(
                    listChildItemScan: _bloc.listChildItemSelected,
                  ))).then((value){
                    if (value == Const.REFRESH) {
                      _bloc.listChildItemSelected.clear();
                      setState(() {});
                      // _bloc.add(RefreshEvent());
                    }
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.check,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: BlocListener<QRCodeBloc, QRCodeState>(
        bloc: _bloc,
        listener: (context,state){
          if (state is QRCodeFailure) {
            // _bloc.add(RefreshEvent());
          }
        },
        child: BlocBuilder<QRCodeBloc, QRCodeState>(
          bloc: _bloc,
          builder: (BuildContext context, QRCodeState state){
            return Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: Utils.isEmpty(_bloc.listChildItemSelected) ?  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Image.asset(noData,fit: BoxFit.contain,),
                    ),
                  )
                      :
                  Container(
                    color: Colors.grey.withOpacity(0.1),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Table(
                          defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(1.5),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1.5),
                            3: FlexColumnWidth(0.5),
                          },
                          children: tableGenerate(),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 80,
                  child:  Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 40,right: 40,top: 15,bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                              color: Colors.blueGrey
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  pushNewScreen(context, screen: SearchProductPage(),withNavBar: false).then((value){
                                    if(value!= null  && value !='null'){
                                      _bloc.add(ScanItemEvent(value));
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(MdiIcons.shoppingSearch,color: Colors.white,size: 20),
                                    SizedBox(width: 10,),
                                    Center(child: Text('Tìm kiếm',style: TextStyle(
                                      color: white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30,),
                              Container(
                                height: 20,
                                width: 1,
                                color: Colors.white,
                              ),
                              SizedBox(width: 30,),
                              GestureDetector(
                                onTap: ()async{
                                  try{
                                    String code = await FlutterBarcodeScanner.scanBarcode(
                                        "#8CC63F",
                                        'Cancel'.tr,
                                        true,
                                        ScanMode.DEFAULT
                                    );
                                    if(!Utils.isEmpty(code) && code != '-1'){
                                      print("code123 => " + code);
                                      _bloc.add(ScanItemEvent(code));
                                    }
                                  }catch(e){
                                    print(e);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(MdiIcons.qrcodeScan,color: Colors.white,size: 20,),
                                    SizedBox(width: 10,),
                                    Center(child: Text('QRCode',style: TextStyle(
                                      color: white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      )
    );
  }

  List<TableRow> tableGenerate() {
    List<ItemScanData> listItemSelected = _bloc.listChildItemSelected;
    List<TableRow> tableRows = [];
    tableRows.add(TableRow(children: [
      TableCell(
          child: Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              'Mã hàng',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          )),
      TableCell(
          child: Container(
            margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              'Đơn giá',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          )),
      TableCell(
          child: Container(
            margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              'Số lượng',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          )),
      TableCell(
          child: Container(
            margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              'Xoá',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          )),
    ]));
    for (int i = 0; i < listItemSelected.length; i++) {
      ItemScanData data = listItemSelected[i];
      tableRows.add(TableRow(children: [
        TableCell(
            child: Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Text(
                data.maVt ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            )),
        TableCell(
            child: Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Text( !Utils.isEmpty(data.gia!) ?
                Utils.formatTotalMoney(data.gia) : "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            )),
        TableCell(
            child: Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: QuantityWidget(
                initQuantity: data.soLuong!.round(),
                valueChanged: (quantity) {
                  _bloc.listChildItemSelected[i].soLuong = quantity;
                },
              ),
            )),
        TableCell(
            child: Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: IconButton(
                icon: Icon(
                  MdiIcons.trashCanOutline,
                  color: black,
                ),
                onPressed: () async {
                  _bloc.listChildItemSelected.removeAt(i);
                  setState(() {

                  });
                  // _bloc.add(RefreshEvent());
                },
              ),
            )),
      ]));
    }
    return tableRows;
  }
}