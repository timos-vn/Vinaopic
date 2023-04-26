import 'package:equatable/equatable.dart';

abstract class ListHistoryCustomerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListHistoryCustomerEvent extends ListHistoryCustomerEvent {
  final String maKH;
  final int typeData;
  final bool isLoadMore;
  final bool isRefresh;
  GetListHistoryCustomerEvent(this.maKH,this.typeData,{this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'GetListHistoryCustomerEvent{isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}