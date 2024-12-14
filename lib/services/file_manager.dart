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

  String replaceFileExtension(
    String path,
    String newExtension,
  ) {
    final parts = path.split('.');
    parts[parts.length - 1] = newExtension;
    return parts.join('.');
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

  Future<String> getFilePath(
    String projectId,
    String fileName,
  ) async {
    final Directory workingDir = await getWorkingDirectory();
    return '${workingDir.path}/$projectId/$fileName';
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

  Future<Map<String, dynamic>> readJsonFile(String path) async {
    final File file = File(path);

    final String jsonString = await file.readAsString();
    return jsonDecode(jsonString);
  }

  Future<void> deleteDirectory(
    String path,
  ) async {
    final Directory workingDir = await getWorkingDirectory();
    final Directory dir = Directory('${workingDir.path}/$path');

    await dir.delete(
      recursive: true,
    );
  }
}
