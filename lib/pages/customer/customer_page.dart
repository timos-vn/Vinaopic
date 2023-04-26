import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/pages/search_customer/search_customer_page.dart';
import 'package:vinaoptic/widget/pending_action.dart';

import 'customer_bloc.dart';
import 'customer_event.dart';
import 'customer_state.dart';
import 'list_history_customer/list_history_customer_page.dart';

class CustomerPage extends StatefulWidget {
  final AnimationController? animationController;

  const CustomerPage({Key? key, this.animationController}) : super(key: key);
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;
  late ScrollController _scrollController;
  late CustomerBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CustomerBloc(context);
    _bloc.add(GetListCustomerEvent());
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _bloc.add(GetListCustomerEvent(isLoadMore: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc,CustomerState>(
      bloc: _bloc,
        listener: (context,state){

        },
        child: BlocBuilder<CustomerBloc,CustomerState>(
          bloc: _bloc,
          builder: (BuildContext context,CustomerState state){
            if (state is CustomerFailure){}
            if (state is GetListCustomerSuccessful){
              _hasReachedMax = _bloc.listCustomer.length < _bloc.currentPage * 20;
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Danh sách Khách hàng',style: TextStyle(color: Colors.black),),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCustomerPage(typeView: 1,))),
                        child: Icon(Icons.search_outlined,color: Colors.black,)),
                  ),
                ],
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: double.infinity,
                    width: double.infinity,
                    child: ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.only(top: 0,bottom: 80),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder:  (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ListHistoryCustomerPage(maKH: _bloc.listCustomer[index].maKh,nameCustomer:_bloc.listCustomer[index].tenKh ,)));
                              },
                              child: demoTopRatedDr(
                                'https://source.unsplash.com/random?sig=$index',
                                _bloc.listCustomer[index].tenKh??'',
                                _bloc.listCustomer[index].dienThoai??'',
                                _bloc.listCustomer[index].maKh??'',
                                _bloc.listCustomer[index].diaChi??'',
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index)=>Container(height: 10,),
                        itemCount: _bloc.listCustomer.length
                    ),
                  ),
                  Visibility(
                    visible: state is CustomerLoading,
                    child: PendingAction(),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  Widget buildPageReport(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),borderRadius: BorderRadius.all(Radius.circular(16)), border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                            child: Text(
                              'Tìm kiếm',
                              style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14,fontStyle: FontStyle.normal),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Icon(MdiIcons.sortVariant),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.only(top: 15,bottom: 10),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder:  (BuildContext context, int index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            icLogo,

                          ),
                        ),),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${_bloc.listCustomer[index].tenKh.toString()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text('Mã KH: ${_bloc.listCustomer[index].maKh?.toString()}',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                SizedBox(height: 10,),
                                Text('Điện thoại: ${_bloc.listCustomer[index].dienThoai?.toString()}',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                SizedBox(height: 10,),
                                Text('Địa chỉ: ${_bloc.listCustomer[index].diaChi?.toString()}',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                SizedBox(height: 10,),
                              ],
                            ),
                          )),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index)=>Container(height: 10,),
                itemCount: _bloc.listCustomer.length
            )
          ),
        ],
      ),
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
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "SĐT: ",
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
                                Container(
                                  child: Text(
                                    "Code: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
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
                            "Đ/c:  ",
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
