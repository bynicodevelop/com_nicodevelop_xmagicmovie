part of 'project_delete_bloc.dart';

class ProjectDeletionState extends Equatable {
  final LoadingState loadingState;

  const ProjectDeletionState(
    this.loadingState,
  );

  ProjectDeletionState copyWith({
    LoadingState? loadingState,
  }) {
    return ProjectDeletionState(
      loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object> get props => [
        loadingState,
      ];
}

final class DeleteInitial extends ProjectDeletionState {
  const DeleteInitial({
    LoadingState loadingState = LoadingState.idle,
  }) : super(loadingState);
}
