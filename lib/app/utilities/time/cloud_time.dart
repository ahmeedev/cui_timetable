import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/main.dart';
import 'package:dio/dio.dart';

currentTime() async {
  try {
    final options = BaseOptions(
      // baseUrl: '',
      followRedirects: false,
    );
    var response = await Dio(options)
        .get('http://worldtimeapi.org/api/timezone/Asia/Karachi');
    // final dateTime = DateTime.parse(response.data['datetime']);

    final result = response.data['datetime'].toString().replaceAll("T", " ");
    var pos = result.lastIndexOf('+');
    final parsed = result.substring(0, pos);
    logger.i(parsed);
    return DateTime.parse(parsed);
    // logger.i(DateTime.now());
  } catch (e) {
    logger.e(e);
    GetXUtilities.snackbar(
        title: 'Error!',
        message: "Too many requests. Please try again later",
        // message: "$e",
        gradient: errorGradient);
  }
  // return DateTime.now();
}
