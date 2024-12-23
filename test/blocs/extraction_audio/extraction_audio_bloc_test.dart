import 'package:bloc_test/bloc_test.dart';
import 'package:com_nicodevelop_xmagicmovie/blocs/extraction_audio/extraction_audio_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/video_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'extraction_audio_bloc_test.mocks.dart';

@GenerateMocks([VideoManager])
void main() {
  late MockVideoManager mockVideoManager;
  late ExtractionAudioBloc extractionAudioBloc;

  setUp(() {
    mockVideoManager = MockVideoManager();
    extractionAudioBloc = ExtractionAudioBloc(mockVideoManager);
  });

  tearDown(() {
    extractionAudioBloc.close();
  });

  group('ExtractionAudioBloc', () {
    final config =
        ConfigModel(projectId: 'test_project', sourceFileName: 'test_file.mp4');

    blocTest<ExtractionAudioBloc, ExtractionAudioState>(
      'emits [ExtractionAudioLoading, ExtractionAudioSuccess] when extraction is successful',
      build: () {
        when(mockVideoManager.extractAudio(any, any))
            .thenAnswer((_) async => {});
        return extractionAudioBloc;
      },
      act: (bloc) => bloc.add(OnExtractionAudioEvent(config: config)),
      expect: () => [
        ExtractionAudioLoading(),
        ExtractionAudioSuccess(),
      ],
      verify: (_) {
        verify(mockVideoManager.extractAudio(
                config.projectId, config.sourceFileName!))
            .called(1);
      },
    );

    blocTest<ExtractionAudioBloc, ExtractionAudioState>(
      'emits [ExtractionAudioLoading, ExtractionAudioFailure] when extraction fails',
      build: () {
        when(mockVideoManager.extractAudio(any, any))
            .thenThrow(Exception('Extraction failed'));
        return extractionAudioBloc;
      },
      act: (bloc) => bloc.add(OnExtractionAudioEvent(config: config)),
      expect: () => [
        ExtractionAudioLoading(),
        ExtractionAudioFailure(),
      ],
      verify: (_) {
        verify(mockVideoManager.extractAudio(
                config.projectId, config.sourceFileName!))
            .called(1);
      },
    );
  });
}
