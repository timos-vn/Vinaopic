import 'package:equatable/equatable.dart';

abstract class QRCodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class QRCodeInitial extends QRCodeState {

  @override
  String toString() => 'QRCodeInitial';
}

class QRCodeLoading extends QRCodeState {

  @override
  String toString() => 'QRCodeLoading';
}

class QRCodeFailure extends QRCodeState {
  final String error;

  QRCodeFailure(this.error);

  @override
  String toString() => 'QRCodeFailure { error: $error }';
}

class RefreshQRCodeSuccess extends QRCodeState {

  @override
  String toString() {
    return 'RefreshQRCodeSuccess{}';
  }
}
class GrantCameraPermission extends QRCodeState {

  @override
  String toString() {
    return 'GrantCameraPermission{}';
  }
}
class ScanItemSuccess extends QRCodeState {

  ScanItemSuccess();

  @override
  String toString() => 'ScanItemSuccess';
}
