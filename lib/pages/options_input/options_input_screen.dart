import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/values/colors.dart';
import '../../core/untils/const.dart';
import '../../core/untils/utils.dart';
import 'options_input_bloc.dart';
import 'options_input_event.dart';
import 'options_input_state.dart';


class OptionsFilterDate extends StatefulWidget {


  final String? dateFrom;
  final String? dateTo;

  const OptionsFilterDate({Key? key, this.dateFrom, this.dateTo}) : super(key: key);
  @override
  _OptionsFilterDateState createState() => _OptionsFilterDateState();
}

class _OptionsFilterDateState extends State<OptionsFilterDate> {

  late OptionsInputBloc _bloc;
  String statusTypeName = 'Chờ duyệt';
  int statusType = 0;
  String toDate ="";
  String fromDate="";


  String dateFrom = DateTime.now().toString();
  String dateTo = DateTime.now().toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OptionsInputBloc(context);

    if(widget.dateFrom != null){
      dateFrom = widget.dateFrom!;
    }
    if(widget.dateTo != null){
      dateTo = widget.dateTo!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: BlocListener<OptionsInputBloc,OptionsInputState>(
          bloc: _bloc,
            listener: (context, state){
              if (state is WrongDate) {
                Utils.showCustomToast(context, Icons.warning_amber_outlined, '\'Từ ngày\' phải là ngày trước \'Đến ngày\'');
              }else if(state is PickDateSuccess){
                print('-----');
                print(_bloc.dateFrom);
                print(_bloc.dateTo);
                print('-----');
              }
            },
            child: BlocBuilder<OptionsInputBloc,OptionsInputState>(
              bloc: _bloc,
              builder: (BuildContext context, OptionsInputState state){
                return buildPage(context,state);
              },
            )
        )
    );
  }

  Widget buildPage(BuildContext context,OptionsInputState state){
    return Padding(
      padding: const EdgeInsets.only(top: 35,bottom: 35),
      child: AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(children: const [
                Text('Bộ lọc',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
            ],),
            ///FromDate
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Từ ngày',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    initialValue: dateFrom.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    decoration: InputDecoration(
                      suffixIcon:  Icon(Icons.event,color: mainColor,size: 22,),
                      contentPadding: const EdgeInsets.only(left: 12),
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey, width: 1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: grey, width: 1),
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                    locale: const Locale("vi", "VN"),
                    // icon: Icon(Icons.event),
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      // if (date.weekday == 6 || date.weekday == 7) {
                      //   return false;
                      // }

                      return true;
                    },
                    onChanged: (val) => _bloc.add(DateFrom(Utils.parseStringToDate(val.toString(), Const.DATE_SV_FORMAT_2))),
                    validator: (result) {
                     // _bloc.add(DateFrom(Utils.parseStringToDate(result.toString(), Const.DATE_SV_FORMAT_2)));
                      return null;
                    },
                    onSaved: (val) => print(val),
                  )
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ///ToDate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Tới ngày",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    initialValue: dateTo.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    decoration: InputDecoration(
                      suffixIcon:  Icon(Icons.event,color: mainColor,size: 22,),
                      contentPadding: const EdgeInsets.only(left: 12),
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: grey, width: 1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: grey, width: 1),
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                    locale: const Locale("vi", "VN"),
                    // icon: Icon(Icons.event),
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      // if (date.weekday == 6 || date.weekday == 7) {
                      //   return false;
                      // }

                      return true;
                    },
                    onChanged: (val) => _bloc.add(DateTo(Utils.parseStringToDate(val.toString(), Const.DATE_SV_FORMAT_2))),
                    validator: (result) {
                      //_bloc.add(DateTo(Utils.parseStringToDate(result.toString(), Const.DATE_SV_FORMAT_2)));
                      return null;
                    },
                    onSaved: (val) => print(val),
                  )
                ),
              ],
            ),

            const SizedBox(height: 25,),
            ///Button
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 90.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0), color: grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Huỷ',
                            style: TextStyle(
                              fontSize: 12,
                              color: white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context,[statusType,_bloc.statusCode,'',_bloc.getStringFromDateYMD(_bloc.dateFrom),_bloc.getStringFromDateYMD(_bloc.dateTo),statusTypeName]);
                    },
                    child: Container(
                      width: 90.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0), color: orange),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Chọn',
                            style: TextStyle(
                              fontSize: 12,
                              color: white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  List<String> typeStatus = ['Chờ duyệt','Đã duyệt'];

  Widget genderType() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          icon: const Icon(
            MdiIcons.sortVariant,
            size: 15,
            color: black,
          ),
          isDense: true,
          isExpanded: true,
          style: const TextStyle(
            color: black,
            fontSize: 12.0,
          ),
          value: statusTypeName,
          items: typeStatus.map((value) => DropdownMenuItem<String>(
            value: value,
            child: Align(
                alignment: Alignment.center,
                child: Text(value.toString(), style: TextStyle(fontSize: 13.0, color: blue.withOpacity(0.6)),)),
          )).toList(),
          onChanged: (value) {
            setState(() {
              statusTypeName = value!;
            });
            if(value == 'Chờ duyệt'){
              statusType = 1;
            }else if(value == 'Đã duyệt'){
              statusType = 2;
            }
          }),
    );
  }
}
