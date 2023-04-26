import 'package:equatable/equatable.dart';

abstract class DetailOrderHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class GetDataDetail extends DetailOrderHistoryEvent {
  final String sttRec;

  GetDataDetail(this.sttRec,);

  @override
  String toString() {
    return 'GetDataDetail{}';
  }
}