import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/widget/pending_action.dart';

import '../list_history_customer_bloc.dart';
import '../list_history_customer_event.dart';
import '../list_history_customer_state.dart';


class PhieuMuaHangPage extends StatefulWidget {
  final String maKH;

  const PhieuMuaHangPage({Key? key,required this.maKH}) : super(key: key);
  @override
  _PhieuMuaHangPageState createState() => _PhieuMuaHangPageState();
}

class _PhieuMuaHangPageState extends State<PhieuMuaHangPage> {

  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;
  late ScrollController _scrollController;
  late ListHistoryCustomerBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ListHistoryCustomerBloc(context);
    _scrollController = ScrollController();
    _bloc.add(GetListHistoryCustomerEvent( widget.maKH,1));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _bloc.add(GetListHistoryCustomerEvent(widget.maKH,1,isLoadMore: true,));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListHistoryCustomerBloc,ListHistoryCustomerState>(
        bloc: _bloc,
        listener: (context,state){

        },
        child: BlocBuilder<ListHistoryCustomerBloc,ListHistoryCustomerState>(
          bloc: _bloc,
          builder: (BuildContext context,ListHistoryCustomerState state){
            if (state is ListHistoryCustomerFailure){}
            if (state is GetListHistoryCustomerSuccessful){
              _hasReachedMax = _bloc.list.length < _bloc.currentPage * 20;
            }
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: double.infinity,
                    width: double.infinity,
                    child:Utils.isEmpty(_bloc.list) ? Center(
                      child: Image.asset(noData,fit: BoxFit.contain,),
                    ) :   ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.only(top: 0,bottom: 80),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder:  (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailOrderPage(
                                //   nameCustomer: _bloc.mainInfo.tenKh,
                                //   phoneCustomer: _bloc.mainInfo.dienThoai,
                                //   addressCustomer: _bloc.mainInfo.diaChi,
                                //   maKH: _bloc.mainInfo.maKh,
                                //   typeView: 3,
                                //   sttRec: _bloc.list[index].sttRec,
                                //   dienGiai: _bloc.list[index].ghiChu,
                                // )));
                              },
                              child: demoTopRatedDr(
                                'https://source.unsplash.com/random?sig=$index',
                                _bloc.list[index].noiDung??'',
                                _bloc.list[index].maKh??'',
                                DateFormat('yyyy-MM-dd').format(DateTime.parse(_bloc.list[index].ngayCt.toString())),
                                _bloc.list[index].tenNV??'',
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index)=>Container(height: 10,),
                        itemCount: _bloc.list.length
                    ),
                  ),
                  Visibility(
                    visible: state is EmptyDataState,
                    child: Center(
                      child: Image.asset(noData,fit: BoxFit.contain,),
                    ),
                  ),
                  Visibility(
                    visible: state is ListHistoryCustomerLoading,
                    child: PendingAction(),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  Widget demoTopRatedDr(String img, String name, String speciality, String rating, String desc) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 90,
            width: 50,
            child:Image.network(img,fit: BoxFit.contain),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 5,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Code: ",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        speciality,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3, left: size.width * 0.15),
                            child: Row(
                              children: [
                                // Container(
                                //   child: Text(
                                //     "Code: ",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 12,
                                //       fontFamily: 'Roboto',
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  child: Text(
                                    rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "NV:  ",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              desc,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                              ),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
