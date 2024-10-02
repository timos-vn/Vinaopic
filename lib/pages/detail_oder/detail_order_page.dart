import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/extension/default_grabbing.dart';
import 'package:vinaoptic/pages/customer/list_history_customer/list_history_customer_page.dart';
import 'package:vinaoptic/pages/optical_correction/optical_correction_page.dart';
import 'package:vinaoptic/pages/qr_code/qr_code_page.dart';
import 'package:vinaoptic/pages/search_customer/search_customer_page.dart';
import 'package:vinaoptic/models/network/request/send_invoice_request.dart' as itemSendInvoice;
import 'package:vinaoptic/models/network/request/update_order_request.dart';
import 'package:vinaoptic/models/network/response/item_scan.dart';
import 'package:vinaoptic/models/network/response/search_customer_response.dart';

import 'package:vinaoptic/widget/pending_action.dart';

import 'detail_order_bloc.dart';
import 'detail_order_event.dart';
import 'detail_order_state.dart';

class DetailOrderPage extends StatefulWidget {
  final String? nameCustomer;
  final String? phoneCustomer;
  final String? addressCustomer;
  final String? maKH;
  final List<ItemScanData>? listChildItemScan;
  final int? typeView;
  final String? sttRec;
  final String? dienGiai;

  DetailOrderPage({Key? key,this.nameCustomer,this.phoneCustomer,this.addressCustomer,this.maKH,this.listChildItemScan,this.typeView,this.sttRec,this.dienGiai}) : super(key: key);

  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage>{
  final ScrollController listViewController = new ScrollController();
  ScrollController scrollController = ScrollController();

  late SearchCustomerResponseData itemReSearch;
  String storeName = '',storeID = '',email = '';
  String sex = '';int idSex = 0;
  final addressController = TextEditingController();
  final FocusNode addressFocus = FocusNode();

  final fullNameController = TextEditingController();
  final FocusNode fullNameFocus = FocusNode();

  final dienGiaiController = TextEditingController();
  final FocusNode dienGiaiFocus = FocusNode();
  final phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  final birthDayController = TextEditingController();
  final FocusNode birthDayFocus = FocusNode();

  List<ItemScanData> _listChildItemScan = [];
  CqDetail cpDetail = CqDetail(
    cqMpCau: 0,
    cqMpTru: 0,
    cqMpTruc: 0,
    cqMpCong: 0,
    cqMpTl: 0,
    cqMtCau: 0,
    cqMtTru: 0,
    cqMtTruc: 0,
    cqMtCong: 0,
    cqMtTl: 0,
    cqMpKcDt: 0,
    cqMtKcDt: 0,
    cqMpKcDtXa: 0,
    cqNx: 0,
    cqNg: 0,
    cqNt: 0,
    kg1t: 0,
    kgNt: 0,
    kgMd: 0,
    kgHm: 0,
    kgPla: 0,
    kgPc: 0,
    kgMau: 0,
    kgDm: 0,
    kgGlas: 0,
    kg2t: 0
  );

  String date = '';
  String bthrday = '';
  late DetailOrderBloc _bloc;
  late File image ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = DetailOrderBloc(context);
    _listChildItemScan = [];

    fullNameController.text = widget.nameCustomer.toString();
    phoneController.text = widget.phoneCustomer.toString();
    addressController.text = widget.addressCustomer.toString();
    if(widget.listChildItemScan != null){
      _listChildItemScan = widget.listChildItemScan!;
    }
    if(widget.typeView == 1){
      _bloc.add(GetItemDetailEvent(widget.sttRec.toString()));
    }else{

      _bloc.add(CheckDataEvent(widget.maKH,listItemScanData: widget.listChildItemScan));
    }

  }

