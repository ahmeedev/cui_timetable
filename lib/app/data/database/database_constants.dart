class DBNames {
  static const general = "general";

  static const info = "info";
  static const timeSlots = "timeSlots";

  static const timetableData = "timetableData";
  // static const studentsDB = "studentsDB";
  // static const teachersDB = "teachersDB";

  static const freerooms = "freerooms";
  static const datesheetStudentsDB = "datesheetStudentsDB";
  static const datesheetTeachersDB = "datesheetTeachersDB";

  static const history = "history";

  static const settings = "settings";

  // Cashing system //
  static const timetableCache = "timetableCache";
}

class DBGeneral {
  static const yearTokens = "yearTokens";
  static const overallTokens = "overallTokens";
  // static const sectionTokens = "sectionTokens";
  // static const sectionVariantsTokens = "sectionVariantsTokenss";
}

class DBInfo {
  static const version = "version";
  static const lastUpdate = "lastUpdate";
  // static const sections = 'sections';
  // static const teachers = 'teachers';
  static const datesheetSections = 'datesheetSections';
  static const datesheetTeachers = 'datesheetTeachers';

  static const searchComparisonTeacher = 'searchComparisonTeacher';

  static const datesheetSearchSection = 'datesheetSearchSection';
  static const datesheetSearchTeacher = 'datesheetSearchTeacher';

  static const newUser = 'newUser';
  static const news = 'news';
}

class DBTimetableData {
  static const sections = "sections";
  static const teachers = "teachers";

  static const studentsData = "studentsData";
  static const teachersData = "teachersData";
}

class DBTimetableCache {
  static const studentSection = 'studentSection';

  static const studentYearToken = 'studentYearToken';
  static const studentSecToken = 'studentSecToken';
  static const studentSecVToken = 'studentSecVToken';

  static const studentHistory = "studentHistory";

  static const teacherName = 'teacherName';
  static const teacherHistory = "teacherHistory";
}

class DBTimeSlots {
  static const monToThur = 'monToThur';
  static const fri = 'fri';
}

class DBFreerooms {
  static const monday = 'monday';
  static const tuesday = 'tuesday';
  static const wednesday = 'wednesday';
  static const thursday = 'thursday';
  static const friday = 'friday';
}

class DBHistory {
  static const studentTimetable = 'studentTimetable';
  static const teacherTimetable = 'teacherTimetable';
}

class DBSettings {
  static const searchBy = 'searchBy';

  static const darkMode = 'darkMode';

  static const carousel = 'carousel';
  static const latestNews = 'latestNews';
}
