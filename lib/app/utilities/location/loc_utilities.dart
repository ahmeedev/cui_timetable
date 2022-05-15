import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LocationUtilities {
  static late String defaultpath = '';

  static Future<void> initialize() async {
    if (!kIsWeb) {
      final location = await getApplicationDocumentsDirectory();
      defaultpath = location.path;
    }
  }
}
