import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSearchProductState extends SearchProductState {
  @override
  String toString() {
    // TODO: implement toString
    return 'InitialSearchProductState{}';
  }
}

class SearchProductSuccess extends SearchProductState {
  @override
  String toString() {
    // TODO: implement toString
    return 'SearchProductSuccess{}';
  }
}

class EmptySearchProductState extends SearchProductState {
  @override
  String toString() {
    // TODO: implement toString
    return 'EmptySearchState{}';
  }
}

class RequiredText extends SearchProductState {
  @override
  String toString() {
    // TODO: implement toString
    return 'RequiredText{}';
  }
}

class SearchProductLoading extends SearchProductState{
  @override
  String toString() {
    // TODO: implement toString
    return 'SearchLoading{}';
  }
}

class CheckShowCloseState extends SearchProductState {
  @override
  String toString() {
    // TODO: implement toString
    return 'InitialProductState{}';
  }
}

class SearchProductFailure extends SearchProductState{
  final String message;

  SearchProductFailure(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return 'SearchProductFailure{}';
  }
}