import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vinaoptic/core/untils/const.dart';
import 'package:vinaoptic/core/untils/utils.dart';
import 'package:vinaoptic/pages/account/account_bloc.dart';
import 'package:vinaoptic/pages/account/account_screen.dart';
import 'package:vinaoptic/pages/notification/notification_bloc.dart';
import 'package:vinaoptic/pages/notification/notification_page.dart';
import 'package:vinaoptic/widget/pending_action.dart';
import '../home/home_bloc.dart';
import '../home/home_page.dart';
import 'main_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainPage extends StatefulWidget {
  final String? unitName;
  final List<String>? listInfoUnitsID;
  final List<String>? listInfoUnitsName;
  final String? userName;
  final String? storeName;
  final String? storeId;

  const MainPage({Key? key,this.userName, this.unitName,this.listInfoUnitsID, this.listInfoUnitsName,this.storeName,this.storeId}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainBloc _mainBloc;
  late HomeBloc _homeBloc;
  late NotificationBloc _notificationBloc;
  late AccountBloc _accountBloc;
  int _lastIndexToShop = 0;
  int _currentIndex = 0;

  late GlobalKey<NavigatorState> _currentTabKey;
  List<BottomNavigationBarItem> listBottomItems = [];
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  final GlobalKey<HomePageState> _homePageKey = GlobalKey();

  late PersistentTabController _controller;

  @override
  void initState() {
    _mainBloc = MainBloc(context);
    _homeBloc = HomeBloc(context);
    _notificationBloc = NotificationBloc(context);
    _accountBloc = AccountBloc(context);
    _controller = PersistentTabController(initialIndex: 1);
    _currentTabKey = firstTabNavKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
          bool isSuccess = await _currentTabKey.currentState!.maybePop();
          if (!isSuccess && _currentIndex != Const.HOME) {
            _lastIndexToShop = Const.HOME;
            _mainBloc.add(NavigateBottomNavigation(Const.HOME));
            _currentIndex = _lastIndexToShop;
            _currentTabKey = firstTabNavKey;
          }
          if (!isSuccess) _exitApp(context);
          return false;
      },
      child: Scaffold(
        body: MultiBlocProvider(
            providers: [
              BlocProvider<MainBloc>(
                create: (context) {
                  if (_mainBloc == null) _mainBloc = MainBloc(context);
                  return _mainBloc;
                },
              ),
              BlocProvider<HomeBloc>(
                create: (context) {
                  if (_homeBloc == null) _homeBloc = HomeBloc(context);
                  return _homeBloc;
                },
              ),
              BlocProvider<NotificationBloc>(
                create: (context) {
                  if (_notificationBloc == null) _notificationBloc = NotificationBloc(context);
                  return _notificationBloc;
                },
              ),
              BlocProvider<AccountBloc>(
                create: (context) {
                  if (_accountBloc == null) _accountBloc = AccountBloc(context);
                  return _accountBloc;
                },
              ),
            ],
            child: BlocListener<MainBloc, MainState>(
              bloc: _mainBloc,
              listener: (context, state) {
                if (state is LogoutFailure) {
                  Get.snackbar('Status'.tr, state.error, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5));
                }
                if (state is LogoutSuccess) {
                  _lastIndexToShop = Const.HOME;
                  _currentIndex = _lastIndexToShop;
                  _currentTabKey = firstTabNavKey;
                  _mainBloc.add(GetCountNoti());

                }
                if (state is NavigateToNotificationState) {
                }
              },
              child: BlocBuilder<MainBloc, MainState>(
                bloc: _mainBloc,
                builder: (context, state) {
                  if (state is MainPageState) {
                    _currentIndex = state.position;
                    if (_currentIndex == Const.HOME) {
                      _homePageKey.currentState?.setState(() {
                        _mainBloc.listAwaitingCustomer = _mainBloc.listAwaitingCustomer;
                      });
                    }
                  }
                  if (state is MainProfile) {
                    _currentTabKey = secondTabNavKey;
                  }
                  _mainBloc.init(context);
                  return
                    Stack(children: <Widget>[
                      PersistentTabView(
                        context,
                        controller: _controller,
                        screens: _buildScreens(),
                        items: _navBarsItems(),
                        confineInSafeArea: true,
                        handleAndroidBackButtonPress: true,
                        resizeToAvoidBottomInset: true,
                        stateManagement: true,
                        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 0.0
                            : kBottomNavigationBarHeight,
                        hideNavigationBarWhenKeyboardShows: true,
                        margin: EdgeInsets.all(0.0),
                        popActionScreens: PopActionScreensType.all,
                        bottomScreenMargin: 0.0,
                        onWillPop: (context) async {
                          await showDialog(
                            context: context!,
                            useSafeArea: true,
                            builder: (context) => Container(
                              height: 50.0,
                              width: 50.0,
                              color: Colors.white,
                              child: ElevatedButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                          return false;
                        },
                        selectedTabScreenContext: (context) {
                          if(_controller.index == 1){
                            _mainBloc.add(GetListCustomerAwait('','',isLoadMore: true));
                          }
                        },
                        hideNavigationBar: false,
                        backgroundColor: Colors.white,
                        decoration: NavBarDecoration(
                          //border: Border.all(),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, spreadRadius: 0.1),
                            ],
                            //colorBehindNavBar: Colors.indigo,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                        popAllScreensOnTapOfSelectedTab: true,
                        itemAnimationProperties: ItemAnimationProperties(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease,
                        ),
                        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property
                      ),
                    Visibility(
                      visible: state is MainLoading,
                      child: PendingAction(),
                    )
                  ]);
                },
              ),
            )),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      NotificationPage(),
      HomePage(storeId: widget.storeId,storeName: widget.storeName,),
      AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications_active_outlined),
        title: ("Thông báo"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home,color: Colors.white,),
        title: "Trang chủ",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle_outlined),
        title: ("Tài khoản"),
        activeColorPrimary: Colors.blueAccent,
        activeColorSecondary: Colors.pink,
        inactiveColorPrimary: Colors.grey,
        // onPressed: (context) {
        //   pushDynamicScreen(context,
        //       screen: SampleModalScreen(), withNavBar: true);
        // }
      ),
    ];
  }

  void _exitApp(BuildContext context) {
    List<Widget> actions = [
      ElevatedButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: Text('No'.tr,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 14,
            )),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: Text(
          'Yes'.tr,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 14,
          ),
        ),
      )
    ];

    Utils.showDialogTwoButton(
        context: context,
        title: 'Notice'.tr,
        contentWidget: Text(
          'ExitApp'.tr,
          style: TextStyle(fontSize: 16.0),
        ),
        actions: actions);
  }
}
