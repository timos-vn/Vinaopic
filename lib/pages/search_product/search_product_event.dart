import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchProduct extends SearchProductEvent {
  final String searchText;
  final bool isLoadMore;
  final bool isRefresh;
  SearchProduct(this.searchText, {this.isLoadMore = false, this.isRefresh = false});

  @override
  String toString() {
    return 'SearchProduct{searchText: $searchText, isLoadMore: $isLoadMore, isRefresh: $isRefresh}';
  }
}

class CheckShowCloseEvent extends SearchProductEvent {
  final String text;
  CheckShowCloseEvent(this.text);

  @override
  String toString() {
    // TODO: implement toString
    return 'CheckShowCloseEvent{}';
  }
}


