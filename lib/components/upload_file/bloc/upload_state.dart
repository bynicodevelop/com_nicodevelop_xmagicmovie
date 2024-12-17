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

class UploadInitial extends UploadState {
  const UploadInitial(
    super.files,
  );
}

class UploadInProgress extends UploadState {
  const UploadInProgress() : super(const []);
}

class UploadSuccess extends UploadState {
  const UploadSuccess(super.files);
}

class UploadFailure extends UploadState {
  final String error;

  const UploadFailure(this.error) : super(const []);

  @override
  List<Object> get props => [error, ...files];
}
