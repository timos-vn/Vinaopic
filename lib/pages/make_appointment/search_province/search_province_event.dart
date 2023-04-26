import 'package:equatable/equatable.dart';

abstract class SearchProvinceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPrefsSearchProvince extends SearchProvinceEvent {
  @override
  String toString() => 'GetPrefsProvince';
}

class GetListProvinceEvent extends SearchProvinceEvent {

  final bool isRefresh;
  final bool isLoadMore;
  final String? idProvince;
  final String? idDistrict;
  final int typeGetList;
  final String keysText;
  GetListProvinceEvent({this.isRefresh = false, this.isLoadMore = false,this.idProvince,this.idDistrict,required this.typeGetList, required this.keysText});

  @override
  String toString() => 'GetListProvinceEvent {}';
}

class CheckShowCloseEvent extends SearchProvinceEvent {
  final String text;
  CheckShowCloseEvent(this.text);

  @override
  String toString() {
    // TODO: implement toString
    return 'CheckShowCloseEvent{}';
  }
}

class SearchProvincesEvent extends SearchProvinceEvent {

  final String keysText;

  SearchProvincesEvent({required this.keysText});

  @override
  String toString() {
    return 'SearchProvincesEvent{keysText: $keysText}';
  }
}

class SearchDistrictEvent extends SearchProvinceEvent {

  final String keysText;

  SearchDistrictEvent({required this.keysText});

  @override
  String toString() {
    return 'SearchDistrictEvent{keysText: $keysText}';
  }
}

class SearchCommuneEvent extends SearchProvinceEvent {

  final String keysText;

  SearchCommuneEvent({required this.keysText});

  @override
  String toString() {
    return 'SearchCommuneEvent{keysText: $keysText}';
  }
}