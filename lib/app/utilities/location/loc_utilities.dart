import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:path_provider/path_provider.dart';

// Flutter imports:

// Package imports:

class LocationUtilities {
  static String defaultpath = '';

  static Future<void> initialize() async {
    if (!kIsWeb) {
      final location = await getApplicationDocumentsDirectory();
      defaultpath = location.path;
    }
  }
}
