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
import '../../core/untils/debouncer.dart';
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
  final Debouncer onSearchDebounce =  Debouncer(delay:  const Duration(milliseconds: 1000));
  List<SearchCustomerResponseData> _dataListSearch = [];
  int lastPage=0;
  int selectedPage=1;

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
        _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
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
                                        _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
                                      },
                                      controller: _searchController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      onChanged: (text){
                                        onSearchDebounce.debounce(
                                              () {
                                            if(text.isNotEmpty){
                                              _bloc.searchResults.clear();
                                              _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
                                            }
                                          },
                                        );
                                        _bloc.add(CheckShowCloseEvent(text));
                                      },
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
                                        color: Colors.white,
                                        size: 22,
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
                            _dataListSearch[index].ngaySinh??'',
                          ),
                        ),
                      );
                    },
                  ),
              ),
              _bloc.totalPager > 1 ? _getDataPager() : Container(),
              const SizedBox(height: 5,),
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

  Widget demoTopRatedDr(String img, String tenKH, String diaChi, String dienThoai, String ngaySinh) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10),

      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 10,right: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Text(
                      tenKH.toString().toUpperCase(),
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Visibility(
                    visible: dienThoai.toString().replaceAll('null', '').isNotEmpty ,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Điện thoại: $dienThoai',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,fontSize: 12
                        ),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: ngaySinh.toString().replaceAll('null', '').isNotEmpty ,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Ngày sinh: $ngaySinh',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,fontSize: 12
                        ),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: diaChi.toString().replaceAll('null', '').isNotEmpty ,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Địa chỉ: $diaChi',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,fontSize: 12
                        ),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
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

  Widget _getDataPager() {
    return Center(
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
                          _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
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
                            _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
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
                                _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
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
                            _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
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
                          _bloc.add(SearchCustomer(searchValues:_searchController.text,pageIndex: selectedPage));
                        },
                        child: const Icon(Icons.skip_next_outlined,color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
