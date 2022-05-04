import 'package:path_provider/path_provider.dart';

class LocationUtilities {
  static late String defaultpath = '';

  static Future<void> initialize() async {
    final loc = await getApplicationDocumentsDirectory();
    defaultpath = loc.path;
  }
}
