import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateBottomNavigation extends MainEvent {
  final int position;

  NavigateBottomNavigation(this.position);

  @override
  String toString() => 'NavigateBottomNavigation: $position';
}

class NavigateProfile extends MainEvent {

  @override
  String toString() => 'NavigateProfile';
}
class GetListOrderEventMain extends MainEvent {
  final String dateFrom;
  final String dateTo;
  final bool isLoadMore;
  final bool isRefresh;
  final String dataType;
  GetListOrderEventMain(this.dateFrom,this.dateTo, this.dataType,{this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'GetListOrderEventMain{dateFrom: $dateFrom,dateTo: $dateTo, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}
class ImmediateLogOut extends MainEvent {
  ImmediateLogOut();

  @override
  String toString() => 'ImmediateLogOut';
}

class ChangeTitleAppbarEvent extends MainEvent {
  final String? title;

  ChangeTitleAppbarEvent({this.title});

  @override
  String toString() {
    return 'ChangeTitleAppbarEvent{title: $title}';
  }
}

class GetCountProduct extends MainEvent{

  final int count ;

  GetCountProduct(this.count);

  @override
  String toString() {
    return 'GetCountProduct{count: $count}';
  }
}

class GetPermissionEvent extends MainEvent {

  @override
  String toString() {
    return 'GetPermissionEvent{}';
  }
}

class GetCountNoti extends MainEvent{
  final bool isRefresh;

  GetCountNoti({this.isRefresh = false});
  @override
  String toString() {
    return 'GetCountNoti{isRefresh: $isRefresh}';
  }
}

class LogoutMainEvent extends MainEvent {

  @override
  String toString() {
    return 'LogoutMainEvent{}';
  }
}

class RefreshMain extends MainEvent{
  @override
  String toString() {
    return 'RefreshMain{}';
  }
}

class NavigateToPay extends MainEvent{
  @override
  String toString() {
    // TODO: implement toString
    return 'NavigateToPay{}';
  }
}

class NavigateToNotification extends MainEvent{
  @override
  String toString() {
    // TODO: implement toString
    return 'NavigateToNotification{}';
  }
}

class GetCountApprovalEvent extends MainEvent {
  @override
  String toString() => 'GetCountApprovalEvent {}';
}

class SetEvent extends MainEvent {
  final String unitName;
  final String storeName;
  final String userName;
  final List<String> listInfoUnitsID;
  final List<String> listInfoUnitsName;
  final String currentCompanyID;
  final String currentCompanyName;

  SetEvent(this.unitName,this.storeName,this.userName,this.listInfoUnitsID,this.listInfoUnitsName,this.currentCompanyID,this.currentCompanyName);
  @override
  String toString() => 'SetEvent {}';
}

class GetCountNotiSMS extends MainEvent{
  final bool isRefresh;

  GetCountNotiSMS({this.isRefresh = false});
  @override
  String toString() {
    return 'GetCountNotiSMS{isRefresh: $isRefresh}';
  }
}

class GetListCustomerAwait extends MainEvent {
  final String dateFrom;
  final String dateTo;
  final bool isLoadMore;
  final bool isRefresh;
  GetListCustomerAwait(this.dateFrom,this.dateTo, {this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'GetListCustomerAwait{dateFrom: $dateFrom,dateTo: $dateTo, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}