import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loader_event.dart';
part 'loader_state.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {
  LoaderBloc() : super(LoaderIdleState()) {
    on<LoaderIdleEvent>((event, emit) => emit(LoaderIdleState()));
    on<LoaderInProgressEvent>((event, emit) => emit(LoaderInProgressState()));
  }
}
