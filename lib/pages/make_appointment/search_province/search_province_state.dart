import 'package:equatable/equatable.dart';

abstract class SearchProvinceState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSearchProvinceState extends SearchProvinceState {

  @override
  String toString() {
    return 'InitialSearchProvinceState{}';
  }
}

class GetPrefsSuccess extends SearchProvinceState{

  @override
  String toString() {
    return 'GetPrefsSuccess{}';
  }
}

class SearchValuesSuccess extends SearchProvinceState{

  @override
  String toString() {
    return 'SearchValuesSuccess{}';
  }
}

class GetListProvinceSuccess extends SearchProvinceState{

  @override
  String toString() {
    return 'GetListProvinceSuccess{}';
  }
}


class SearchProvinceLoading extends SearchProvinceState {

  @override
  String toString() => 'SearchProvinceLoading';
}

class SearchProvinceFailure extends SearchProvinceState {
  final String error;

  SearchProvinceFailure(this.error);

  @override
  String toString() => 'SearchProvinceFailure { error: $error }';
}

class GetListProvinceEmpty extends SearchProvinceState {

  @override
  String toString() {
    return 'GetListProvinceEmpty{}';
  }
}