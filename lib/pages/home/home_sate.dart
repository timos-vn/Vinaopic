import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {

  @override
  String toString() => 'HomeInitial';
}
class HomeLoading extends HomeState {

  @override
  String toString() => 'HomeLoading';
}

class GetLisCustomerEmpty extends HomeState {

  @override
  String toString() {
    return 'GetLisCustomerEmpty{}';
  }
}

class GetAllListCustomerSuccess extends HomeState {

  @override
  String toString() => 'GetAllListCustomerSuccess';
}
class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);

  @override
  String toString() => 'HomeFailure { error: $error }';
}

class RefreshHomeSuccess extends HomeState {

  @override
  String toString() {
    return 'RefreshHomeSuccess{}';
  }
}

class GetListBannerSuccess extends HomeState {

  @override
  String toString() {
    return 'GetListBannerSuccess{}';
  }
}