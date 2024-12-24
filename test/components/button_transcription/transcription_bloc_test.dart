import 'package:bloc_test/bloc_test.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_transcription/bloc/transcription_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/transcription_service.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transcription_bloc_test.mocks.dart';

@GenerateMocks([TranscriptionService, ConfigService])
void main() {
  late MockTranscriptionService mockTranscriptionService;
  late MockConfigService mockConfigService;
  late TranscriptionBloc transcriptionBloc;

  setUp(() {
    mockTranscriptionService = MockTranscriptionService();
    mockConfigService = MockConfigService();
    transcriptionBloc =
        TranscriptionBloc(mockTranscriptionService, mockConfigService);
  });

  tearDown(() {
    transcriptionBloc.close();
  });

  group('TranscriptionBloc', () {
    final config =
        ConfigModel(projectId: 'test_project', sourceFileName: 'test_file.mp4');
    final transcription = TranscriptionModel(
      text: 'Test transcription',
      words: [],
      duration: 0,
      language: null,
    );

    blocTest<TranscriptionBloc, TranscriptionState>(
      'emits [TranscriptionLoading, TranscriptionSuccess] when transcription is successful',
      build: () {
        when(mockTranscriptionService.transcribeAudioToText(any, any))
            .thenAnswer((_) async => transcription);
        when(mockConfigService.saveConfig(any)).thenAnswer((_) async => {});
        return transcriptionBloc;
      },
      act: (bloc) => bloc.add(OnTranscriptionEvent(
        videoDataModel: VideoDataModel(
          projectId: config.projectId,
          uniqueFileName: config.sourceFileName!,
          name: config.sourceFileName!,
          path: '',
          xfile: XFile(''),
          size: SizeModel(0, 0),
        ),
      )),
      expect: () => [
        TranscriptionLoading(),
        TranscriptionSuccess(),
      ],
      verify: (_) {
        verify(mockTranscriptionService.transcribeAudioToText(
                config.projectId, config.sourceFileName!))
            .called(1);
        verify(mockConfigService.saveConfig(any)).called(1);
      },
    );

    blocTest<TranscriptionBloc, TranscriptionState>(
      'emits [TranscriptionLoading, TranscriptionFailure] when transcription fails',
      build: () {
        when(mockTranscriptionService.transcribeAudioToText(any, any))
            .thenThrow(Exception('Transcription failed'));
        return transcriptionBloc;
      },
      act: (bloc) => bloc.add(OnTranscriptionEvent(
        videoDataModel: VideoDataModel(
          projectId: config.projectId,
          uniqueFileName: config.sourceFileName!,
          name: config.sourceFileName!,
          path: '',
          xfile: XFile(''),
          size: SizeModel(0, 0),
        ),
      )),
      expect: () => [
        TranscriptionLoading(),
        const TranscriptionFailure(message: 'Exception: Transcription failed'),
      ],
      verify: (_) {
        verify(mockTranscriptionService.transcribeAudioToText(
                config.projectId, config.sourceFileName!))
            .called(1);
      },
    );

    blocTest<TranscriptionBloc, TranscriptionState>(
      'emits [TranscriptionLoading, TranscriptionFailure] when saving config fails',
      build: () {
        when(mockTranscriptionService.transcribeAudioToText(any, any))
            .thenAnswer((_) async => transcription);
        when(mockConfigService.saveConfig(any))
            .thenThrow(Exception('Save config failed'));
        return transcriptionBloc;
      },
      act: (bloc) => bloc.add(OnTranscriptionEvent(
        videoDataModel: VideoDataModel(
          projectId: config.projectId,
          uniqueFileName: config.sourceFileName!,
          name: config.sourceFileName!,
          path: '',
          xfile: XFile(''),
          size: SizeModel(0, 0),
        ),
      )),
      expect: () => [
        TranscriptionLoading(),
        const TranscriptionFailure(message: 'Exception: Save config failed'),
      ],
      verify: (_) {
        verify(mockTranscriptionService.transcribeAudioToText(
                config.projectId, config.sourceFileName!))
            .called(1);
        verify(mockConfigService.saveConfig(any)).called(1);
      },
    );
  });
}
