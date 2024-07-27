
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import '../../core/untils/const.dart';
import 'options_input_bloc.dart';
import 'options_input_event.dart';
import 'options_input_state.dart';


class OptionsInputPage extends StatefulWidget {
  const OptionsInputPage({Key? key,}) : super(key: key);
  @override
  _OptionsInputPageState createState() => _OptionsInputPageState();
}

class _OptionsInputPageState extends State<OptionsInputPage> {

  late OptionsInputBloc _bloc;
  int status = 0;


  String fromDate = Utils.parseDateToString(DateTime.now().add(const Duration(days: -7)), Const.DATE_SV_FORMAT_2);
  String toDate = Utils.parseDateToString(DateTime.now(), Const.DATE_SV_FORMAT_2);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OptionsInputBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<OptionsInputBloc,OptionsInputState>(
            bloc: _bloc,
            listener: (context, state){
              if (state is WrongDate) {
                // Utils.showToast('from_date_before_to_date'.tr);
              }else if(state is PickDateSuccess){
                toDate = _bloc.getStringFromDate(_bloc.dateTo);
                fromDate = _bloc.getStringFromDate(_bloc.dateFrom);
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
            Container(
              padding:const EdgeInsets.only(left: 12,right: 2,top: 10,bottom: 10),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: grey.withOpacity(0.8),width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text('Từ ngày: ',style:  TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                        const SizedBox(width: 5,),
                        Text(Utils.parseStringDateToString(_bloc.dateFrom.toString(), Const.DATE_TIME_FORMAT,Const.DATE_FORMAT_1),style: const TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      child: InkWell(
                        onTap: (){
                          Utils.dateTimePickerCustom(context).then((value){
                            if(value != null){
                              setState(() {
                                _bloc.add(DateFrom(value));
                              });
                            }
                          });
                        },
                        child: const Icon(Icons.event,color: Colors.blueGrey,size: 22,),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            ///ToDate
            Container(
              padding:const EdgeInsets.only(left: 12,right: 2,top: 10,bottom: 10),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: grey.withOpacity(0.8),width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text('Tới ngày: ',style:  TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                        const SizedBox(width: 5,),
                        Text(Utils.parseStringDateToString(_bloc.dateTo.toString(), Const.DATE_TIME_FORMAT,Const.DATE_FORMAT_1),style: const TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      child: InkWell(
                        onTap: (){
                          Utils.dateTimePickerCustom(context).then((value){
                            if(value != null){
                              setState(() {
                                _bloc.add(DateTo(value));
                              });
                            }
                          });
                        },
                        child: const Icon(Icons.event,color: Colors.blueGrey,size: 22,),
                      ),
                    ),
                  ]),
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
                      Navigator.pop(context,[fromDate, toDate]);
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
}
