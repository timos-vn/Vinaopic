import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListCustomerEvent extends CustomerEvent {
  final bool? isScroll;
  final bool isRefresh;
  final bool isLoadMore;
  final bool? isReLoad;

  GetListCustomerEvent({this.isScroll,this.isRefresh = false, this.isLoadMore = false,this.isReLoad});

  @override
  String toString() => 'isScroll: $isScroll,GetListCustomerEvent {isRefresh: $isRefresh, isLoadMore: $isLoadMore,isReLoad: $isReLoad}';
}
