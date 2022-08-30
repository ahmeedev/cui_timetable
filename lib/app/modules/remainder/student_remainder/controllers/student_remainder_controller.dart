import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';
import '../../../../data/models/timetable/student_timetable/student_timetable.dart';

class StudentRemainderController extends GetxController {
  final section = Get.arguments["section"];
  var monToThursSlots = <String>[];
  var friSlots = <String>[];
  var currentTimeSlots = [];
  var notiRemainder = [].obs;

  // final days = {
  //   "10000": "Monday",
  //   "1000": "Tuesday",
  //   "100": "Wednesday",
  //   "10": "Thursday",
  //   "1": "Friday"
  // };

  final days = {"10000": 1, "1000": 2, "100": 3, "10": 4, "1": 5};
  List<StudentTimetable> sectionDetails = [];
  @override
  Future<void> onInit() async {
    final boxx = await Hive.openBox(DBNames.timeSlots);
    monToThursSlots = boxx.get(DBTimeSlots.monToThur);
    friSlots = boxx.get(DBTimeSlots.fri);
    currentTimeSlots = monToThursSlots;

    super.onInit();
  }

  // return [List] of the [StudentTimetable].
  Future<Map> getDetails() async {
    final box0 = await Hive.openBox(DBNames.remainderCache);
    notiRemainder.value = await box0.get(section, defaultValue: []);
    print(notiRemainder);
    _checkAllSet();

    final box = await Hive.openBox(DBNames.timetableData);

    List<StudentTimetable> list = sectionDetails =
        List.from(box.get(DBTimetableData.studentsData)[section.toLowerCase()]);

    final filteredData = [];
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        filteredData.add([list[i].subject, list[i].teacher]);
      } else {
        if (_checkData(value: list[i].subject, list: filteredData)) {
          filteredData.add([list[i].subject, list[i].teacher]);
        }
      }
    }
    // await Future.delayed(const Duration(seconds: 10));
    if (notiRemainder.isEmpty) {
      notiRemainder.value = List.filled(filteredData.length, 0);
    }
    return Future.value(
        {"filteredData": filteredData, "notiRemainder": notiRemainder});
  }

  /// return [bool] if the required data is available in list.
  _checkData({required String value, required List list}) {
    for (var i = 0; i < list.length; i++) {
      if (value
              .trim()
              .toLowerCase()
              .compareTo(list[i][0].trim().toLowerCase()) ==
          0) {
        return false;
      }
    }
    return true;
  }

  setRemainder({required String subject, required int index}) async {
    notiRemainder[index] = 1;
    await _cacheNotiRemainder();
    _checkAllSet();
    for (var element in sectionDetails) {
      if (element.subject.toLowerCase().compareTo(subject.toLowerCase()) == 0) {
        //  AwesomeNotifications().cancelAllSchedules();
        // log("Weekday${days[element.day.toString()]}");
        // log("Hour${days[element.day.toString()]}");
        // log("Minute${days[element.day.toString()]}");
        if (int.parse(element.day) == 5) {
          currentTimeSlots = friSlots;
        } else {
          currentTimeSlots = monToThursSlots;
        }
        String localTimeZone =
            await AwesomeNotifications().getLocalTimeZoneIdentifier();

        _parseTimeSlots(currentTimeSlots[element.slot - 1].toString())
            .then((value) {
          // log("Hour ${value['hours']}");
          // log("Minutes ${value['minutes']}");

          // AwesomeNotifications().createNotification(
          //   // actionButtons: [],
          //   // schedule: NotificationInterval(
          //   //     interval: 3, timeZone: localTimeZone),
          //   schedule: NotificationCalendar(
          //       weekday: days[element.day.toString()],
          //       hour: value['minutes'],
          //       minute: value['minutes']-2,
          //       second: 0,
          //       millisecond: 0,
          //       timeZone: localTimeZone
          //       // timeZone: localTimeZone,
          //       ),
          //   content: NotificationContent(
          //     id: channelRemainderId,
          //     channelKey: channelRemainderKey,
          //     notificationLayout: NotificationLayout.BigText,
          //     title: 'Remainder!',
          //     wakeUpScreen: true,
          //     category: NotificationCategory.Reminder,
          //     // backgroundColor: Colors.red,
          //     // color: Colors.green,
          //     summary: "Get ready for your next lecture",
          //     body:
          //         'your next lecture started at 10:00 am of Financial Accounting at A1',
          //   ),
          // );
        });
        // log(
        //     "Day ${days[element.day.toString()].toString()} Time $value"));

        // dev.log(currentTimeSlots[element.slot - 1].toString());

      }
    }
  }

  Future<Map> _parseTimeSlots(String time) {
    time = time.toLowerCase();
    // log("initial $time");
    final map = <String, int>{};
    final tokens = time.split('-');
    for (var element in tokens) {
      if (element.toString().contains('am')) {
        // log(element.toString().trim());
        final time = element.replaceAll("am", '').trim();
        // log(time);
        final hoursAndMinutes = time.split(":");
        map['hours'] = int.parse(hoursAndMinutes[0]);
        map['minutes'] = int.parse(hoursAndMinutes[1]);
        // log("am$map");
        return Future.value(map);
      } else {
        if (element.toString().contains('pm')) {
          final time = element.toString().replaceAll("pm", '').trim();
          // log(time);
          final hoursAndMinutes = time.split(":");
          map['hours'] = int.parse(hoursAndMinutes[0]) + 12;
          map['minutes'] = int.parse(hoursAndMinutes[1]);
          // log("pm$map");
          return Future.value(map);
        }
      }
    }
    return Future.value({});
    // log(tokens.toString());
  }

  revokeRemainder({required String subject, required int index}) async {
    notiRemainder[index] = 0;
    await _cacheNotiRemainder();
    _checkAllSet();
  }

  var allSet = false.obs;
  setAll() async {
    AwesomeNotifications().cancelAllSchedules();
    notiRemainder.value = List.filled(sectionDetails.length, 1);
    await _cacheNotiRemainder();
    allSet.value = true;
  }

  revokeAll() async {
    notiRemainder.value = List.filled(sectionDetails.length, 0);
    await _cacheNotiRemainder();
    allSet.value = false;
  }

  _checkAllSet() {
    if (notiRemainder.isNotEmpty) {
      bool flag = false;
      for (var element in notiRemainder) {
        if (element == 0) {
          flag = true;
          break; // means, still have something unset
        }
      }
      if (flag) {
        allSet.value = false;
      } else {
        allSet.value = true;
      }
    }
  }

  Future<void> _cacheNotiRemainder() async {
    final box0 = await Hive.openBox(DBNames.remainderCache);
    box0.put(section, notiRemainder);
  }
}
