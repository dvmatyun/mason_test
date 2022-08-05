import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) async {
  final workingDirectory = "${Directory.current.path}";

  final files = Directory.current.listSync();

  //final toDelete = Directory('path');
  //Directory.current.deleteSync()

  final process = await Process.start(
    'dir',
    [],
    workingDirectory: workingDirectory,
    runInShell: true,
  );

  print('START');
  process.stdout.transform(utf8.decoder).forEach((e) {
    print('FILE: $e');
  });
}
