import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/models/network/response/info_store_response.dart';
import 'package:vinaoptic/models/network/response/search_customer_response.dart';
import 'package:vinaoptic/pages/make_appointment/search_province/search_province_screen.dart';
import 'package:vinaoptic/widget/pending_action.dart';
import 'package:vinaoptic/widget/text_field_widget3.dart';

import '../../core/untils/const.dart';
import '../../widget/custom_confirm.dart';
import '../../widget/text_field_widget2.dart';
import '../search_customer/search_customer_page.dart';
import 'component/event.dart';
import 'make_appointment_bloc.dart';
import 'make_appointment_event.dart';
import 'make_appointment_sate.dart';


class MakeAppointmentPage extends StatefulWidget {

  final String? storeName;
  final String? storeId;

  const MakeAppointmentPage({Key? key, this.storeName, this.storeId}) : super(key: key);

  @override
  _MakeAppointmentPageState createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage> with TickerProviderStateMixin {
  late TabController tabController;
  List<String> listTabView = ["Đặt lịch","Tạo mới & đặt lịch"];
  List<String> _listSex = [
    'Nam',
    'Nữ',
    'Khác'
  ];

  bool isFree = false;
  bool createNewCustomer = false;
  int idSex = 0;

  final addressController = TextEditingController();
  final addressController2 = TextEditingController();
  final FocusNode addressFocus = FocusNode();

  final fullNameController = TextEditingController();
  final fullNameController2 = TextEditingController();
  final FocusNode fullNameFocus = FocusNode();

  final notesController = TextEditingController();
  final notesController2 = TextEditingController();
  final FocusNode notesFocus = FocusNode();

  final emailController2 = TextEditingController();
  final emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  final phoneController = TextEditingController();
  final phoneController2 = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  final storeController = TextEditingController();

  final phieuController = TextEditingController();

  final birthDayController = TextEditingController();
  final birthDayController2 = TextEditingController();
  String ngaySinh = '';
  String ngaySinh2 = '';
  final sexController = TextEditingController();
  final sexController2 = TextEditingController();

  // InfoStoreResponseData? item;
  SearchCustomerResponseData itemReSearch = SearchCustomerResponseData();
  SearchCustomerResponseData itemReSearch2 = SearchCustomerResponseData();
  late MakeAppointmentBloc _bloc;
  // String _dateOrder = Jiffy(DateTime.now()).format('yyyy-MM-dd');
  String idStore = '';

  int dataType = 7;

  final _provinceController = TextEditingController();
  final _provinceController2 = TextEditingController();
  String idProvince = '';
  String idProvince2 = '';

  final _districtController = TextEditingController();
  final _districtController2 = TextEditingController();
  String idDistrict = '';
  String idDistrict2 = '';

  final _communeController = TextEditingController();
  final _communeController2 = TextEditingController();
  String idCommune = '';
  String idCommune2 = '';

  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: listTabView.length);
    _bloc = MakeAppointmentBloc(context);
    phieuController.text = 'Phiếu khám';
    idStore = widget.storeId.toString();
    storeController.text = widget.storeName.toString();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeAppointmentBloc,MakeAppointmentState>(
      bloc: _bloc,
      listener: (context,state){
       if(state is CreatesMakeAppointmentNewsSuccess){
          showDialog(
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: CustomConfirm(
                    title: dataType == 7 ? 'Đặt Phiếu khám thành công!' : dataType == 4 ? 'Đặt Phiếu mua hàng thành công!' : 'Đặt Phiếu sửa chữa thành công!',
                    content: 'Chúng tôi sẽ xác nhận yêu cầu của bạn sớm',
                    type: 0,
                  ),
                );
              }).then((value) {
            Navigator.pop(context);
          });
        }
       else if(state is MakeAppointmentFailure) {
         Utils.showCustomToast(context,Icons.warning_amber_outlined,state.error);
       }
      },
      child: BlocBuilder<MakeAppointmentBloc,MakeAppointmentState>(
        bloc: _bloc,
        builder: (BuildContext context,MakeAppointmentState state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Text('Đặt lịch hẹn',style: TextStyle(color: Colors.white),),
              centerTitle: true,
              actions: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: Switch(
                    activeColor: Colors.orange,
                    hoverColor: Colors.orange,
                    value: isFree,
                    onChanged: (bool value) {
                      setState(() {
                        isFree = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  color: const Color(0xFFffffff),
                  padding:  const EdgeInsets.symmetric(horizontal: 3),
                  margin: const EdgeInsets.only(top: 5),
                  width: double.infinity,height: double.infinity,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 5),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.0),
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2)),
                          ),
                          child: TabBar(
                            controller: tabController,
                            unselectedLabelColor: Colors.grey.withOpacity(0.8),
                            labelColor: Colors.red,
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            isScrollable: false,
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorColor: Colors.red,
                            dividerColor: Colors.red,automaticIndicatorColorAdjustment: true,
                            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.red,
                                    width: 2
                                ),
                              ),
                            ),
                            tabs: List<Widget>.generate(listTabView.length, (int index) {
                              return Tab(
                                text: listTabView[index].toString(),
                              );
                            }),
                            onTap: (index){
                              // setState(() {
                              //   tabIndex = index;
                              // });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Container(
                            color: grey_100,
                            child: TabBarView(
                                controller: tabController,
                                children: List<Widget>.generate(listTabView.length, (int index) {
                                  for (int i = 0; i <= listTabView.length; i++) {
                                    if(index == 0){
                                      return buildPageNew(context,state,true);
                                    }else{
                                      return buildPageNew2(context,state,false);
                                    }
                                  }
                                  return const Text('');
                                })),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: state is MakeAppointmentLoading,
                  child: PendingAction(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPageNew(BuildContext context,MakeAppointmentState state,bool createNewCustomer){
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            TableCalendar<Event>(
              rowHeight: 70,
              daysOfWeekHeight: 20,
              // isMargin: 0,
              simpleSwipeConfig: const SimpleSwipeConfig(
                verticalThreshold: 0.2,
                swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
              ),
              calendarBuilders: CalendarBuilders(
                // todayBuilder: (context, date, _){
                //   return Padding(
                //     padding: const EdgeInsets.only(bottom: 11),
                //     child: Container(
                //       decoration: new BoxDecoration(
                //         color: mainColor.withOpacity(0.8),
                //         shape: BoxShape.circle,
                //       ),
                //       // margin: const EdgeInsets.all(4.0),
                //       width: 45,
                //       height: 45,
                //       child: Center(
                //         child: Text(
                //           '${date.day}',
                //           style: TextStyle(
                //             fontSize: 16.0,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
                // },
                  selectedBuilder: (context, date, _) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 11),
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(150)
                        ),
                        // margin: const EdgeInsets.all(4.0),
                        width: 45,
                        height: 45,
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  markerBuilder: (context,date, event){
                    return Container(
                      // margin: const EdgeInsets.only(top: 10,bottom: 0),
                      // padding: const EdgeInsets.all(1),
                      //height: 12,
                      //child: Icon(MdiIcons.emoticonPoop,color: Colors.blueGrey.withOpacity(0.5),),
                    );
                  }
              ),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // rangeStartDay: _rangeStart,
              // rangeEndDay: _rangeEnd,
              formatAnimationCurve: Curves.elasticInOut,
              formatAnimationDuration: const Duration(milliseconds: 500),
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onHeaderTapped: (_){
                //print(_);
              },
              locale: 'vi',
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      color: Colors.red
                  ),
                  weekdayStyle: TextStyle(
                    color: Colors.black,
                  )
              ),
              headerVisible: false,
              // headerStyle: HeaderStyle(
              //   leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
              //   rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black),
              //   titleTextStyle: GoogleFonts.montserrat(
              //       color: Colors.yellow,
              //       fontSize: 16),
              //   titleCentered: true,
              //   formatButtonDecoration: BoxDecoration(
              //     color: Colors.white60,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   formatButtonVisible: false,
              //   formatButtonTextStyle: GoogleFonts.montserrat(
              //       color: Colors.black,
              //       fontSize: 13,
              //       fontWeight: FontWeight.bold),
              // ),
              calendarStyle: CalendarStyle(
                // selectedTextStyle: TextStyle(
                //   backgroundColor: Colors.white,
                //   color: mainColor
                // ),
                  todayTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                  ),
                  weekendTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 16
                  ),
                  outsideTextStyle: const TextStyle(color: Colors.blueGrey),
                  withinRangeTextStyle: const TextStyle(color: Colors.grey),
                  defaultTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                  ),
                  canMarkersOverflow: true,
                  outsideDaysVisible: false,
                  holidayTextStyle: const TextStyle(
                      color: Colors.yellow
                  )
              ),
              onDaySelected: _onDaySelected,
              // onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            Row(
              children: [
                const SizedBox(width: 20,),
                avatarWidget(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      inputWidget(hintText: 'Số điện thoại',iconPrefix: MdiIcons.phoneDialOutline,iconSuffix: Icons.search_outlined, onTap: (){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCustomerPage(typeView: 0,))).then((value){
                              if(value != null){
                                itemReSearch = value;
                                setState(() {
                                  phoneController.text = itemReSearch.dienThoai.toString();
                                  fullNameController.text  = itemReSearch.tenKh.toString();
                                  addressController.text = itemReSearch.diaChi.toString();
                                  emailController.text = itemReSearch.email.toString().replaceAll('null', '');
                                  _provinceController.text = itemReSearch.nameProvince.toString().trim().replaceAll('null', '');
                                  idProvince = itemReSearch.idProvince.toString().trim();
                                  _districtController.text = itemReSearch.nameDistrict.toString().trim().replaceAll('null', '');
                                  idDistrict = itemReSearch.idDistrict.toString().trim();
                                  _communeController.text = itemReSearch.nameCommune.toString().trim().replaceAll('null', '');
                                  idCommune = itemReSearch.idCommune.toString().trim();
                                  if(itemReSearch.ngaySinh!=null){
                                    ngaySinh = itemReSearch.ngaySinh.toString();
                                    birthDayController.text = Utils.parseStringToDate(itemReSearch.ngaySinh.toString(), Const.DATE_SV_FORMAT_2,).toString();
                                  }
                                  sexController.text = itemReSearch.sex == 2 ? 'Nữ' : itemReSearch.sex == 1 ? 'Nam' : 'Khác';
                                  idSex = itemReSearch.sex!;
                                });
                              }
                            });
                          }
                          ,controller: phoneController,textInputAction: TextInputAction.done,focusNode: fullNameFocus,readOnly: createNewCustomer, onTapSuffix: () {  }),
                      inputWidget(readOnly: createNewCustomer,
                          hintText: 'Họ & tên',iconPrefix: MdiIcons.human,controller: fullNameController,focusNode: phoneFocus,textInputAction: TextInputAction.done,inputNumber: true, onTapSuffix: (){}),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )
              ],
            ),
            inputWidget(readOnly: true,hintText: 'Cơ sở',iconPrefix: MdiIcons.storefrontOutline,iconSuffix: Icons.arrow_drop_down_outlined,textInputAction: TextInputAction.done,isEnable: false,controller: storeController, onTapSuffix: (){},onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              showGenPopupStore(context,'Cơ sở','Store',Const.listInfoStore);
            }),
            inputWidget(readOnly: true,hintText: 'Phiếu',iconPrefix: MdiIcons.idCard,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,controller: phieuController, onTapSuffix: (){},onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              showGenPopup(context,'Loại phiếu','Phieu',_bloc.listPhieu);
            }),

            inputWidget(readOnly: true,hintText: 'Ngày sinh',controller: birthDayController,iconPrefix: MdiIcons.calendarAccountOutline,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,onTapSuffix: ()=> print('123'),onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              Utils.dateTimePickerCustom(context).then((date){
                if(date != null){
                  setState(() {
                    ngaySinh =   Utils.parseDateToString(date, Const.DATE_SV_FORMAT_2);
                    birthDayController.text =   Utils.parseDateToString(date, Const.DATE_SV_FORMAT_2);
                  });
                }
              });
            }),
            inputWidget(readOnly: true,hintText: 'Giới tính',controller: sexController,iconPrefix: MdiIcons.accountHeartOutline,iconSuffix: Icons.arrow_drop_down_outlined,textInputAction: TextInputAction.done,isEnable: false, onTapSuffix: (){},onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              showGenPopup(context,'Giới tính','Sex',_listSex);
            }),
            inputWidget(readOnly: true,hintText: 'Chọn tỉnh/thành',controller: _provinceController,
              textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
              onSubmitted: ()=>null,onTap: (){
                  FocusScope.of(context).unfocus();
                  pushNewScreen(context, screen: const SearchProvinceScreen(
                    idProvince: '',idDistrict: '',title:'Danh sách Tỉnh thành',typeGetList: 0,
                  ),withNavBar: false).then((value){
                    if(value[0] == 'Yeah'){
                      idProvince = value[1].toString().trim();
                      _provinceController.text = value[2].toString().trim();
                    }
                    setState(() {});
                  });
                }),
            inputWidget(readOnly: true,hintText: 'Chọn Quân/Huyện',controller: _districtController,
              textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
              onSubmitted: ()=>null,onTap: (){
                  FocusScope.of(context).unfocus();
                  if(idProvince.isNotEmpty){
                    pushNewScreen(context, screen: SearchProvinceScreen(
                      idProvince: idProvince,idDistrict: '',title:'Danh sách Quận huyện',typeGetList: 0,
                    ),withNavBar: false).then((value){
                      if(value[0] == 'Yeah'){
                        idDistrict = value[1].toString().trim();
                        _districtController.text = value[2].toString().trim();
                      }
                      setState(() {});
                    });
                  }else{
                    Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Vui lòng chọn Tỉnh/Thành trước');
                  }
                }),
            inputWidget(readOnly: true,hintText: 'Chọn Xã/Phường',controller: _communeController,
              textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
              onSubmitted: ()=>null,onTap: (){
                  FocusScope.of(context).unfocus();
                  if(idDistrict.isNotEmpty){
                    pushNewScreen(context, screen: SearchProvinceScreen(
                      idProvince: idProvince,idDistrict: idDistrict,title:'Danh sách Xã phường',typeGetList: 0,
                    ),withNavBar: false).then((value){
                      if(value[0] == 'Yeah'){
                        idCommune = value[1].toString().trim();
                        _communeController.text = value[2].toString().trim();
                      }
                      setState(() {});
                    });
                  }else{
                    Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Vui lòng chọn Quân/Huyện trước');
                  }
                }),
            inputWidget(readOnly: false,hintText: 'Địa chỉ',iconPrefix: MdiIcons.mapMarkerRadiusOutline,controller: addressController,focusNode: addressFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),

            inputWidget(readOnly: false,hintText: 'Email',iconPrefix: MdiIcons.emailEditOutline,controller: emailController,focusNode: emailFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
            inputWidget(readOnly: false,hintText: 'Ghi chú',iconPrefix: MdiIcons.clipboardAccountOutline,controller: notesController,focusNode: notesFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
            buildButtonSubmit(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Widget buildPageNew2(BuildContext context,MakeAppointmentState state,bool createNewCustomer){
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            TableCalendar<Event>(
              rowHeight: 70,
              daysOfWeekHeight: 20,
              // isMargin: 0,
              simpleSwipeConfig: const SimpleSwipeConfig(
                verticalThreshold: 0.2,
                swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
              ),
              calendarBuilders: CalendarBuilders(
                // todayBuilder: (context, date, _){
                //   return Padding(
                //     padding: const EdgeInsets.only(bottom: 11),
                //     child: Container(
                //       decoration: new BoxDecoration(
                //         color: mainColor.withOpacity(0.8),
                //         shape: BoxShape.circle,
                //       ),
                //       // margin: const EdgeInsets.all(4.0),
                //       width: 45,
                //       height: 45,
                //       child: Center(
                //         child: Text(
                //           '${date.day}',
                //           style: TextStyle(
                //             fontSize: 16.0,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
                // },
                  selectedBuilder: (context, date, _) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 11),
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(150)
                        ),
                        // margin: const EdgeInsets.all(4.0),
                        width: 45,
                        height: 45,
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  markerBuilder: (context,date, event){
                    return Container(
                      // margin: const EdgeInsets.only(top: 10,bottom: 0),
                      // padding: const EdgeInsets.all(1),
                      //height: 12,
                      //child: Icon(MdiIcons.emoticonPoop,color: Colors.blueGrey.withOpacity(0.5),),
                    );
                  }
              ),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // rangeStartDay: _rangeStart,
              // rangeEndDay: _rangeEnd,
              formatAnimationCurve: Curves.elasticInOut,
              formatAnimationDuration: const Duration(milliseconds: 500),
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onHeaderTapped: (_){
                //print(_);
              },
              locale: 'vi',
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      color: Colors.red
                  ),
                  weekdayStyle: TextStyle(
                    color: Colors.black,
                  )
              ),
              headerVisible: false,
              calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                  ),
                  weekendTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 16
                  ),
                  outsideTextStyle: const TextStyle(color: Colors.blueGrey),
                  withinRangeTextStyle: const TextStyle(color: Colors.grey),
                  defaultTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                  ),
                  canMarkersOverflow: true,
                  outsideDaysVisible: false,
                  holidayTextStyle: const TextStyle(
                      color: Colors.yellow
                  )
              ),
              onDaySelected: _onDaySelected,
              // onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            Row(
              children: [
                const SizedBox(width: 20,),
                avatarWidget(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      inputWidget(hintText: 'Số điện thoại',iconPrefix: MdiIcons.phoneDialOutline,iconSuffix: Icons.edit, onTap: (){}
                          ,controller: phoneController2,textInputAction: TextInputAction.done,focusNode: fullNameFocus,readOnly: createNewCustomer, onTapSuffix: () {  }),
                      inputWidget(readOnly: createNewCustomer,
                          hintText: 'Họ & tên',iconPrefix: MdiIcons.accountEditOutline,controller: fullNameController2,focusNode: phoneFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )
              ],
            ),
            inputWidget(readOnly: true,hintText: 'Cơ sở',iconPrefix: MdiIcons.storefrontOutline,iconSuffix: Icons.arrow_drop_down_outlined,textInputAction: TextInputAction.done,isEnable: false,controller: storeController, onTapSuffix: (){},onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              showGenPopupStore(context,'Cơ sở','Store',Const.listInfoStore);
            }),
            inputWidget(readOnly: true,hintText: 'Phiếu',iconPrefix: MdiIcons.idCard,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,controller: phieuController, onTapSuffix: (){},onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              showGenPopup(context,'Loại phiếu','Phieu',_bloc.listPhieu);
            }),

            inputWidget(readOnly: true,hintText: 'Ngày sinh',controller: birthDayController2,iconPrefix: MdiIcons.calendarAccountOutline,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,onTapSuffix: ()=> print('123'),onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              Utils.dateTimePickerCustom(context).then((date){
                if(date != null){
                  setState(() {

                    ngaySinh =   Utils.parseDateToString(date, Const.DATE_SV_FORMAT_2);
                    birthDayController2.text =   Utils.parseDateToString(date, Const.DATE_SV_FORMAT_2);
                  });
                }
              });
            }),
            inputWidget(readOnly: true,hintText: 'Giới tính',controller: sexController2,iconPrefix: MdiIcons.accountHeartOutline,iconSuffix: Icons.arrow_drop_down_outlined,textInputAction: TextInputAction.done,isEnable: false, onTapSuffix: (){},onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              showGenPopup(context,'Giới tính','Sex',_listSex);
            }),
            inputWidget(readOnly: true,hintText: 'Chọn tỉnh/thành',controller: _provinceController2,
                textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
                onSubmitted: ()=>null,onTap: (){
                  FocusScope.of(context).unfocus();
                  pushNewScreen(context, screen: const SearchProvinceScreen(
                    idProvince: '',idDistrict: '',title:'Danh sách Tỉnh thành',typeGetList: 0,
                  ),withNavBar: false).then((value){
                    if(value[0] == 'Yeah'){
                      idProvince2 = value[1].toString().trim();
                      _provinceController2.text = value[2].toString().trim();
                    }
                    setState(() {});
                  });
                }),
            inputWidget(readOnly: true,hintText: 'Chọn Quân/Huyện',controller: _districtController2,
                textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
                onSubmitted: ()=>null,onTap: (){
                  FocusScope.of(context).unfocus();
                  if(idProvince2.isNotEmpty){
                    pushNewScreen(context, screen: SearchProvinceScreen(
                      idProvince: idProvince2,idDistrict: '',title:'Danh sách Quận huyện',typeGetList: 0,
                    ),withNavBar: false).then((value){
                      if(value[0] == 'Yeah'){
                        idDistrict2 = value[1].toString().trim();
                        _districtController2.text = value[2].toString().trim();
                      }
                      setState(() {});
                    });
                  }else{
                    Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Vui lòng chọn Tỉnh/Thành trước');
                  }
                }),
            inputWidget(readOnly: true,hintText: 'Chọn Xã/Phường',controller: _communeController2,
                textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
                onSubmitted: ()=>null,onTap: (){
                  FocusScope.of(context).unfocus();
                  if(idDistrict2.isNotEmpty){
                    pushNewScreen(context, screen: SearchProvinceScreen(
                      idProvince: idProvince2,idDistrict: idDistrict2,title:'Danh sách Xã phường',typeGetList: 0,
                    ),withNavBar: false).then((value){
                      if(value[0] == 'Yeah'){
                        idCommune2 = value[1].toString().trim();
                        _communeController2.text = value[2].toString().trim();
                      }
                      setState(() {});
                    });
                  }else{
                    Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Vui lòng chọn Quân/Huyện trước');
                  }
                }),
            inputWidget(readOnly: false,hintText: 'Địa chỉ',iconPrefix: MdiIcons.mapMarkerRadiusOutline,controller: addressController2,focusNode: addressFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
            inputWidget(readOnly: false,hintText: 'Email',iconPrefix: MdiIcons.emailEditOutline,controller: emailController2,focusNode: emailFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
            inputWidget(readOnly: false,hintText: 'Ghi chú',iconPrefix: MdiIcons.clipboardAccountOutline,controller: notesController2,focusNode: notesFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
            buildButtonSubmit2(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Widget inputWidget({String? hintText,IconData? iconPrefix,IconData? iconSuffix, bool? isEnable,
    required TextEditingController controller,required Callback onTapSuffix, Function? onSubmitted,FocusNode? focusNode,
    required TextInputAction textInputAction,bool inputNumber = false,bool readOnly = false,VoidCallback? onTap,}){
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 16,right: 16),
      child: TextField(
        autofocus: false,
        enableInteractiveSelection: readOnly ? true : null,
        onTap: readOnly ? onTap : null,
        readOnly: readOnly,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(color: Color(0xFF3B3935), fontSize: 13),
        controller: controller,
        keyboardType: inputNumber == true ?  TextInputType.number : TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(
                  color: Colors.grey,width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(width: 1,color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(
                color: Colors.grey,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(
                color: Colors.grey, ),
            ),
            filled: true,
            fillColor: transparent,
            hintText: hintText.toString(),
            hintStyle: const TextStyle(color: accent),
            // suffixIcon: Icon(EneftyIcons.edit_outline,size: 15,color: Colors.grey),
            // suffixIconConstraints: BoxConstraints(maxWidth: 20),
            prefixIcon: iconPrefix == null
                ? null
                : Icon(iconPrefix,size: 18,),
            suffixIcon: iconSuffix == null
                ? null
                : Icon(iconSuffix,size: 18,),
            contentPadding: const EdgeInsets.only(left: 15,bottom: 10, top: 0,right: 5)
        ),
       // onChanged: (text)=>onchange(text),
      ),
    );
  }

  void showGenPopup(BuildContext context,String title, String keys,List<String> listName){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return StatefulBuilder(
            builder: (BuildContext context,StateSetter myState){
              return Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child:  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsets.only(left: 16,right: 16,top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(24))
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    GestureDetector(
                                      onTap: ()=>Navigator.pop(context),
                                      child: const SizedBox(
                                          height: 30,
                                          width: 40,
                                          child: Icon(Icons.clear,color: Colors.black,)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                separatorBuilder: (BuildContext context, int index)=>const Padding(
                                  padding: EdgeInsets.only(left: 16,right: 16,),
                                  child: Divider(),
                                ),

                                itemBuilder: (BuildContext context, int index){
                                  return InkWell(
                                    onTap: ()=> Navigator.pop(context,[index,listName[index].toString()]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0,right: 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(listName[index].toString(),style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: listName.length
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          );
        }
    ).then((value){
      if(!Utils.isEmpty(value)){
        if(keys =='Phieu'){
          setState(() {
            phieuController.text = value[1];
            if(value[1] == 'Phiếu khám'){
              dataType = 7;
            }else if(value[1] == 'Phiếu mua hàng'){
              dataType = 4;
            }else if(value[1] == 'Phiếu sửa chữa'){
              dataType = 8;
            }
          });
        }
        else if(keys =='Store'){
          setState(() {
            storeController.text = value[1];
            idStore = value[2];
          });
        }
        else if(keys =='Sex'){
          setState(() {
            sexController.text = value[1];
            sexController2.text = value[1];
            idSex =_listSex.indexOf(value[1]) + 1;
          });
        }
      }
    });
  }

  void showGenPopupStore(BuildContext context,String title, String keys,List<InfoStoreResponseData> listStore){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return StatefulBuilder(
            builder: (BuildContext context,StateSetter myState){
              return Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child:  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsets.only(left: 16,right: 16,top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(24))
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    GestureDetector(
                                      onTap: ()=>Navigator.pop(context),
                                      child: const SizedBox(
                                          height: 30,
                                          width: 40,
                                          child: Icon(Icons.clear,color: Colors.black,)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                separatorBuilder: (BuildContext context, int index)=>Padding(
                                  padding: const EdgeInsets.only(left: 16,right: 16,),
                                  child: Divider(),
                                ),

                                itemBuilder: (BuildContext context, int index){
                                  return InkWell(
                                    onTap: ()=> Navigator.pop(context,[index,listStore[index].storeName.toString(),listStore[index].storeId.toString()]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0,right: 10),
                                      child: Container(
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(listStore[index].storeName?.toString()??'',style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                            Text(listStore[index].storeId?.toString()??'',style: TextStyle(color: blue.withOpacity(0.5)),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: listStore.length
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          );
        }
    ).then((value){
      if(value != null){
        setState(() {
          storeController.text = value[1];
          idStore = value[2];
        });
      }
    });
  }

  Widget avatarWidget() {
    return GestureDetector(
        onTap: () => _showDialog(context),
        child: Stack(
          children: <Widget>[
            Container(
              height: 120.0,
              width: 120.0,
              child: _bloc.file.toString().isEmpty ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.blueGrey)
                ),
                child: Center(child: Text('Add Image',style: TextStyle(color: Colors.blueGrey),),),
              ) :  Container(
                height: 110,width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.blueGrey),
                    image: DecorationImage(
                        image: FileImage(_bloc.file),
                        fit: BoxFit.cover)
                ),
              )
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: blue,
                child: Icon(
                  MdiIcons.cameraOutline,
                  color: white,
                  size: 20,
                ),
              ),
            )
          ],
        ));
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
                  ElevatedButton(
                    child: Text("Thư viện"),
                    onPressed: () {
                      _bloc.add(UploadAvatarEvent(false));
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
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

  Widget buildButtonSubmit(){
    return  Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 30,bottom: 30),
      child: GestureDetector(
        onTap: (){
         if(!Utils.isEmpty(fullNameController.text) ){
           _bloc.add(CreatesMakeAppointmentEvent(
               phoneController.text,
               fullNameController.text,
               ngaySinh,
               idSex,
               Utils.parseDateToString(_selectedDay??_focusedDay, Const.DATE_SV_FORMAT_2),
               idStore,
               addressController.text,
               emailController.text,
               notesController.text,
               dataType.toString(),
               isFree,
              idProvince: idProvince,
             idDistrict: idDistrict,
             idCommune: idCommune,
             maKH: itemReSearch.maKh.toString().trim(),
             createNewCustomer: 0
           ));
         }else{
           Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng nhập đầy đủ thông tin trên phiếu');
         }
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 45.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: mainColor
            ),
            child: Center(
              child: Text(
                'Đặt lịch',
                style: TextStyle(fontSize: 16, color: white,),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildButtonSubmit2(){
    return  Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 30,bottom: 30),
      child: GestureDetector(
        onTap: (){
         if(!Utils.isEmpty(fullNameController2.text) ){
           _bloc.add(CreatesMakeAppointmentEvent(
               phoneController2.text,
               fullNameController2.text,
               birthDayController2.text,
               idSex,
               Utils.parseDateToString(_selectedDay??_focusedDay, Const.DATE_SV_FORMAT_2),
               idStore,
               addressController2.text,
               emailController2.text,
               notesController2.text,
               dataType.toString(),
               isFree,
              idProvince: idProvince2,
             idDistrict: idDistrict2,
             idCommune: idCommune2,
             maKH: '',
             createNewCustomer: 1
           ));
         }else{
           Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng nhập đầy đủ thông tin trên phiếu');
         }
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 45.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: mainColor
            ),
            child: Center(
              child: Text(
                'Đặt lịch',
                style: TextStyle(fontSize: 16, color: white,),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
