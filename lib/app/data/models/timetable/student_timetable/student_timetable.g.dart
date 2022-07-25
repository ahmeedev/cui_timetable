// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_timetable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentTimetableAdapter extends TypeAdapter<StudentTimetable> {
  @override
  final int typeId = 1;

  @override
  StudentTimetable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentTimetable(
      section: fields[0] as String,
      subject: fields[1] as String,
      slot: fields[2] as int,
      day: fields[3] as String,
      teacher: fields[4] as String,
      room: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentTimetable obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.section)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.slot)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.teacher)
      ..writeByte(5)
      ..write(obj.room);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentTimetableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