  void ShowOnDialogInputInfo(){
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromTop,
      curve: Curves.linear,
      duration: Duration(seconds: 1),
      alignment: Alignment.topCenter,
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 0),
            child: Container(
              margin: MediaQuery.of(context).viewInsets,
              height: 450,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Họ & Tên KH'),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              maxLines: 1,
                              //obscureText: true,
                              controller: fullNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                                hintText: 'Nguyễn Văn A',
                                hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12),
                              ),
                              // focusNode: focusNodeTitle,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                              //textInputAction: TextInputAction.none,
                            ),),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCustomerPage(typeView: 0 ,))).then((value){
                                if(value != null){
                                  itemReSearch = value;
                                  setState(() {
                                    phoneController.text = itemReSearch.dienThoai.toString();
                                    fullNameController.text  = itemReSearch.tenKh.toString();
                                    addressController.text = itemReSearch.diaChi.toString();
                                    birthDayController.text = itemReSearch.ngaySinh.toString();
                                    email = itemReSearch.email.toString();
                                    if(itemReSearch.ngaySinh!=null){
                                      _bloc.add(PickDate( DateTime.parse(itemReSearch.ngaySinh.toString())));
                                    }
                                    sex = itemReSearch.sex == 2 ? 'Nữ' : itemReSearch.sex == 1 ? 'Nam' : 'Khác';
                                    idSex = itemReSearch.sex!;
                                  });
                                }
                              });
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.search,color: Colors.grey,),
                                  SizedBox(width: 10,),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Ngày sinh'),
                    ),
                    SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Utils.dateTimePickerCustom(context).then((date){
                          if(date != null){
                            setState(() {
                              birthDayController.text = Utils.parseDateToString(date, Const.DATE_SV_FORMAT_2);
                            });
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                maxLines: 1,
                                enabled: false,
                                //obscureText: true,
                                controller: birthDayController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                                  hintText: '04-03-1995',
                                  hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12),
                                ),
                                // focusNode: focusNodeTitle,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                                //textInputAction: TextInputAction.none,
                              ),),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.arrow_drop_down_outlined,color: Colors.grey,),
                                  SizedBox(width: 10,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Số điện thoại'),
                    ),
                    SizedBox(height: 5,),
                    GestureDetector(
                      // onTap: ()=> FocusScope.of(context).requestFocus(focusNodeTitle),
                      child:  Container(
                        height: 40 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          // border: Border.all(color: Colors.grey,width: 0.5)
                        ),
                        child: TextField(
                          maxLines: 1,
                          //obscureText: true,
                          controller: phoneController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                color: Colors.grey,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                color: Colors.grey, ),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Vui lòng nhập số điện thoại',
                            hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12),
                          ),
                          focusNode: phoneFocus,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
                          onSubmitted: (text) => Utils.navigateNextFocusChange(context,  phoneFocus,  addressFocus),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Địa chỉ'),
                    ),
                    SizedBox(height: 5,),
                    GestureDetector(
                      // onTap: ()=> FocusScope.of(context).requestFocus(focusNodeTitle),
                      child:  Container(
                        height: 40 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: TextField(
                          maxLines: 1,
                          //obscureText: true,
                          controller: addressController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                color: Colors.grey,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                color: Colors.grey, ),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Vui lòng nhập địa chỉ',
                            hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12),
                          ),
                          focusNode: addressFocus,
                          onSubmitted: (text) => Utils.navigateNextFocusChange(context,  addressFocus,  dienGiaiFocus),
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Diễn giải'),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      height: 40,
                      child: TextField(
                        maxLines: 1,
                        //obscureText: true,
                        controller: dienGiaiController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                          hintText: 'Nội dung',
                          hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey,fontSize: 12),
                        ),
                        focusNode: dienGiaiFocus,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14),
                        // onSubmitted: (text) => Utils.navigateNextFocusChange(context,  usernameFocus,  passwordFocus),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    SizedBox(height: 20,),
                    buildButtonLogin(context)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailOrderBloc,DetailOrderState>(
      bloc: _bloc,
      listener: (context,state){
        if(state is CheckScanDataSuccess){
          print('on');
          ShowOnDialogInputInfo();
        }else if(state is SendInvoiceSuccess){
          Utils.showCustomToast(context,Icons.check_circle_outline,'Đặt đơn hàng thành công.');
          Navigator.pop(context,Const.REFRESH);
        }else if(state is UpdateOrderSuccess){
          Utils.showCustomToast(context,Icons.check_circle_outline,'Cập nhật đơn hàng thành công');
          Navigator.pop(context,Const.REFRESH);
        }else if (state is CreateNewsCustomerSuccess){

        }else if(state is GetDetailOrderSuccess){
          fullNameController.text = _bloc.listMaster[0].tenKh.toString();
          phoneController.text = _bloc.listMaster[0].dienThoai.toString();
          dienGiaiController.text = widget.dienGiai.toString();
          _bloc.listProduct.forEach((element) {
            ItemScanData itemScanData = ItemScanData(
                dvt: element.dvt,soLuong: element.soLuong,maKho: element.maKho,heSo: 0,gia: element.giaNt2,tlCk: element.tlCk,
                stock: 0, imageUrl: '',nuocSx: element.nuocSx,maVt: element.maVt,tenVt: element.tenVt,nhVt1: '',nhVt2: '',nhVt3: '',
                status: 0,brand: '',color: '',eyeSize: 0.0,bridgeSize: 0.0
            );
            _listChildItemScan.add(itemScanData);
          });
          _bloc.add(CheckDataEvent(widget.maKH,listItemDetail: _bloc.listProduct));
        }else if(state is DetailOrderFailure){
          Utils.showCustomToast(context,Icons.warning_amber_outlined,state.error);
        }
      },
      child: BlocBuilder<DetailOrderBloc,DetailOrderState>(
        bloc: _bloc,
        builder: (BuildContext context,DetailOrderState state){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: mainColor,
                title: Text('Chi tiết đơn hàng',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        InkWell(
                            onTap:()=> widget.typeView == 1 ? pushNewScreen(context, screen: FormChinhQuangPage(),withNavBar: false).then((value) {
                              if(value!= 'null' && value != null){
                                cpDetail = value[0];
                                image = value[1];
                              }
                            }): null,
                            child: Icon(MdiIcons.microsoftOnenote,color: widget.typeView == 1 ? Colors.white : mainColor  ,)),
                        SizedBox(width: 20,),
                        GestureDetector(
                            onTap: (){
                              if( widget.typeView == 1){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodePage(typeView: 1,))).then((value) {
                                  if(!Utils.isEmpty(value)){
                                    var lisk = value[0];
                                    List<ItemScanData> listChildItemSelected = [];
                                    listChildItemSelected = lisk;
                                    if( _listChildItemScan.isNotEmpty){
                                      _listChildItemScan.clear();
                                    }
                                    _bloc.add(CheckListProductOrderEvent(listChildItemSelected));
                                  }
                                });
                              }

                            },
                            child: Icon(Icons.qr_code_scanner_outlined,color: widget.typeView == 1 ? Colors.white : mainColor,)),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                ],
              ),
              body: buildPage(context, state));
        },
      ),
    );

    //   Scaffold(
    //     resizeToAvoidBottomInset : false,
    //     body:
    // );
  }


  Widget buildPage(BuildContext context,DetailOrderState state){
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: SnappingSheet(
            lockOverflowDrag: true,
            snappingPositions: [
              SnappingPosition.factor(
                positionFactor: 0.3,
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
              SnappingPosition.factor(
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1750),
                positionFactor: 0.1,
              ),
              // SnappingPosition.factor(positionFactor: 0.9),
            ],
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.only(left: 0,right: 0,top: 16,bottom: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      icLogo,
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text('Khách hàng:')),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    borderRadius: BorderRadius.circular(30)
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text(fullNameController.text),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: (){
                                                          if( widget.typeView == 1){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ListHistoryCustomerPage(
                                                              maKH: widget.maKH,nameCustomer:widget.nameCustomer,)));
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 10),
                                                          child: Icon(MdiIcons.cardAccountDetails,color: widget.typeView == 1 ? mainColor : Colors.white,),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            Expanded(child: Text('Số điện thoại:')),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    borderRadius: BorderRadius.circular(30)
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text(phoneController.text.toString().trim()),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                        // onTap: () => launch("tel://${widget.phoneCustomer??0963004959}"),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 10),
                                                          child: Icon(MdiIcons.phoneInTalk,color: widget.typeView == 1 ? mainColor : Colors.white,),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text('Diễn giải:'),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 16,right: 10,top: 10,bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(dienGiaiController.text,style: TextStyle(fontSize: 11),),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Text('Danh sách sản phẩm',style: TextStyle(color: Colors.grey,fontSize: 12),),
                            Expanded(child: Divider()),
                          ],
                        ),
                        _listChildItemScan == null ? Container() :
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 30),
                            child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    color: Colors.white.withOpacity(0.9),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            width: 150,
                                                            height: 100,
                                                            padding: EdgeInsets.all(2),
                                                            decoration: BoxDecoration(
                                                                color: Colors.transparent,
                                                                borderRadius: BorderRadius.only(
                                                                  topRight: Radius.circular(2),
                                                                  topLeft: Radius.circular(2),
                                                                  bottomRight:  Radius.circular(2),
                                                                  bottomLeft:  Radius.circular(2),
                                                                )
                                                            ),
                                                            child:  Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.all(Radius.circular(40))
                                                              ),
                                                              child:// _listChildItemScan[index].imageUrl == null ?
                                                              Image.network('https://product.hstatic.net/1000392226/product/ct0101sa-003_2bfad2c052a64f01946e51ed2c5c67b2_large.jpg',fit: BoxFit.fill,)
                                                                  //:Image.network(_listChildItemScan[index].imageUrl ,fit: BoxFit.fill, )  ,
                                                            )
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            InkWell(
                                                              onTap:  _listChildItemScan[index].soLuong! <= 1 ? null : () {
                                                                setState(() {
                                                                  _listChildItemScan[index].soLuong =_listChildItemScan[index].soLuong! - 1 ;
                                                                });
                                                                _bloc.add(CalculatorMoneyEvent(_listChildItemScan));
                                                                //widget.valueChanged(_quantity);
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                child: Icon(
                                                                  MdiIcons.minusCircleOutline,
                                                                  color: _listChildItemScan[index].soLuong! > 1 ? black : blackBlur,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  Utils.formatTotalMoney(_listChildItemScan[index].soLuong).toString(),
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontSize: 12, color: black, fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _listChildItemScan[index].soLuong =_listChildItemScan[index].soLuong! + 1 ;
                                                                });
                                                                _bloc.add(CalculatorMoneyEvent(_listChildItemScan));
                                                                // widget.valueChanged(_quantity);
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                child: Icon(
                                                                  MdiIcons.plusCircleOutline,
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 16),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text('SP:')),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text(_listChildItemScan[index].tenVt??"",style: TextStyle(color: mainColor))),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text('MSP:')),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text(_listChildItemScan[index].maVt??'',style: TextStyle(color: Colors.grey))),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text('XS:')),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text(_listChildItemScan[index].nuocSx.toString(),style: TextStyle(color: Colors.grey))),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: [

                                                            Expanded(
                                                                child: Text('Giá:')),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text("${Utils.formatTotalMoney(_listChildItemScan[index].gia??0).toString()} vnđ",style: TextStyle(color: Colors.red))),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: [

                                                            Expanded(
                                                                child: Text('CK:')),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text("${_listChildItemScan[index].tlCk?.toString()??''} %",style: TextStyle(color: Colors.grey),)),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                      ],
                                                    ),
                                                  )),
                                              InkWell(
                                                  onTap:(){
                                                    setState(() {
                                                      _listChildItemScan.removeAt(index);
                                                    });
                                                    _bloc.add(CalculatorMoneyEvent(_listChildItemScan));
                                                  },
                                                  child: Icon(Icons.delete_forever,color: mainColor,)),
                                            ],
                                          ),
                                        ),
                                        // Positioned(
                                        //   top: 6,right: 6,
                                        //   child: InkWell(
                                        //       onTap:(){
                                        //         setState(() {
                                        //           _listChildItemScan.removeAt(index);
                                        //         });
                                        //         _bloc.add(CalculatorMoneyEvent(_listChildItemScan));
                                        //       },
                                        //       child: Icon(Icons.delete_forever,color: mainColor,)),
                                        // )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => Container(),
                                itemCount: _listChildItemScan.length),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            grabbingHeight: 50,
            grabbing: DefaultGrabbing(),
            sheetBelow: SnappingSheetContent(
              // childScrollController: scrollController,
                draggable: false,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    reverse: false,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Tổng:  ',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                                      Text('${Utils.formatTotalMoney(_bloc.total)} vnđ',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('Tạm tính:  ',style: TextStyle(color: Colors.grey,),),
                                      Text('${Utils.formatTotalMoney(_bloc.total)} vnđ',style: TextStyle(color: Colors.grey,),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('Thuế:  ',style: TextStyle(color: Colors.grey,),),
                                      Text('0',style: TextStyle(color: Colors.grey,),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('Chiết khấu:  ',style: TextStyle(color: Colors.grey,),),
                                      Text('${Utils.formatTotalMoney(_bloc.ck)}%',style: TextStyle(color: Colors.grey,),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: widget.typeView != 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(height: 45,),
                                  InkWell(
                                    onTap: () {
                                      if(!Utils.isEmpty(_listChildItemScan)){
                                        if(widget.typeView == 1){
                                          List<UpdateOrderRequestDetail> _listBillDetail = [];
                                          _listChildItemScan.forEach((element) {
                                            UpdateOrderRequestDetail _itemUpdate = UpdateOrderRequestDetail(
                                                soLuong: element.soLuong!.toInt(),giaNt2: element.gia,tlCk: element.tlCk,maVt: element.maVt,maKho: element.maKho
                                            );
                                            _listBillDetail.add(_itemUpdate);
                                          });
                                          _bloc.add(UpdateOrderEvent(listBillDetail: _listBillDetail,sttRec: widget.sttRec,cpDetail: cpDetail));
                                        }
                                        else {
                                          if(Utils.isEmpty(fullNameController.text) && Utils.isEmpty( phoneController.text )&& Utils.isEmpty(addressController.text)
                                              && Utils.isEmpty(dienGiaiController.text) && Utils.isEmpty(birthDayController.text)){
                                            ShowOnDialogInputInfo();
                                          }
                                          else{
                                            List<itemSendInvoice.Detail> _list = [];
                                              _listChildItemScan.forEach((element) {
                                                itemSendInvoice.Detail item = itemSendInvoice.Detail(
                                                  soLuong: element.soLuong!.toInt(),
                                                  gia: element.gia,
                                                  tlCk: element.tlCk,
                                                  maVt: element.maVt,
                                                  maKho: element.maKho,
                                                );
                                                _list.add(item);
                                              });
                                              _bloc.add(OrderBillEvent(
                                                  _list,fullNameController.text,phoneController.text,addressController.text,dienGiaiController.text,birthDayController.text
                                              ));
                                          }
                                        }
                                      }
                                      else{
                                        Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng thêm sản phẩm vào đơn hàng');
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
                                      decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Center(
                                        child: Text(widget.typeView == 1 ? "Cập nhật" : 'Đặt hàng',style: TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
        ),
        Visibility(
          visible: state is DetailOrderLoading,
          child: PendingAction(),
        ),
      ],
    );
  }

  Widget buildButtonLogin(BuildContext context){
    return  GestureDetector(
      onTap: (){
        if(Utils.isEmpty(fullNameController.text) && Utils.isEmpty( phoneController.text )&& Utils.isEmpty(addressController.text) && Utils.isEmpty(dienGiaiController.text)){
          Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng nhập đầy đủ thông tin trên phiếu');
        }
        else{
          Navigator.pop(context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Row(
           children: [
             Icon(MdiIcons.arrowRightBoldHexagonOutline,color: Colors.red,size: 18,),
             SizedBox(width: 5,),
             Text(
               'Vui lòng nhập thông tin KH đặt hàng',
               style: TextStyle( fontSize: 10, color: Colors.grey,),
               textAlign: TextAlign.left,
             ),
           ],
         ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(

              child: Container(
                width: 100.0,
                height: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: mainColor
                ),
                child: Center(
                  child: Text(
                    'Xác nhận',
                    style: TextStyle( fontSize: 16, color: white,),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}