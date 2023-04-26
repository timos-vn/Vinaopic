import 'package:equatable/equatable.dart';

abstract class QRCodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCameraEvent extends QRCodeEvent {

  @override
  String toString() {
    return 'GetCameraEvent{}';
  }
}

class ScanItemEvent extends QRCodeEvent {
  final String scanCode;

  ScanItemEvent(this.scanCode);

  @override
  String toString() {
    return 'ScanItemEvent{scanCode: $scanCode}';
  }
}
class RefreshEvent extends QRCodeEvent {

  @override
  String toString() {
    return 'RefreshEvent{}';
  }
}