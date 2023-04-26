import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as libGetX;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/search_customer_response.dart';
import 'package:vinaoptic/pages/customer/list_history_customer/list_history_customer_page.dart';
import 'package:vinaoptic/pages/search_customer/search_customer_bloc.dart';
import 'package:vinaoptic/pages/search_customer/search_customer_event.dart';
import 'package:vinaoptic/widget/pending_action.dart';
import 'search_customer_state.dart';

class SearchCustomerPage extends StatefulWidget {
  final bool? selected;
  final int? typeView;
  const SearchCustomerPage({Key? key, this.selected,this.typeView}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchCustomerPageState();
  }
}

class SearchCustomerPageState extends State<SearchCustomerPage> {
  final focusNode = FocusNode();
  late TextEditingController _searchController;
  late SearchCustomerBloc _bloc;
  late ScrollController _scrollController;
  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;

  List<SearchCustomerResponseData> _dataListSearch = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.typeView);
    _bloc = SearchCustomerBloc(context);
    _searchController = new TextEditingController();
    // Future.delayed(Duration(seconds: 3));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _bloc.add(SearchCustomer(_searchController.text, isLoadMore: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: BlocListener<SearchCustomerBloc, SearchCustomerState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is SearchFailure){}
                // Utils.showToast(state.message.toString());
              if (state is RequiredText) {
                Utils.showCustomToast(context,Icons.warning_amber_outlined,'Vui lòng nhập kí tự cần tìm kiếm!');
              }
            },
            child: BlocBuilder<SearchCustomerBloc, SearchCustomerState>(
                bloc: _bloc,
                builder: (BuildContext context, SearchCustomerState state) {
                  return Scaffold(
                      backgroundColor: white,
                      appBar: AppBar(
                        titleSpacing: 0,
                        title: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.only(left: 8,top:10,right: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child:
                                    TextField(
                                      autofocus: true,
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.top,
                                      style:
                                      TextStyle(fontSize: 14, color: Colors.white),
                                      focusNode: focusNode,
                                      onSubmitted: (text) {
                                        _bloc.add(SearchCustomer(text));
                                      },
                                      controller: _searchController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onChanged: (text) => _bloc.add(SearchCustomer(text)),//_bloc.add(CheckShowCloseEvent(text)),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: transparent,
                                        hintText: 'Tìm kiếm khách hàng',
                                        hintStyle: TextStyle(color: Colors.white),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 15, top: 10,left: 6)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _bloc.isShowCancelButton,
                                child: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0,top:0,right: 8,bottom: 10),
                                      child: Icon(
                                        MdiIcons.close,
                                        color: accent,
                                        size: 28,
                                      ),
                                    ),
                                    onTap: () {
                                      _searchController.text = "";
                                      _bloc.add(CheckShowCloseEvent(""));
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                      body: _buildPage(context, state)
                  );
                })),
      ),
    );
  }

  Widget _buildPage(BuildContext context, state) {
    _dataListSearch = _bloc.searchResults;
    int length = _dataListSearch.length;
    if (state is SearchSuccess)
      _hasReachedMax = length < _bloc.currentPage * 20;//_bloc.maxPage
    else
      _hasReachedMax = false;
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(children: <Widget>[
          Column(
            children: [
              Expanded(
                child:Utils.isEmpty(_dataListSearch) ? Center(child: Image.asset(noData,fit: BoxFit.contain,)) :
                ListView.separated(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return Container();
                    },
                    shrinkWrap: true,
                    itemCount: length == 0
                        ? length
                        : _hasReachedMax ? length : length + 1,
                    itemBuilder: (context, index) {
                      return index >= length
                          ? Container(
                        height: 100.0,
                        color: white,
                        // child: PendingAction(),
                      )
                          :
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: GestureDetector(
                          onTap: (){
                            if(widget.typeView == 0){
                              Navigator.pop(context,_dataListSearch[index]);
                            }else if(widget.typeView == 1){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListHistoryCustomerPage(maKH: _dataListSearch[index].maKh,nameCustomer:_dataListSearch[index].tenKh ,)));
                            }
                          },
                          child: demoTopRatedDr(
                            'https://source.unsplash.com/random?sig=$index',
                            _dataListSearch[index].tenKh??'',
                            _dataListSearch[index].diaChi??'',
                            _dataListSearch[index].dienThoai??'',
                            "",
                          ),
                        ),
                      );
                    },
                  ),
              ),
              // Visibility(
              //   visible: _bloc.searchResults.isEmpty,
              //   child: Padding(
              //     padding: const EdgeInsets.all(30.0),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(24)),
              //         color: Colors.indigoAccent,
              //       ),
              //       width: double.infinity,
              //       height: 45.0,
              //       child: Center(child: Text('Thêm mới',style: TextStyle(color: Colors.white),)),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10,),
            ],
          ),
          Visibility(
            visible: state is EmptySearchState,
            child: Center(
              child: Text('NoData'.tr),
            ),
          ),
          Visibility(
            visible: state is SearchLoading,
            child: PendingAction(),
          ),
        ]));
  }

  Widget demoTopRatedDr(String img, String name, String speciality, String rating, String distance) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 90,

      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
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
              margin: EdgeInsets.only(left: 20, top: 10,right: 10),
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
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              speciality,
                              style: TextStyle(
                                color: Color(0xffababab),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,fontSize: 12
                              ),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                           margin: EdgeInsets.only(top: 3, left: size.width * 0.15),
                            child: Row(
                              children: [
                                // Container(
                                //   child: Text(
                                //     "Phone: ",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.reset();
    super.dispose();
  }
}
