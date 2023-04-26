import 'package:equatable/equatable.dart';

abstract class AppointmentScheduleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetList extends AppointmentScheduleEvent {
  final String dateFrom;
  final String dateTo;
  final bool isLoadMore;
  final bool isRefresh;
  final String status;

  GetList(this.dateFrom,this.dateTo, {this.isLoadMore = false, this.isRefresh = false, required this.status});

  @override
  String toString() {
    return 'GetListFix{dateFrom: $dateFrom,dateTo: $dateTo, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}