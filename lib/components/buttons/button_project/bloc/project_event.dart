part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  final ConfigModel config;

  const ProjectEvent(
    this.config,
  );

  @override
  List<Object> get props => [
        config,
      ];
}

final class LoadProject extends ProjectEvent {
  const LoadProject(
    super.config,
  );
}
