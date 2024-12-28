import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'zoom_event.dart';
part 'zoom_state.dart';

class ZoomBloc extends Bloc<ZoomEvent, ZoomState> {
  ZoomBloc()
      : super(const ZoomInitialState(
          value: 0,
        )) {
    on<ZoomChangedEvent>((event, emit) {
      emit(ZoomInitialState(
        value: event.value,
      ));
    });
  }
}
