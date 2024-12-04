part of 'view_manager_bloc.dart';

sealed class ViewManagerState extends Equatable {
  final String viewName;

  const ViewManagerState(
    this.viewName,
  );

  @override
  List<Object> get props => [
        viewName,
      ];
}

final class ViewManagerInitial extends ViewManagerState {
  const ViewManagerInitial(super.viewName);
}
