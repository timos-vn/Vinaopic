import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchCustomerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchCustomer extends SearchCustomerEvent {
  final String searchText;
  final bool isLoadMore;
  final bool isRefresh;
  SearchCustomer(this.searchText, {this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'SearchCustomer{searchText: $searchText, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}

class CheckShowCloseEvent extends SearchCustomerEvent {
  final String text;
  CheckShowCloseEvent(this.text);

  @override
  String toString() {
    // TODO: implement toString
    return 'CheckShowCloseEvent{}';
  }
}


