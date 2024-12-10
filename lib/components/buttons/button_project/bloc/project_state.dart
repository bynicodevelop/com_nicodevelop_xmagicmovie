part of 'project_bloc.dart';

class ProjectState extends Equatable {
  final XFile videoFile;

  const ProjectState(
    this.videoFile,
  );

  ProjectState copyWith({
    XFile? videoFile,
  }) {
    return ProjectState(
      videoFile ?? this.videoFile,
    );
  }

  @override
  List<Object> get props => [
        videoFile,
      ];
}

final class ProjectInitial extends ProjectState {
  const ProjectInitial(
    super.videoFile,
  );
}
