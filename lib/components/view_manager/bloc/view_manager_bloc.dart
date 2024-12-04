import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:equatable/equatable.dart';

part 'view_manager_event.dart';
part 'view_manager_state.dart';

class ViewManagerBloc extends Bloc<ViewManagerEvent, ViewManagerState> {
  ViewManagerBloc()
      : super(const ViewManagerInitial(
          kDefaultView,
        )) {
    on<ViewManagerEvent>((event, emit) {
      emit(ViewManagerInitial(
        event.viewName,
      ));
    });
  }
}
