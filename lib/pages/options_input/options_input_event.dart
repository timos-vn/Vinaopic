import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OptionsInputEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class DateFrom extends OptionsInputEvent {
  final DateTime date;

  DateFrom(this.date);

  @override
  String toString() {
    // TODO: implement toString
    return 'DateFrom{}';
  }
}

class DateTo extends OptionsInputEvent {
  final DateTime date;

  DateTo(this.date);

  @override
  String toString() {
    // TODO: implement toString
    return 'DateTo{}';
  }
}

class PickGenderStatus extends OptionsInputEvent {

  final int? statusCode;
  final String? statusName;

  PickGenderStatus({this.statusCode,this.statusName});

  @override
  String toString() {
    return 'PickGenderStatus{statusCode: $statusCode}';
  }
}

class GetListTimeStatus extends OptionsInputEvent {


  @override
  String toString() {
    return 'GetListTimeStatus{}';
  }
}
