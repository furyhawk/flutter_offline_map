import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  if (directory.path == '') {
    throw MissingPlatformDirectoryException(
      'Unable to get documents directory',
    );
  }
  return directory;
}
