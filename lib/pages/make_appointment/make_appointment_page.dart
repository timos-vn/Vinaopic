import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/lang/localization_service.dart';
import 'package:vinaoptic/models/network/response/info_store_response.dart';
import 'package:vinaoptic/models/network/response/search_customer_response.dart';
import 'package:vinaoptic/pages/make_appointment/search_province/search_province_screen.dart';
import 'package:vinaoptic/widget/custom_bottom_sheet.dart';
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

class _MakeAppointmentPageState extends State<MakeAppointmentPage> {

  List<String> _listSex = [
    'Nam',
    'Nữ',
    'Khác'
  ];

  bool isFree = false;
  int idSex = 0;
  final addressController = TextEditingController();
  final FocusNode addressFocus = FocusNode();

  final fullNameController = TextEditingController();
  final FocusNode fullNameFocus = FocusNode();

  final notesController = TextEditingController();
  final FocusNode notesFocus = FocusNode();

  final emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  final phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  final storeController = TextEditingController();
  final phieuController = TextEditingController();
  final birthDayController = TextEditingController();
  String ngaySinh = '';
  final sexController = TextEditingController();

  // InfoStoreResponseData? item;
  SearchCustomerResponseData itemReSearch = SearchCustomerResponseData();
  late MakeAppointmentBloc _bloc;
  // String _dateOrder = Jiffy(DateTime.now()).format('yyyy-MM-dd');
  String idStore = '';
  int dataType = 7;

  final _provinceController = TextEditingController();
  String idProvince = '';

  final _districtController = TextEditingController();
  String idDistrict = '';

