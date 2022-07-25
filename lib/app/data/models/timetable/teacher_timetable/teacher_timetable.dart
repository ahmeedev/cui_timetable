import 'package:hive_flutter/adapters.dart';
part 'teacher_timetable.g.dart';

@HiveType(typeId: 2)
class TeacherTimetable {
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

  TeacherTimetable(
      {required this.section,
      required this.subject,
      required this.slot,
      required this.day,
      required this.teacher,
      required this.room});
}
