import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class GetListOrderEvent extends CartEvent {
  final String dateFrom;
  final String dateTo;
  final bool isLoadMore;
  final bool isRefresh;
  final String dataType;
  GetListOrderEvent(this.dateFrom,this.dateTo, this.dataType,{this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'GetListOrderEvent{dateFrom: $dateFrom,dateTo: $dateTo, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}