  final _communeController = TextEditingController();
  String idCommune = '';

  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        }else if(state is MakeAppointmentFailure) {
         Utils.showCustomToast(context,Icons.warning_amber_outlined,state.error);
       }
      },
      child: BlocBuilder<MakeAppointmentBloc,MakeAppointmentState>(
        bloc: _bloc,
        builder: (BuildContext context,MakeAppointmentState state){
          return buildPageNew(context, state);
        },
      ),
    );
  }

  Widget buildPageNew(BuildContext context,MakeAppointmentState state){
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
          SingleChildScrollView(
            child: GestureDetector(
              onTap: ()=>FocusScope.of(context).unfocus(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Calendar(
                  //   startOnMonday: true,
                  //   weekDays: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
                  //   events: Utils.events,
                  //   isExpandable: false,
                  //   eventDoneColor: Colors.green,
                  //   selectedColor: Colors.pink,
                  //   hideBottomBar: true,
                  //   todayColor: Colors.blue,onDateSelected: (DateTime date){
                  //     _dateOrder = Jiffy(date).format('yyyy-MM-dd');
                  //     print(_dateOrder);
                  // },
                  //   eventListBuilder: (BuildContext context, List<NeatCleanCalendarEvent> _selectesdEvents) {
                  //     return new Container();
                  //   },
                  //   eventColor: Colors.grey,
                  //   locale: 'vi_VN',
                  //   todayButtonText: 'Heute',hideTodayIcon: true,
                  //   expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                  //   dayOfWeekStyle: TextStyle(
                  //       color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
                  // ),
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
                  Center(child: avatarWidget()),
                  GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showGenPopupStore(context,'Cơ sở','Store',Const.listInfoStore);
                      },
                      child: inputWidget(hideText: 'Cơ sở',iconPrefix: MdiIcons.storefrontOutline,iconSuffix: Icons.arrow_drop_down_outlined,textInputAction: TextInputAction.done,isEnable: false,controller: storeController, onTapSuffix: (){})),
                  GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showGenPopup(context,'Loại phiếu','Phieu',_bloc.listPhieu);
                      },
                      child: inputWidget(hideText: 'Phiếu',iconPrefix: MdiIcons.idCard,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,controller: phieuController, onTapSuffix: (){})),
                  inputWidget(hideText: 'Họ & tên',iconPrefix: MdiIcons.accountSupervisorCircleOutline,iconSuffix: Icons.search_outlined,
                      onTapSuffix: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCustomerPage(typeView: 0,))).then((value){
                          if(value != null){
                            itemReSearch = value;
                            setState(() {
                              phoneController.text = itemReSearch.dienThoai.toString();
                              fullNameController.text  = itemReSearch.tenKh.toString();
                              addressController.text = itemReSearch.diaChi.toString();
                              emailController.text = itemReSearch.email.toString();
                              if(itemReSearch.ngaySinh!=null){
                                ngaySinh = itemReSearch.ngaySinh.toString();
                                birthDayController.text = Jiffy(itemReSearch.ngaySinh).format('dd-MM-yyyy');
                              }
                              sexController.text = itemReSearch.sex == 2 ? 'Nữ' : itemReSearch.sex == 1 ? 'Nam' : 'Khác';
                              idSex = itemReSearch.sex!;
                            });
                          }
                        });
                  }
                  ,controller: fullNameController,textInputAction: TextInputAction.done,focusNode: fullNameFocus),
                  GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now().add(Duration(days: -29200)),
                            maxTime: DateTime.now(), onChanged: (date) {
                            }, onConfirm: (date) {
                              setState(() {
                                ngaySinh = Jiffy(date).format('yyyy-MM-dd');
                                birthDayController.text = Jiffy(date).format('dd-MM-yyyy');
                              });//undefine
                            }, currentTime: DateTime(1995,3,4), locale: LocaleType.vi);
                      },
                      child: inputWidget(hideText: 'Ngày sinh',controller: birthDayController,iconPrefix: MdiIcons.calendarAccountOutline,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,onTapSuffix: ()=> print('123'))),
                  GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showGenPopup(context,'Giới tính','Sex',_listSex);
                      },
                      child: inputWidget(hideText: 'Giới tính',controller: sexController,iconPrefix: MdiIcons.accountHeartOutline,iconSuffix: Icons.arrow_drop_down_outlined,textInputAction: TextInputAction.done,isEnable: false, onTapSuffix: (){},)),
                  InkWell(
                      onTap: (){
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
                      },
                      child: inputWidget(hideText: 'Chọn tỉnh/thành',controller: _provinceController,
                        textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
                        onSubmitted: ()=>null,)
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: (){
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
                            },
                            child: inputWidget(hideText: 'Chọn Quân/Huyện',controller: _districtController,
                              textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
                              onSubmitted: ()=>null,)
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: (){
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
                            },
                            child: inputWidget(hideText: 'Chọn Xã/Phường',controller: _communeController,
                              textInputAction: TextInputAction.done, onTapSuffix: (){},isEnable: false,iconPrefix: Icons.search_outlined,
                              onSubmitted: ()=>null,)
                        ),
                      ),
                    ],
                  ),
                  inputWidget(hideText: 'Địa chỉ',iconPrefix: MdiIcons.mapMarkerRadiusOutline,controller: addressController,focusNode: addressFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
                  inputWidget(hideText: '0963004959',iconPrefix: MdiIcons.phoneAlertOutline,controller: phoneController,focusNode: phoneFocus,textInputAction: TextInputAction.done,inputNumber: true, onTapSuffix: (){}),
                  inputWidget(hideText: 'Email',iconPrefix: MdiIcons.emailEditOutline,controller: emailController,focusNode: emailFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
                  inputWidget(hideText: 'Ghi chú',iconPrefix: MdiIcons.clipboardAccountOutline,controller: notesController,focusNode: notesFocus,textInputAction: TextInputAction.done, onTapSuffix: (){}),
                  buildButtonSubmit(),
                  SizedBox(height: 80,),
                ],
              ),
            ),
          ),
          Visibility(
            visible: state is MakeAppointmentLoading,
            child: PendingAction(),
          ),
        ],
      ),
    );
  }

  Widget inputWidget2({String? title,String? hideText,IconData? iconPrefix,IconData? iconSuffix, bool? isEnable,
    TextEditingController? controller,Function? onTapSuffix, Function? onSubmitted,FocusNode? focusNode,bool? isNull,Color? colors,bool? enableMaxLine,
    TextInputAction? textInputAction,bool inputNumber = false,bool isPhone = false,bool note = false,bool isPassWord = false, bool cod = true,int? maxLength, bool customContainer = false,}){
    return Padding(
      padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: customContainer == true ? 0 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title??'',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
              ),
              Visibility(
                visible: note == true,
                child: const Text(' *',style: TextStyle(color: Colors.red),),
              )
            ],
          ),
          const SizedBox(height: 5,),
          Container(
            height: customContainer == true ? 60 : 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12)
            ),
            child: TextFieldWidget2(
              controller: controller!,
              suffix: iconSuffix,
              textInputAction: textInputAction!,
              isEnable: isEnable ?? true,
              keyboardType: inputNumber == true ? TextInputType.phone : TextInputType.text,
              hintText: hideText,
              isNull: isNull,
              color: colors,
              enableMaxLine: enableMaxLine,
              focusNode: focusNode,
              onChanged: (string){},
              onSubmitted: (text)=> onSubmitted,
              isPassword: isPassWord,
              inputFormatter: customContainer == true ? [FilteringTextInputFormatter.digitsOnly]: [],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputWidget({String? hideText,IconData? iconPrefix,IconData? iconSuffix, bool? isEnable,
    required TextEditingController controller,required Callback onTapSuffix, Function? onSubmitted,FocusNode? focusNode,
    required TextInputAction textInputAction,bool inputNumber = false}){
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 16,right: 16),
      child: TextFieldWidgetInput(
        hintText: hideText,
        prefixIcon: iconPrefix,
        suffix: iconSuffix,
        isEnable: isEnable == null ? true : isEnable,
        controller: controller,
        onTapSuffix: onTapSuffix,
        onSubmitted:(text)=> onSubmitted,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType:inputNumber == true ? TextInputType.phone : TextInputType.text,
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
      if(!Utils.isEmpty(value)){
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
              child: _bloc.file == null ? Container(
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


  Widget buildButtonSubmit(){
    return  Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 30,bottom: 30),
      child: GestureDetector(
        onTap: (){
         if(!Utils.isEmpty(fullNameController.text) && !Utils.isEmpty(phoneController.text) && !Utils.isEmpty(birthDayController.text) && !Utils.isEmpty(addressController.text) ){
           _bloc.add(CreatesMakeAppointmentEvent(
               phoneController.text,
               fullNameController.text,
               ngaySinh,
               idSex,
               Jiffy(_selectedDay??_focusedDay).format('yyyy-MM-dd'),
               idStore,
               addressController.text,
               emailController.text,
               notesController.text,
               dataType.toString(),
               isFree,
              idProvince: idProvince,
             idDistrict: idDistrict,
             idCommune: idCommune
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
