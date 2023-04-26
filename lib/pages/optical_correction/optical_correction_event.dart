import 'package:equatable/equatable.dart';

abstract class OpticalCorrectionEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class UploadAvatarEvent extends OpticalCorrectionEvent {
  final bool isUploadFromCamera;

  UploadAvatarEvent(this.isUploadFromCamera);

  @override
  String toString() {
    return 'UploadAvatarEvent{isUploadFromCamera: $isUploadFromCamera}';
  }
}