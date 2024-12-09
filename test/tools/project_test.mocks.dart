// Mocks generated by Mockito 5.4.4 from annotations
// in com_nicodevelop_xmagicmovie/test/tools/project_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i2;

import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart' as _i8;
import 'package:com_nicodevelop_xmagicmovie/services/config_service.dart'
    as _i7;
import 'package:com_nicodevelop_xmagicmovie/services/file_manager.dart' as _i3;
import 'package:cross_file/cross_file.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDirectory_0 extends _i1.SmartFake implements _i2.Directory {
  _FakeDirectory_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFileManager_1 extends _i1.SmartFake implements _i3.FileManager {
  _FakeFileManager_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FileManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockFileManager extends _i1.Mock implements _i3.FileManager {
  MockFileManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Directory> getWorkingDirectory() => (super.noSuchMethod(
        Invocation.method(
          #getWorkingDirectory,
          [],
        ),
        returnValue: _i4.Future<_i2.Directory>.value(_FakeDirectory_0(
          this,
          Invocation.method(
            #getWorkingDirectory,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Directory>);

  @override
  String getFileName(_i5.XFile? file) => (super.noSuchMethod(
        Invocation.method(
          #getFileName,
          [file],
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #getFileName,
            [file],
          ),
        ),
      ) as String);

  @override
  _i4.Future<Map<String, String>> generateUniqueFileName(_i5.XFile? file) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateUniqueFileName,
          [file],
        ),
        returnValue: _i4.Future<Map<String, String>>.value(<String, String>{}),
      ) as _i4.Future<Map<String, String>>);

  @override
  _i4.Future<String> getFilePath(
    String? projectId,
    String? fileName,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFilePath,
          [
            projectId,
            fileName,
          ],
        ),
        returnValue: _i4.Future<String>.value(_i6.dummyValue<String>(
          this,
          Invocation.method(
            #getFilePath,
            [
              projectId,
              fileName,
            ],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<void> saveJsonFile(
    String? path,
    String? fileName,
    Map<String, dynamic>? data,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveJsonFile,
          [
            path,
            fileName,
            data,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<Map<String, dynamic>> readJsonFile(String? path) =>
      (super.noSuchMethod(
        Invocation.method(
          #readJsonFile,
          [path],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<void> deleteDirectory(String? path) => (super.noSuchMethod(
        Invocation.method(
          #deleteDirectory,
          [path],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [ConfigService].
///
/// See the documentation for Mockito's code generation for more information.
class MockConfigService extends _i1.Mock implements _i7.ConfigService {
  MockConfigService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.FileManager get fileManager => (super.noSuchMethod(
        Invocation.getter(#fileManager),
        returnValue: _FakeFileManager_1(
          this,
          Invocation.getter(#fileManager),
        ),
      ) as _i3.FileManager);

  @override
  _i4.Future<List<_i8.ConfigModel>> loadConfigs() => (super.noSuchMethod(
        Invocation.method(
          #loadConfigs,
          [],
        ),
        returnValue:
            _i4.Future<List<_i8.ConfigModel>>.value(<_i8.ConfigModel>[]),
      ) as _i4.Future<List<_i8.ConfigModel>>);

  @override
  _i4.Future<void> saveConfig(_i8.ConfigModel? config) => (super.noSuchMethod(
        Invocation.method(
          #saveConfig,
          [config],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
