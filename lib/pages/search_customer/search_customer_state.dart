import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchCustomerState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchCustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'InitialSearchState{}';
  }
}

class SearchSuccess extends SearchCustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'SearchSuccess{}';
  }
}

class EmptySearchState extends SearchCustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'EmptySearchState{}';
  }
}

class RequiredText extends SearchCustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'RequiredText{}';
  }
}

class SearchLoading extends SearchCustomerState{
  @override
  String toString() {
    // TODO: implement toString
    return 'SearchLoading{}';
  }
}

class CheckShowCloseState extends SearchCustomerState {
  @override
  String toString() {
    // TODO: implement toString
    return 'InitialSearchState{}';
  }
}

class SearchFailure extends SearchCustomerState{
  final String message;

  SearchFailure(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return 'SearchFailure{}';
  }
}

class ShareItemSuccess extends SearchCustomerState {

  @override
  String toString() {
    return 'ShareItemSuccess{}';
  }
}