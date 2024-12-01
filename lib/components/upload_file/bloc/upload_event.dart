part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

final class UploadFileEvent extends UploadEvent {
  final List<XFile> files;

  const UploadFileEvent(
    this.files,
  );

  @override
  List<Object> get props => [
        files,
      ];
}
