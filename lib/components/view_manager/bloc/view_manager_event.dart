part of 'view_manager_bloc.dart';

class ViewManagerEvent extends Equatable {
  final String viewName;

  const ViewManagerEvent(
    this.viewName,
  );

  @override
  List<Object> get props => [
        viewName,
      ];
}
