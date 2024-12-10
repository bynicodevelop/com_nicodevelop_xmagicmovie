part of 'project_bloc.dart';

class ProjectState extends Equatable {
  final VideoDataModel videoDataModel;
  final DateTime lastUpdated;

  const ProjectState(
    this.videoDataModel,
    this.lastUpdated,
  );

  ProjectState copyWith({
    VideoDataModel? videoDataModel,
    DateTime? lastUpdated,
  }) {
    return ProjectState(
      videoDataModel ?? this.videoDataModel,
      lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object> get props => [
        videoDataModel,
        lastUpdated,
      ];
}

final class ProjectInitial extends ProjectState {
  const ProjectInitial(
    super.videoDataModel,
    super.lastUpdated,
  );
}
