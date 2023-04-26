import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class GetAllListCustomerAwait extends HomeEvent {
  final String dateFrom;
  final String dateTo;
  final bool isLoadMore;
  final bool isRefresh;
  GetAllListCustomerAwait(this.dateFrom,this.dateTo, {this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'GetAllListCustomerAwait{dateFrom: $dateFrom,dateTo: $dateTo, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}

class GetListBanner extends HomeEvent {

  @override
  String toString() {
    return 'GetListBanner{}';
  }
}
class CheckShowCloseEvent extends HomeEvent {
  final String text;
  CheckShowCloseEvent(this.text);

  @override
  String toString() {
    // TODO: implement toString
    return 'CheckShowCloseEvent{}';
  }
}
class GetTicketEvent extends HomeEvent {

  final int pageIndex;
  final String dateFrom;
  final String dateTo;
  final String keySearch;
  final String status;

  GetTicketEvent({required this.pageIndex,required this.dateFrom,required this.dateTo, required this.keySearch,required this.status});

  @override
  String toString() {
    return 'GetTicketEvent{}';
  }
}