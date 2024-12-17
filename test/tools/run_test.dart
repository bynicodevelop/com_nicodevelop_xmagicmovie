import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:cross_file/cross_file.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/run.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'project_test.mocks.dart';

@GenerateMocks([VideoManager])
void main() {
  late MockVideoManager mockVideoManager;
  late Run run;

  setUp(() {
    mockVideoManager = MockVideoManager();
    run = Run(videoManager: mockVideoManager);
  });

  test('runEvent emits RunInitialState and OnRunInProgress', () {
    final event = OnRunEvent(
      VideoDataModel(
        path: 'path/to/video',
        size: SizeModel(1920, 1080),
        name: 'video.mp4',
        projectId: '12345',
        uniqueFileName: '12345_video.mp4',
        xfile: XFile('path/to/video'),
      ),
      SizeModel(1920, 1080),
      SizeModel(1280, 720),
      CropModel(cropX: 100, cropY: 100, cropWidth: 200, cropHeight: 200),
      CropModel(cropX: 150, cropY: 150, cropWidth: 300, cropHeight: 300),
    );
    final state = RunInitialState();
    final List<dynamic> emittedStates = [];

    void emit(dynamic newState) {
      emittedStates.add(newState);
    }

    void add(dynamic event) {
      emittedStates.add(event);
    }

    run.runEvent(event, emit, state, add);

    expect(emittedStates.length, 2);
    expect(emittedStates[0], isA<RunInitialState>());
    expect(emittedStates[1], isA<OnRunInProgress>());
  });

  test('onRunInProgress emits RunInProgressState and RunProgressUpdate',
      () async {
    final event = OnRunInProgress(
      VideoDataModel(
        path: 'path/to/video',
        size: SizeModel(1920, 1080),
        name: 'video.mp4',
        projectId: '12345',
        uniqueFileName: '12345_video.mp4',
        xfile: XFile('path/to/video'),
      ),
      SizeModel(1920, 1080),
      SizeModel(1280, 720),
      CropModel(cropX: 100, cropY: 100, cropWidth: 200, cropHeight: 200),
      CropModel(cropX: 150, cropY: 150, cropWidth: 300, cropHeight: 300),
    );
    final state = RunInitialState();
    final List<dynamic> emittedStates = [];

    void emit(dynamic newState) {
      emittedStates.add(newState);
    }

    when(mockVideoManager.cropVideo(any, any, any, any))
        .thenAnswer((_) async => 'path/to/cropped/video');

    await run.onRunInProgress(event, emit, state, (dynamic event) {
      emittedStates.add(event);
    });

    expect(emittedStates.length, 3);
    expect(emittedStates[0], isA<RunInProgressState>());
    expect(emittedStates[1], isA<RunProgressUpdate>());
    expect(emittedStates[2], isA<OnRunSuccess>());
  });

  test('onRunSuccess emits RunSuccessState', () {
    final event = OnRunSuccess(
      VideoDataModel(
        path: 'path/to/video',
        size: SizeModel(1920, 1080),
        name: 'video.mp4',
        projectId: '12345',
        uniqueFileName: '12345_video.mp4',
        xfile: XFile('path/to/video'),
      ),
      SizeModel(1920, 1080),
      SizeModel(1280, 720),
      CropModel(cropX: 100, cropY: 100, cropWidth: 200, cropHeight: 200),
      CropModel(cropX: 150, cropY: 150, cropWidth: 300, cropHeight: 300),
      'path/to/cropped/video',
    );
    final List<dynamic> emittedStates = [];

    void emit(dynamic newState) {
      emittedStates.add(newState);
    }

    run.onRunSuccess(event, emit);

    expect(emittedStates.length, 1);
    expect(emittedStates[0], isA<RunSuccessState>());
  });

  test('onReset emits RunInitialState', () {
    final event = OnResetEvent(
      VideoDataModel.empty(),
      SizeModel(0, 0),
      SizeModel(0, 0),
      CropModel(cropX: 0, cropY: 0, cropWidth: 0, cropHeight: 0),
      CropModel(cropX: 0, cropY: 0, cropWidth: 0, cropHeight: 0),
    );
    final List<dynamic> emittedStates = [];

    void emit(dynamic newState) {
      emittedStates.add(newState);
    }

    run.onReset(event, emit);

    expect(emittedStates.length, 1);
    expect(emittedStates[0], isA<RunInitialState>());
  });
}
