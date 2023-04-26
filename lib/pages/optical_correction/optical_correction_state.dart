import 'package:equatable/equatable.dart';

abstract class OpticalCorrectionState extends Equatable {
  @override
  List<Object> get props => [];
}

class OpticalCorrectionInitial extends OpticalCorrectionState {

  @override
  String toString() => 'OpticalCorrectionInitial';
}

class OpticalCorrectionLoading extends OpticalCorrectionState {

  @override
  String toString() => 'OpticalCorrectionLoading';
}

class PickAvatarSuccess extends OpticalCorrectionState {

  PickAvatarSuccess();

  @override
  String toString() {
    return 'PickAvatarSuccess{}';
  }
}
class OpticalCorrectionFailure extends OpticalCorrectionState {
  final String error;

  OpticalCorrectionFailure(this.error);

  @override
  String toString() => 'OpticalCorrectionFailure { error: $error }';
}
