import 'package:bloc/bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/run.dart';
import 'package:equatable/equatable.dart';

part 'run_event.dart';
part 'run_state.dart';

class RunBloc extends Bloc<RunEvent, RunState> {
  final Run _run;

  RunBloc(
    this._run,
  ) : super(RunInitialState()) {
    on<OnRunEvent>((event, emit) => _run.runEvent(event, emit, state, add));
    on<OnRunInProgress>(
        (event, emit) => _run.onRunInProgress(event, emit, state, add));
    on<OnRunSuccess>((event, emit) => _run.onRunSuccess(event, emit));
    on<OnResetEvent>((event, emit) => _run.onReset(event, emit));
  }
}
