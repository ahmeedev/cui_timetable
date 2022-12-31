import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:cui_timetable/main.dart';
import 'package:dio/dio.dart';

Future<DateTime> currentTime() async {
  final options = BaseOptions(
    // baseUrl: '',
    followRedirects: false,
  );
  try {
    var response = await Dio(options).get(
        'https://www.timeapi.io/api/Time/current/zone?timeZone=Asia/Karachi');
    // .get('http://worldtimeapi.org/api/timezone/Asia/Karachi');
    // final dateTime = DateTime.parse(response.data['datetime']);
    // final response = await http
    //     .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Karachi'));
    // final data = jsonDecode(response.body);
    final result = response.data['dateTime'].toString().replaceAll("T", " ");
    // var pos = result.lastIndexOf('+');
    var pos = result.lastIndexOf('.');
    final parsed = result.substring(0, pos);
    logger.i(parsed);
    return Future.value(DateTime.parse(parsed));
  } catch (e) {
    logger.e(e);
    GetXUtilities.snackbar(
        title: 'Error!',
        message: "Too many requests. Please try again later",
        // message: "$e",
        gradient: errorGradient);
    return Future.error("Too many requests. Please try again later");
  }
  // return DateTime.now();
}
