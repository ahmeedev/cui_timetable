// Flutter imports:
import 'package:flutter/foundation.dart' show kIsWeb;

// Package imports:
import 'package:path_provider/path_provider.dart';

class LocationUtilities {
  static String defaultpath = '';

  static Future<void> initialize() async {
    if (!kIsWeb) {
      final location = await getApplicationDocumentsDirectory();
      defaultpath = location.path;
    }
  }
}
