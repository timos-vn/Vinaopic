import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as libGetX;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/core/values/colors.dart';
import 'package:vinaoptic/core/values/images.dart';
import 'package:vinaoptic/models/network/response/search_product_response.dart';
import 'package:vinaoptic/pages/search_product/search_product_bloc.dart';
import 'package:vinaoptic/pages/search_product/search_product_event.dart';
import 'package:vinaoptic/pages/search_product/search_product_state.dart';
import 'package:vinaoptic/widget/pending_action.dart';

class SearchProductPage extends StatefulWidget {
  final bool? selected;

  const SearchProductPage({Key? key, this.selected}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchProductPageState();
  }
}

class SearchProductPageState extends State<SearchProductPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final focusNode = FocusNode();
  TextEditingController _searchController =  TextEditingController();
  late SearchProductBloc _bloc;
  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  bool _hasReachedMax = true;

  List<SearchProductResponseData> _dataListSearch = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = SearchProductBloc(context);

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedMax && _bloc.isScroll == true) {
        _bloc.add(SearchProduct(_searchController.text, isLoadMore: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: BlocListener<SearchProductBloc, SearchProductState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is SearchProductFailure){}
              if (state is RequiredText) {
                // Utils.showToast('Vui lòng nhập kí tự cần tìm kiếm!');
              }
            },
            child: BlocBuilder<SearchProductBloc, SearchProductState>(
                bloc: _bloc,
                builder: (BuildContext context, SearchProductState state) {
                  return Scaffold(
                      backgroundColor: white,
                      appBar: AppBar(
                        backgroundColor: mainColor,
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
                                    child: TextField(
                                      autofocus: true,
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.top,
                                      style:
                                      TextStyle(fontSize: 14, color: Colors.white),
                                      focusNode: focusNode,
                                      onSubmitted: (text) {

                                      },
                                      controller: _searchController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onChanged: (text) => _bloc.add(SearchProduct(text)),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: transparent,
                                        hintText: 'Tìm kiếm sản phẩm',
                                        hintStyle: TextStyle(color: Colors.white),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 15, top: 10)
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
                      body: _buildPage(context, state));
                })),
      ),
    );
  }

  Widget _buildPage(BuildContext context, state) {
    _dataListSearch = _bloc.searchResults;
    int length = _dataListSearch.length;
    if (state is SearchProductSuccess)
      _hasReachedMax = length < _bloc.currentPage * 20;
    else
      _hasReachedMax = false;
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: white,
        child: Stack(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Utils.isEmpty(_dataListSearch) ? Center(child: Image.asset(noData,fit: BoxFit.contain,))
                    :
                ListView.separated(
                  padding: EdgeInsets.only(top: 5,bottom: 80),
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
                        ?
                    Container(
                      color: white,)
                        :
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context,_dataListSearch[index].maVt);
                      },
                      child: Card(
                        elevation: 10,
                        semanticContainer: true,
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        shadowColor: Colors.blueGrey.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8,right: 6,top: 10,bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                                    borderRadius:const BorderRadius.all( Radius.circular(6),)
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:const EdgeInsets.only(left: 10,right: 3,top: 6,bottom: 5),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mã SP: ${_dataListSearch[index].maVt.toString().trim()}',
                                        textAlign: TextAlign.left,
                                        style:const TextStyle(fontWeight: FontWeight.normal,fontSize: 11,color: Colors.blueGrey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Tên SP: ${_dataListSearch[index].tenVt.toString().trim()}',
                                              textAlign: TextAlign.left,
                                              style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          const Text('Tồn kho: đang cập nhật',style: TextStyle(color: Colors.grey,fontSize: 11),),
                                          const SizedBox(width: 3,),
                                          // Expanded(child: Text('${_dataListSearch[index].tenBs.toString().trim()}', style: const TextStyle(color: Colors.grey,fontSize: 12),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15,right: 15),
                      //   child: demoTopRatedDr(
                      //     _dataListSearch[index].imageUrl??'https://source.unsplash.com/random?sig=$index',
                      //     _dataListSearch[index].tenVt??'',
                      //     _dataListSearch[index].maVt??'',
                      //     '',
                      //     "",
                      //   ),
                      // ),
                    );
                  },
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
          Visibility(
            visible: state is EmptySearchProductState,
            child: Center(
              child: Text('Không tìm thấy sản phẩm',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
            ),
          ),
          Visibility(
            visible: state is SearchProductLoading,
            child: PendingAction(),
          ),
        ]));
  }

  Widget demoTopRatedDr(String img, String name, String speciality, String rating, String distance) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      // width: size.width,
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
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Mã VT: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    speciality,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )
                              ],
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
