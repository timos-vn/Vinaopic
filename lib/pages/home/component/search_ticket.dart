
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vinaoptic/pages/home/home_bloc.dart';
import 'package:vinaoptic/pages/home/home_event.dart';
import 'package:vinaoptic/pages/home/home_sate.dart';

import '../../../core/untils/const.dart';
import '../../../core/untils/debouncer.dart';
import '../../../core/untils/utils.dart';
import '../../../core/values/colors.dart';
import '../../../widget/custom_dropdown.dart';
import '../../../widget/pending_action.dart';
import '../../detail_appointment/detail_appointment_page.dart';
import '../../options_input/options_input_screen.dart';


class SearchTicketScreen extends StatefulWidget {
  const SearchTicketScreen({Key? key}) : super(key: key);

  @override
  _SearchTicketScreenState createState() => _SearchTicketScreenState();
}

class _SearchTicketScreenState extends State<SearchTicketScreen> {

  late HomeBloc _bloc;

  final focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final Debouncer onSearchDebounce =  Debouncer(delay:  const Duration(milliseconds: 1000));
  String dateFrom = Utils.parseDateToString(DateTime.now(), Const.DATE_SV_FORMAT_2);
  String dateTo = Utils.parseDateToString(DateTime.now(), Const.DATE_SV_FORMAT_2);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = HomeBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc,HomeState>(
        bloc: _bloc,
        listener: (context,state){

        },
        child: BlocBuilder<HomeBloc,HomeState>(
          bloc: _bloc,
          builder: (BuildContext context, HomeState state){
            return Stack(
              children: [
                buildBody(context,state),
                Visibility(
                  visible: _bloc.listTicket.isEmpty,
                  child: const Center(
                    child: Text('Dữ liệu trống',style: TextStyle(color: Colors.blueGrey,fontSize: 11),),
                  ),
                ),
                Visibility(
                  visible: state is HomeLoading,
                  child: const PendingAction(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  int selectedPage=1;
  String status = '0';

  Widget buildBody(BuildContext context, HomeState state){
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          buildAppBar(),
          Expanded(
            child: SizedBox(
              height: double.infinity,width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      const SizedBox(width: 4,),
                      Text('Danh sách từ $dateFrom - $dateTo' ,style: const TextStyle(color:Colors.blueGrey,fontSize: 12),),
                      const SizedBox(width: 4,),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 0,top: 10),
                      color: Colors.grey.withOpacity(.1),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return
                          GestureDetector(
                            onTap: () {
                              pushNewScreen(context, screen: DetailAppointmentPage(sttRec: _bloc.listTicket[index].sttRec.toString(),));
                            },
                            child: Card(
                              color: Colors.white.withOpacity(0.9),
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(8))
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(8),
                                                        topLeft: Radius.circular(8),
                                                      )
                                                  ),
                                                  child: Center(child: Text(
                                                    DateFormat('EEEE').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).toString() == 'Monday' ? "Thứ 2"
                                                        :
                                                    DateFormat('EEEE').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).toString() == 'Tuesday' ? "Thứ 3"
                                                        :
                                                    DateFormat('EEEE').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).toString() == 'Wednesday' ? "Thứ 4"
                                                        :
                                                    DateFormat('EEEE').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).toString() == 'Thursday' ? "Thứ 5"
                                                        :
                                                    DateFormat('EEEE').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).toString() == 'Friday' ? "Thứ 6"
                                                        :
                                                    DateFormat('EEEE').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).toString() == 'Saturday' ? "Thứ 7"
                                                        :
                                                    "Chủ nhật"
                                                    ,
                                                    style: TextStyle(color: Colors.white),))),
                                              SizedBox(height: 10,),
                                              Text( DateFormat('yyyy-MM-dd').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).split('-')[2].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                              SizedBox(height: 10,),
                                              Text('Tháng ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_bloc.listTicket[index].ngayCt.toString())).split('-')[1].toString()}',style: TextStyle(color: Colors.grey)),
                                              SizedBox(height: 10,),
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(_bloc.listTicket[index].tenKh??''),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('SĐT:'),
                                                  SizedBox(width: 4,),
                                                  Text(_bloc.listTicket[index].dienThoai??'',style: TextStyle(color: Colors.grey,fontSize: 13),),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('Bác sĩ:'),
                                                  SizedBox(width: 4,),
                                                  Text(_bloc.listTicket[index].tenBs??'',style: TextStyle(color: mainColor),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => Container(),
                        itemCount: _bloc.listTicket.length,),
                    ),
                  ),
                  _bloc.totalPager > 1 ? _getDataPager() : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  int lastPage=0;

  Widget _getDataPager() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Center(
        child: SizedBox(
          height: 57,
          width: double.infinity,
          child: Column(
            children: [
              const Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              lastPage = selectedPage;
                              selectedPage = 1;
                            });
                            _bloc.add(GetTicketEvent(dateFrom:dateFrom.toString(),dateTo: dateTo,pageIndex: selectedPage, keySearch: _searchController.text,status: status.toString() ));
                          },
                          child: const Icon(Icons.skip_previous_outlined,color: Colors.grey)),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            if(selectedPage > 1){
                              setState(() {
                                lastPage = selectedPage;
                                selectedPage = selectedPage - 1;
                              });
                              _bloc.add(GetTicketEvent(dateFrom:dateFrom.toString(),dateTo: dateTo,pageIndex: selectedPage, keySearch: _searchController.text,status: status.toString() ));
                            }
                          },
                          child: const Icon(Icons.navigate_before_outlined,color: Colors.grey,)),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index){
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    lastPage = selectedPage;
                                    selectedPage = index+1;
                                  });
                                  _bloc.add(GetTicketEvent(dateFrom:dateFrom.toString(),dateTo: dateTo,pageIndex: selectedPage, keySearch: _searchController.text,status: status.toString() ));
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: selectedPage == (index + 1) ?  mainColor : Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(48))
                                  ),
                                  child: Center(
                                    child: Text((index + 1).toString(),style: TextStyle(color: selectedPage == (index + 1) ?  Colors.white : Colors.black),),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:(BuildContext context, int index)=> Container(width: 6,),
                            itemCount: _bloc.totalPager > 10 ? 10 : _bloc.totalPager),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            if(selectedPage < _bloc.totalPager){
                              setState(() {
                                lastPage = selectedPage;
                                selectedPage = selectedPage + 1;
                              });
                              _bloc.add(GetTicketEvent(dateFrom:dateFrom.toString(),dateTo: dateTo,pageIndex: selectedPage, keySearch: _searchController.text,status: status.toString() ));
                            }
                          },
                          child: const Icon(Icons.navigate_next_outlined,color: Colors.grey)),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            setState(() {
                              lastPage = selectedPage;
                              selectedPage = _bloc.totalPager;
                            });
                            _bloc.add(GetTicketEvent(dateFrom:dateFrom.toString(),dateTo: dateTo,pageIndex: selectedPage, keySearch: _searchController.text,status: status.toString() ));
                          },
                          child: const Icon(Icons.skip_next_outlined,color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> listStatus = ['Lịch hẹn','Khám', 'Tư vấn', 'Sửa chữa', 'Hoàn thành','Huỷ'];
  String nameStatus = 'Lịch hẹn';

  buildAppBar(){
    return Container(
      height: 83,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient:  LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mainColor,Color.fromARGB(255, 150, 185, 229)])),
      padding: const EdgeInsets.fromLTRB(5, 35, 5,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context,['Back']);
            },
            child: Container(
              width: 40,
              height: 50,
              padding: const EdgeInsets.only(bottom: 10),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: TextField(
                          autofocus: true,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                          focusNode: focusNode,
                          onSubmitted: (text) {
                            //_bloc.add(GetListTourEvent(idTour:_searchController.text));
                          },
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (text) => onSearchDebounce.debounce(
                                () {
                              if(text.isNotEmpty){
                                _bloc.add(GetTicketEvent(dateFrom:dateFrom.toString(),dateTo: dateTo,pageIndex: selectedPage, keySearch: _searchController.text,status: status.toString() ));
                              }
                            },
                          ),
                          decoration:const InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: transparent,
                              hintText:
                              "Tìm kiếm thông tin phiếu của KH ...",
                              hintStyle: TextStyle(color: Colors.white),
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 14)
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _bloc.isShowCancelButton,
                      child: InkWell(
                          child: const Icon(
                            MdiIcons.close,
                            color: Colors.white,
                            size: 28,
                          ),
                          onTap: () {
                            _searchController.text = "";
                            _bloc.add(CheckShowCloseEvent(""));
                          }),
                    )
                  ],
                ),
              )
          ),
          InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
                  ),
                  backgroundColor: Colors.white,
                  builder: (builder){
                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)
                          )
                      ),
                      margin: MediaQuery.of(context).viewInsets,
                      child: FractionallySizedBox(
                        heightFactor: 0.35,
                        child: StatefulBuilder(
                          builder: (BuildContext context,StateSetter myState){
                            return Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25)
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0,left: 16,right: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(Icons.check,color: Colors.white,),
                                          const Text('Tuỳ chọn',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                                          InkWell(
                                              onTap: ()=> Navigator.pop(context),
                                              child: const Icon(Icons.close,color: Colors.black,)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    const Divider(color: Colors.blueGrey,),
                                    const SizedBox(height: 5,),
                                    Expanded(
                                      child: ListView(
                                        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 0),
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Flexible(child: Text('Khách hàng:',style: TextStyle(color: Colors.black),)),
                                                Expanded(
                                                  child: PopupMenuButton(
                                                    shape: const TooltipShape(),
                                                    padding: EdgeInsets.zero,
                                                    offset: const Offset(0, 40),
                                                    itemBuilder: (BuildContext context) {
                                                      return <PopupMenuEntry<Widget>>[
                                                        PopupMenuItem<Widget>(
                                                          child: Container(
                                                            decoration: ShapeDecoration(
                                                                color: Colors.white,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10))),
                                                            height: 250,
                                                            width: 320,
                                                            child: Scrollbar(
                                                              child: ListView.builder(
                                                                padding: const EdgeInsets.only(top: 10,),
                                                                itemCount: listStatus.length,
                                                                itemBuilder: (context, index) {
                                                                  final trans = listStatus[index].toString().trim();
                                                                  return ListTile(
                                                                    minVerticalPadding: 1,
                                                                    title: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Text(
                                                                            trans.toString(),
                                                                            style: const TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                            maxLines: 1,overflow: TextOverflow.fade,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          index.toString().trim(),
                                                                          style: const TextStyle(
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    subtitle:const Divider(height: 1,),
                                                                    onTap: () {
                                                                      nameStatus = listStatus[index].toString().trim();
                                                                      status = index.toString().trim();
                                                                      myState(() {});
                                                                      Navigator.pop(context);
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ];
                                                    },
                                                    child: SizedBox(
                                                      height: 35,width: double.infinity,
                                                      child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(nameStatus.toString(),style: const TextStyle(color: Colors.blueGrey,fontSize: 12.5)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8,bottom: 12),
                                            child: Divider(),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Flexible(child: Text('Thời gian:',style: TextStyle(color: Colors.black),)),
                                                InkWell(
                                                    onTap: (){
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => OptionsFilterDate(dateFrom: dateFrom.toString(),dateTo: dateTo.toString(),)).then((value){
                                                        if(value != null){
                                                          if(value[1] != null && value[2] != null){
                                                            dateFrom = value[3];
                                                            dateTo = value[4];
                                                          }else{
                                                            Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Úi, Hãy chọn từ ngày đến ngày');
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: Center(child: Text('Từ $dateFrom đến $dateTo',style: const TextStyle(color: Colors.blueGrey,fontSize: 12))))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 12),
                                      child: GestureDetector(
                                        onTap: (){
                                          if(_bloc.listTicket.isNotEmpty){
                                            _bloc.listTicket.clear();
                                          }
                                          _bloc.add(GetTicketEvent(

                                              dateFrom:dateFrom.toString(),
                                              dateTo: dateTo,
                                              pageIndex: selectedPage,
                                              keySearch: _searchController.text,
                                              status: status.toString()
                                          ));
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 45, width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: mainColor
                                          ),
                                          child: const Center(
                                            child: Text('Áp dụng', style: TextStyle(color: Colors.white,fontSize: 12.5),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
              ).then((value){

              });
            },
            child: Container(
              width: 40,
              height: 50,
              padding: const EdgeInsets.only(bottom: 10),
              child: const Icon(
                Icons.filter_list,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}