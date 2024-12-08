import 'dart:convert';
import 'dart:io';

import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:cross_file/cross_file.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  Future<Directory> getWorkingDirectory() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    final Directory workingDir = Directory(
      '${appDocDir.path}/$kWorkDir',
    );

    if (!await workingDir.exists()) {
      await workingDir.create(recursive: true);
    }

    return workingDir;
  }

  String getFileName(XFile file) {
    return file.path.split('/').last;
  }

  Future<Map<String, String>> generateUniqueFileName(XFile file) async {
    final String extension = file.path.split('.').last;

    final bytes = await file.readAsBytes();
    final hash = md5.convert(bytes);

    return {
      'hash': hash.toString(),
      'extension': extension,
      'fileName': '$hash.$extension',
    };
  }

  Future<String> getFilePath(String fileName) async {
    final Directory workingDir = await getWorkingDirectory();
    return '${workingDir.path}/$fileName';
  }

  Future<void> saveJsonFile(
    String path,
    String fileName,
    Map<String, dynamic> data,
  ) async {
    final File file = File('$path/$fileName');
    final String jsonString = jsonEncode(data);
    await file.writeAsString(jsonString, flush: true);
  }
}
