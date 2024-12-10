import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart';
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/project.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/bloc/project_delete_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'project_test.mocks.dart';
import 'package:cross_file/cross_file.dart';

class MockEvent {
  final MockConfig config;

  MockEvent(this.config);
}

class MockConfig {
  final String projectId;
  final String sourceFileName;

  MockConfig(this.projectId, this.sourceFileName);
}

class MockState {
  final XFile? videoFile;
  final List<ConfigModel>? projects;
  final LoadingState loadingState;

  MockState({this.videoFile, this.projects, this.loadingState = LoadingState.idle});

  MockState copyWith({XFile? videoFile, List<ConfigModel>? projects, LoadingState? loadingState}) {
    return MockState(
      videoFile: videoFile ?? this.videoFile,
      projects: projects ?? this.projects,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

@GenerateMocks([FileManager, ConfigService])
void main() {
  late MockFileManager mockFileManager;
  late MockConfigService mockConfigService;
  late Project project;

  setUp(() {
    mockFileManager = MockFileManager();
    mockConfigService = MockConfigService();
    project = Project(mockFileManager, mockConfigService);
  });

  test('loadProjects emits loading state and then loaded state with ConfigModel projects', () async {
    // Arrange
    final List<ConfigModel> mockProjects = [
      ConfigModel(projectId: '1', sourceFileName: 'video1.mp4'),
      ConfigModel(projectId: '2', sourceFileName: 'video2.mp4'),
    ];

    final initialState = MockState();
    MockState? emittedState;

    // Stub du ConfigService pour retourner une liste de ConfigModel
    when(mockConfigService.loadConfigs()).thenAnswer((_) async => mockProjects);

    void emit(MockState state) {
      emittedState = state;
    }

    // Act
    await project.loadProjects(null, emit, initialState);

    // Assert
    expect(emittedState?.loadingState, equals(LoadingState.loaded));
    expect(emittedState?.projects, equals(mockProjects));
    verify(mockConfigService.loadConfigs()).called(1);
  });


  test('loadProjects emits loading state and then loaded state with ConfigModel projects', () async {
    // Arrange
    final List<ConfigModel> mockProjects = [
      ConfigModel(projectId: '1', sourceFileName: 'video1.mp4'),
      ConfigModel(projectId: '2', sourceFileName: 'video2.mp4'),
    ];

    final initialState = MockState();
    MockState? emittedState;

    // Stub du ConfigService pour retourner une liste de ConfigModel
    when(mockConfigService.loadConfigs()).thenAnswer((_) async => mockProjects);

    void emit(MockState state) {
      emittedState = state;
    }

    // Act
    await project.loadProjects(null, emit, initialState);

    // Assert
    expect(emittedState?.loadingState, equals(LoadingState.loaded));
    expect(emittedState?.projects, equals(mockProjects));
    verify(mockConfigService.loadConfigs()).called(1);
  });


  test('loadProject handles exception when FileManager fails', () async {
    // Arrange
    const String mockProjectId = '123';
    const String mockSourceFileName = 'video.mp4';
    final event = MockEvent(MockConfig(mockProjectId, mockSourceFileName));
    final initialState = MockState();
    MockState? emittedState;

    // Stub du FileManager pour lancer une exception
    when(mockFileManager.getFilePath(mockProjectId, mockSourceFileName))
        .thenThrow(Exception('File not found'));

    void emit(MockState state) {
      emittedState = state;
    }

    // Act
    await project.loadProject(event, emit, initialState);

    // Assert
    expect(emittedState?.videoFile, isNull);
    verify(mockFileManager.getFilePath(mockProjectId, mockSourceFileName)).called(1);
  });

  test('deleteProject emits loading state and then loaded state when deletion succeeds', () async {
  // Arrange
  const String mockProjectId = '123';
  const event = OnDeleteProject(mockProjectId);
  final initialState = MockState();
  MockState? emittedState;

  // Stub du FileManager pour simuler une suppression réussie
  when(mockFileManager.deleteDirectory(mockProjectId)).thenAnswer((_) async => Future.value());

  void emit(MockState state) {
    emittedState = state;
  }

  // Act
  await project.deleteProject(event, emit, initialState);

  // Assert
  expect(emittedState?.loadingState, equals(LoadingState.loaded));
  verify(mockFileManager.deleteDirectory(mockProjectId)).called(1);
});

test('deleteProject emits loading state and then error state when deletion fails', () async {
  // Arrange
  const String mockProjectId = '123';
  const event = OnDeleteProject(mockProjectId);
  final initialState = MockState();
  MockState? emittedState;

  // Stub du FileManager pour lancer une exception
  when(mockFileManager.deleteDirectory(mockProjectId)).thenThrow(Exception('Deletion failed'));

  void emit(MockState state) {
    emittedState = state;
  }

  // Act
  await project.deleteProject(event, emit, initialState);

  // Assert
  expect(emittedState?.loadingState, equals(LoadingState.error));
  verify(mockFileManager.deleteDirectory(mockProjectId)).called(1);
});

}
