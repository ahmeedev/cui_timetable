final String tableTimetable = 'timetable';

class TimeTableFields {
  static final String id = '_id';
  static final String section = 'section';
  static final String subject = 'subject';
  static final String slot = 'slot';
  static final String day = 'day';
  static final String teacher = 'teacher';
  static final String room = 'room';
}

class TimeTable {
  final int? id;
  final String section;
  final String subject;
  final int slot;
  final String day;
  final String teacher;
  final String room;

  const TimeTable({
    this.id,
    required this.section,
    required this.subject,
    required this.slot,
    required this.day,
    required this.teacher,
    required this.room,
  });
}
