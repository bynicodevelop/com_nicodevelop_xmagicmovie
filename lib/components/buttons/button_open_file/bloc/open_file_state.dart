part of 'open_file_bloc.dart';

sealed class OpenFileState extends Equatable {
  final String finalPath;

  const OpenFileState({
    this.finalPath = '',
  });

  @override
  List<Object> get props => [
        finalPath,
      ];
}

final class OpenFileInitial extends OpenFileState {
  const OpenFileInitial({
    super.finalPath = '',
  });
}

final class OpenFileSuccess extends OpenFileState {
  const OpenFileSuccess({
    super.finalPath,
  });
}
