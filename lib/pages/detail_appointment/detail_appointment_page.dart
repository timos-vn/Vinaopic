import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/detail_appointment_response.dart';
import 'package:vinaoptic/widget/pending_action.dart';

import 'detail_appointment_bloc.dart';
import 'detail_appointment_event.dart';
import 'detail_appointment_sate.dart';

class DetailAppointmentPage extends StatefulWidget {

  final String sttRec;

  const DetailAppointmentPage({Key? key,required this.sttRec}) : super(key: key);

  @override
  _DetailAppointmentPageState createState() => _DetailAppointmentPageState();
}

class _DetailAppointmentPageState extends State<DetailAppointmentPage> {

  late DetailAppointmentBloc _bloc;
  late DetailAppointmentResponseData item = DetailAppointmentResponseData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = DetailAppointmentBloc(context);
    _bloc.add(GetDetailAppointment(widget.sttRec));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DetailAppointmentBloc,DetailAppointmentState>(
        bloc: _bloc,
        listener: (context,state){
          if(state is GetDetailAppointmentSuccess){
            print( _bloc.listDetailAppointment.length);
            item = _bloc.listDetailAppointment[0];
          }
        },
        child: BlocBuilder<DetailAppointmentBloc,DetailAppointmentState>(
          bloc: _bloc,
          builder: (BuildContext context,DetailAppointmentState state){
            return buildPage(context, state);
          },
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context,DetailAppointmentState state){
    return Stack(
      children: <Widget>[
        Container(
          color: mainColor,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 37,left: 16,right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: ()=>Navigator.pop(context),
                      child: Container(
                          padding: EdgeInsets.only(left: 4,top: 6,bottom: 6,right: 6),
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                width: 0.5,
                                color: Colors.white,
                              )
                          ),
                          child: Center(child: Icon(Icons.arrow_back_outlined,color: Colors.white,size: 15,))),
                    ),
                    Text('Chi tiết lịch hẹn',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        icLogo,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: Colors.white,),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      )
                  ),
                  child: item.maKh.toString() == null ? Container() :  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(item.tenKh??'',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding:EdgeInsets.only(left: 10,top: 13,bottom: 13,right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text('Ngày đặt khám',style: TextStyle(fontSize: 13),),),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:EdgeInsets.only(left: 10,top: 13,bottom: 13,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text(item.ngayDatKham??'',style: TextStyle(fontSize: 13)),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding:EdgeInsets.only(top: 13,bottom: 13,),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text('Ngày khám',style: TextStyle(fontSize: 13),),),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:EdgeInsets.only(left: 10,top: 13,bottom: 13,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text(item.ngayKham??'',style: TextStyle(fontSize: 13)),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding:EdgeInsets.only(top: 13,bottom: 13,),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text('Cơ sở khám',style: TextStyle(fontSize: 13),),),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:EdgeInsets.only(left: 10,top: 13,bottom: 13,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text(item.coSoKham??'',style: TextStyle(fontSize: 13)),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding:EdgeInsets.only(top: 13,bottom: 13,),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text('Bác sỹ',style: TextStyle(fontSize: 13),),),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:EdgeInsets.only(top: 13,bottom: 13,),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(child: Text('2020101',style: TextStyle(fontSize: 13)),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding:EdgeInsets.only(top: 13,bottom: 13,),

                            child: Align(alignment: Alignment.centerLeft,child: Text('Nội dung khám',style: TextStyle(fontSize: 13),)),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            padding:EdgeInsets.only(left: 10,top: 13,bottom: 13,right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(child: Text(item.noiDung??'',style: TextStyle(fontSize: 13)),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        Visibility(
          visible: state is DetailAppointmentLoading,
          child: PendingAction(),
        ),
      ],
    );
  }

}
