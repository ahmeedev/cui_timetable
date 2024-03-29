// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:developer';

import 'package:cui_timetable/app/utilities/extensions.dart';
import 'package:dart_date/dart_date.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../data/database/database_constants.dart';
import '../../../../data/models/timetable/student_timetable/student_timetable.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/get_widgets.dart';

class StudentRemainderController extends GetxController {
  final section = Get.arguments["section"];
  var monToThursSlots = <String>[];
  var friSlots = <String>[];
  var currentTimeSlots = [];
  final filteredData = [];
  var notiRemainder = [].obs;

  var absorbing = false.obs;
  late final Future<Map> future;
  var futureStatus = false.obs;
//   // final days = {
//   //   "10000": "Monday",
//   //   "1000": "Tuesday",
//   //   "100": "Wednesday",
//   //   "10": "Thursday",
//   //   "1": "Friday"
//   // };

  final days = {"10000": 1, "1000": 2, "100": 3, "10": 4, "1": 5};
  List<StudentTimetable> sectionDetails = [];
  // late final Box remainderBox;
  late final Box remainderCacheBox;

  late final DateTime startdate;
  late final DateTime lastDate;
  late final int dateDiff;
  @override
  Future<void> onInit() async {
    final boxx = await Hive.openBox(DBNames.timeSlots);
    // remainderBox = await Hive.openBox(DBNames.remainder);
    remainderCacheBox = await Hive.openBox(DBNames.remainderCache);
    monToThursSlots = boxx.get(DBTimeSlots.monToThur);
    friSlots = boxx.get(DBTimeSlots.fri);
    currentTimeSlots = monToThursSlots;

    future = getDetails();
    futureStatus.value = true;

    // set start and last date.
    startdate = DateTime.now();
    lastDate = DateTime.now().add(const Duration(days: 7));
    dateDiff = lastDate.difference(startdate).inDays;
    // print(lastDate.difference(startdate).inDays);
    super.onInit();
  }

