// import 'package:equatable/equatable.dart';
//
// abstract class OrderHistoryEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
//
//
// class GetListCustomer extends OrderHistoryEvent {
//   final String dateFrom;
//   final String dateTo;
//   final String dataType;
//   final bool isLoadMore;
//   final bool isRefresh;
//   GetListCustomer(this.dateFrom,this.dateTo, this.dataType,{this.isLoadMore = false, this.isRefresh = false});
//
//   @override
//   String toString() {
//     return 'SearchCustomer{dateFrom: $dateFrom,dateTo: $dateTo, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
//   }
// }