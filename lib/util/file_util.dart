import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> fileFromBase64(String fileName, String base64String) async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final bytes = base64.decode(base64String);
  final file = File('${documentsDirectory.path}/$fileName');
  await file.writeAsBytes(bytes);
  return file;
}
