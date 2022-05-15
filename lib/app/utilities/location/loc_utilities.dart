import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LocationUtilities {
  static late String defaultpath = '';

  static Future<void> initialize() async {
    late final Object loc;
    if (kIsWeb) {
      loc = '';
    } else {
      loc = await getApplicationDocumentsDirectory();
      defaultpath = loc.toString();
    }
  }
}
