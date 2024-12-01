part of 'upload_bloc.dart';

class UploadState extends Equatable {
  final List<FileModel> files;

  const UploadState(
    this.files,
  );

  @override
  List<Object> get props => [
        files,
      ];
}
