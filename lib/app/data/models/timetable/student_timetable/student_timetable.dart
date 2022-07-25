import 'package:hive/hive.dart';

part 'student_timetable.g.dart';

@HiveType(typeId: 1)
class StudentTimetable {
  @HiveField(0)
  final String section;
  @HiveField(1)
  final String subject;
  @HiveField(2)
  final int slot;
  @HiveField(3)
  final String day;
  @HiveField(4)
  final String teacher;
  @HiveField(5)
  final String room;

  StudentTimetable(
      {required this.section,
      required this.subject,
      required this.slot,
      required this.day,
      required this.teacher,
      required this.room});
}