  // return [List] of the [StudentTimetable].
  Future<Map> getDetails() async {
    // final box0 = await Hive.openBox(DBNames.remainderCache);
    notiRemainder.value =
        await remainderCacheBox.get(section, defaultValue: []);
    // box0.clear();

    _checkAllSet();

    final box = await Hive.openBox(DBNames.timetableData);

    List<StudentTimetable> list = sectionDetails =
        List.from(box.get(DBTimetableData.studentsData)[section.toLowerCase()]);

    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        filteredData.add([list[i].subject, list[i].teacher]);
      } else {
        if (_checkData(value: list[i].subject, list: filteredData)) {
          filteredData.add([list[i].subject, list[i].teacher]);
          filteredData.sort(
            (a, b) => a[0].compareTo(b[0]),
          );
        }
      }
    }
    // await Future.delayed(const Duration(seconds: 10));
    if (notiRemainder.isEmpty) {
      notiRemainder.value = List.filled(filteredData.length, 0);
    }

    final labs = [];
    var actualTileIndexes = [];
    list.sort((a, b) => a.day.compareTo(b.day));
    // list2.contains(2);
    for (var i = 0; i < list.length; i++) {
      if (i != list.length - 1) {
        if (list[i].subject == list[i + 1].subject &&
            list[i].teacher == list[i + 1].teacher) {
          labs.add(i);
          actualTileIndexes.add(i);
          labs.add(i + 1);
        }
      }
    }
    // log(labs.toString());
    // log(actualTileIndexes.toString());
    // remove the labs from the list
    for (var element in actualTileIndexes) {
      list.removeAt(element);
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

  DateTime? findRespDates(element) {
    // final dates = [];
    DateTime? currentDay;
    final lecDay = days[element.day.toString()];
    switch (lecDay) {
      case 1:
        currentDay = startdate.next(1);
        break;
      case 2:
        currentDay = startdate.next(2);
        break;
      case 3:
        currentDay = startdate.next(3);
        break;
      case 4:
        currentDay = startdate.next(4);
        break;
      case 5:
        currentDay = startdate.next(5);
        break;
      default:
        currentDay = null;
    }
    return currentDay;
// log(days[element.day.toString()].toString());
    // for (var i = 0; i < dateDiff; i++) {
    //   if(startdate.nextDay.)
    // }
  }

  setRemainder({required String subject, required int index}) async {
    absorbing.value = true;
    // log("pressed");
    // await Future.delayed(const Duration(seconds: 2));

    notiRemainder[index] = 1;
    await _cacheNotiRemainder();
    _checkAllSet();
    for (var element in sectionDetails) {
      if (element.subject.toLowerCase().compareTo(subject.toLowerCase()) == 0) {
        // log(findRespDates(element).toString());

        //  AwesomeNotifications().cancelAllSchedules();
        // log("Weekday${days[element.day.toString()]}");
        // log("Hour${days[element.day.toString()]}");
        // log("Minute${days[element.day.toString()]}");
        if (int.parse(element.day) == 5) {
          currentTimeSlots = friSlots;
        } else {
          currentTimeSlots = monToThursSlots;
        }

        _parseTimeSlots(currentTimeSlots[element.slot - 1].toString())
            .then((value) {
          // log("Hour ${value['hours']}");
          // log("Minutes ${value['minutes']}");
          final String time;
          // final int hours;
          final String minutes;
          if (value['minutes'] == 0) {
            minutes = "00";
          } else {
            minutes = value['minutes'].toString();
          }
          if (value['hours'] == 12) {
            time = "${value['hours']}:$minutes PM";
          } else if (value['hours'] > 12) {
            time = "${value['hours'] - 12}:$minutes PM";
          } else {
            time = "${value['hours']}:$minutes AM";
          }

          log('''
                  day:  ${days[element.day.toString()]},
                  hour: ${value['hours']},
                  minute: ${value['minutes'] - 2},
              ''');

          // increase the counter in db.
          final counter = remainderCacheBox.get(DBRemainderCache.totalIds,
                  defaultValue: 0) +
              1;
          remainderCacheBox.put(DBRemainderCache.totalIds, counter);
          // cache the notification channel ids.
          var channelIds = remainderCacheBox.get(
              section.toString().toLowerCase(),
              defaultValue: <String, List>{});
          channelIds = channelIds.cast<String, List>();
          if (channelIds.isEmpty) {
            channelIds[subject.toLowerCase()] = [counter];
          } else if (channelIds[subject.toLowerCase()] == null) {
            channelIds[subject.toLowerCase()] = [counter];
          } else {
            channelIds[subject.toLowerCase()]!.add(counter);
          }
          remainderCacheBox.put(section.toString().toLowerCase(), channelIds);

          // log(channelIds.toString());
          // log(days[element.day.toString()].toString());
          var date = findRespDates(element);
          var min = value['minutes'] - 2;
          date = date!.setHour(value['hours'], min, 0, 0, 0);

          log("Date is :$date");
          log("Date is :$min");

          // AwesomeNotifications().createNotification(
          //   actionButtons: [],

          //   schedule: NotificationCalendar.fromDate(date: date),

          //   content: NotificationContent(
          //     id: counter,
          //     channelKey: channelRemainderKey,

          //     summary: "Get ready for your next lecture",
          //     body:
          //         'Your next lecture started at $time  of ${element.subject} at ${element.room} with ${element.teacher}',
          //   ),
          // );
        });

        // log(
        //     "Day ${days[element.day.toString()].toString()} Time $value"));

        // dev.log(currentTimeSlots[element.slot - 1].toString());
      }
    }
    absorbing.value = false;
    GetXUtilities.snackbar(
        title: "Scheduling",
        message: "Your remainder set successfully!!",
        gradient: successGradient);
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
    absorbing.value = true;
    await Future.delayed(const Duration(seconds: 2));
    await _cacheNotiRemainder();
    _checkAllSet();
    absorbing.value = false;
    GetXUtilities.snackbar(
        title: "Scheduling",
        message: "Your remainder revoked successfully!!",
        gradient: errorGradient);
  }

  var allSet = false.obs;
  setAll() async {
    // first cancel all the scheuled notifications
    // AwesomeNotifications().cancelAllSchedules();

    // change the button states
    for (var i = 0; i < notiRemainder.length; i++) {
      if (notiRemainder[i] == 0) {
        notiRemainder[i] = 1;
      }
      // notiRemainder[i] = 1;
    }

    await _cacheNotiRemainder();
    allSet.value = true;
  }

  revokeAll() async {
    for (var i = 0; i < notiRemainder.length; i++) {
      notiRemainder[i] = 0;
    }
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
    // final box0 = await Hive.openBox(DBNames.remainderCache);
    remainderCacheBox.put(section, notiRemainder);
  }
}
