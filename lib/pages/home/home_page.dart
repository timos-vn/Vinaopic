import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/models/network/response/get_list_awaiting_customer_response.dart';
import 'package:vinaoptic/pages/appointment_schedule/appointment_schedule_page.dart';
import 'package:vinaoptic/pages/cart/cart_page.dart';
import 'package:vinaoptic/pages/main/main_bloc.dart';
import 'package:vinaoptic/pages/main/main_event.dart';
import 'package:vinaoptic/pages/make_appointment/make_appointment_page.dart';
import 'package:vinaoptic/pages/qr_code/qr_code_page.dart';
import 'package:vinaoptic/widget/custom_slider.dart';

import 'component/search_ticket.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_sate.dart';

class HomePage extends StatefulWidget {

  final String? storeName;
  final String? storeId;

  HomePage({Key? key,this.storeName,this.storeId}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>  with TickerProviderStateMixin{
  ScrollController controller = ScrollController();
  late AnimationController animationController;

  late MainBloc _mainBloc;
  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;
  late HomeBloc _bloc;

  List<String> slider = [
    'https://images.unsplash.com/photo-1465408953385-7c4627c29435?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MzV8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/flagged/photo-1574876242429-3164fb8bf4bc?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
    'https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60',
    'https://images.unsplash.com/photo-1483118714900-540cf339fd46?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60'
  ];

  List<Map<String, Object>> recentlys = [
    {
      'title': 'Summer Loose Korean T-shirt',
      'price': '30',
      'imgUrl':
      'https://images.unsplash.com/photo-1475180098004-ca77a66827be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTd8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    },
    {
      'title': 'Bat Sleeve Student T-shirt Summer',
      'price': '35',
      'imgUrl':
      'https://images.unsplash.com/photo-1563826904577-6b72c5d75e53?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTQzfHxmYXNoaW9ufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    },
    {
      'title': 'Summer New Korean Version',
      'price': '25',
      'imgUrl':
      'https://images.unsplash.com/photo-1485462537746-965f33f7f6a7?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjZ8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    },
    {
      'title': 'Loose-fitting Outside Shirt',
      'price': '30',
      'imgUrl':
      'https://images.unsplash.com/photo-1533407411655-dcce1534c1a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=376&q=80',
    },
    {
      'title': 'Cotton Short-sleeved T-shirt',
      'price': '20',
      'imgUrl':
      'https://images.unsplash.com/photo-1507007727303-1532f71109cf?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
    },
    {
      'title': 'Summer Loose Korean T-shirt',
      'price': '30',
      'imgUrl':
      'https://images.unsplash.com/photo-1581044777550-4cfa60707c03?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    },
    {
      'title': 'Bat Sleeve Student T-shirt Summer',
      'price': '35',
      'imgUrl':
      'https://images.unsplash.com/photo-1545291730-faff8ca1d4b0?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    },
    {
      'title': 'Summer New Korean Version',
      'price': '25',
      'imgUrl':
      'https://images.unsplash.com/photo-1562572159-4efc207f5aff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60',
    },
    {
      'title': 'Loose-fitting Outside Shirt',
      'price': '30',
      'imgUrl':
      'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
    },
    {
      'title': 'Cotton Short-sleeved T-shirt',
      'price': '20',
      'imgUrl':
      'https://images.unsplash.com/photo-1541257710737-06d667133a53?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
    }
  ];

  @override
  void initState() {
    _bloc = HomeBloc(context);
    _mainBloc = BlocProvider.of<MainBloc>(context);
    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _mainBloc.add(GetListCustomerAwait('',''));
    _bloc.add(GetListBanner());
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _mainBloc.add(GetListCustomerAwait('','',isLoadMore: true));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        body: BlocListener(
          bloc: _bloc,
          listener: (context,state){

          },
          child: BlocBuilder(
            bloc: _bloc,
            builder: (BuildContext context, HomeState state){
              List<GetListAwaitingCustomerResponseData> _list = _mainBloc.listAwaitingCustomer;
              return  buildPage();
            },
          ),
        ));
  }

  Widget buildPage(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          // Container(
          //   height: 200,
          //   width: double.infinity,
          //   child: Utils.isEmpty(slider) ? Container(color: Colors.blueGrey,) : CustomCarousel(items: slider,),
          // ),//
          menu(),
          Expanded(
            child: AppointmentSchedulePage(),
          ),// SliverAp
        ],
      ),
    );
  }

  Widget menu() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color:  Color(0xFFFFFFFF),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color:Color(0xFFFFFFFF),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Menu",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text("All", style: TextStyle(color: grey)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: grey,
                            size: 16,
                          )
                        ],
                      ),
                    ]
                ),
                SizedBox(height: 15,),
                Container(
                  height: 95,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap:()=>pushNewScreen(context, screen: MakeAppointmentPage(storeId: widget.storeId,storeName: widget.storeName,),withNavBar: false),
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              child: Icon(MdiIcons.timetable,color: Colors.blueGrey,size: 25,),
                            ),
                            SizedBox(height: 10,),
                            Text('Đặt lịch',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                          ],
                        ),
                      ),
                      SizedBox(width: 30,),
                      InkWell(
                        onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodePage())),
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              child: Icon(MdiIcons.shopping,color: Colors.blueGrey,size: 25,),
                            ),
                            SizedBox(height: 10,),
                            Text('Mua hàng',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                          ],
                        ),
                      ),
                      SizedBox(width: 30,),
                      InkWell(
                        onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage())),
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              child: Icon(Icons.shopping_cart,color: Colors.blueGrey,size: 25,),
                            ),
                            SizedBox(height: 10,),
                            Text('Giỏ hàng',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                          ],
                        ),
                      ),
                      SizedBox(width: 30,),
                      InkWell(
                        onTap: ()async{

                          final Uri _url = Uri.parse('https://kinhmatvietnam.com.vn/pages/tat-ca-tin-tuc');

                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(color: Colors.blueGrey),
                              ),
                              child: Icon(MdiIcons.newspaper,color: Colors.blueGrey,size: 25,),
                            ),
                            SizedBox(height: 10,),
                            Text('Tin tức',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                          ],
                        ),
                      ),
                      SizedBox(width: 30,),
                      // InkWell(
                      //   onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryPage())),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(5),
                      //         height: 55,
                      //         width: 55,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.all(Radius.circular(16)),
                      //           border: Border.all(color: Colors.blueGrey),
                      //         ),
                      //         child: Icon(MdiIcons.avTimer,color: Colors.blueGrey,size: 25,),
                      //       ),
                      //       SizedBox(height: 10,),
                      //       Text('Lịch sử',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(width: 30,),
                      // InkWell(
                      //   // onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Doctor(animationController: animationController))),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(5),
                      //         height: 55,
                      //         width: 55,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.all(Radius.circular(16)),
                      //           border: Border.all(color: Colors.blueGrey),
                      //         ),
                      //         child: Icon(MdiIcons.doctor,color: Colors.blueGrey,size: 25,),
                      //       ),
                      //       SizedBox(height: 10,),
                      //       Text('Bác sỹ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(width: 30,),
                      // InkWell(
                      //   // onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerPage(animationController: animationController))),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(5),
                      //         height: 55,
                      //         width: 55,
                      //         decoration: BoxDecoration(
                      //             border: Border.all(color: Colors.blueGrey),
                      //             borderRadius: BorderRadius.all(Radius.circular(16))
                      //         ),
                      //         child: Icon(MdiIcons.humanFemaleFemale,color: Colors.blueGrey,size: 25,),
                      //       ),
                      //       SizedBox(height: 10,),
                      //       Text('Khách hàng',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 5,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Options",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap:()=>pushNewScreen(context, screen: SearchTicketScreen(),withNavBar: false),
                        child: Row(
                          children: [
                            Text("Find", style: TextStyle(color: Colors.transparent)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.search_outlined,
                              color:  Colors.transparent,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}
