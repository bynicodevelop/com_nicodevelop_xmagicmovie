part of 'upload_bloc.dart';

class UploadState extends Equatable {
  final List<VideoDataModel> files;

  const UploadState(
    this.files,
  );

  @override
  List<Object> get props => [
        files,
      ];
}
