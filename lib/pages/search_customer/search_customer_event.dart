import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchCustomerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchCustomer extends SearchCustomerEvent {
  final String searchValues;
  final int pageIndex;

  SearchCustomer({required this.searchValues,required this.pageIndex});

  @override
  String toString() {
    return 'SearchCustomer{searchValues: $searchValues}';
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


