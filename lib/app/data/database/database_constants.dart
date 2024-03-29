class DBNames {
  static const general = "general";

  static const info = "info";
  static const timeSlots = "timeSlots";

  static const timetableData = "timetableData";

  static const freerooms = "freerooms";
  static const datesheetStudentsDB = "datesheetStudentsDB";
  static const datesheetTeachersDB = "datesheetTeachersDB";

  static const portals = "portals";

  static const history = "history";

  static const settings = "settings";

  static const remainder = "remainder";

  // Cashing system //
  static const timetableCache = "timetableCache";
  static const remainderCache = "remainderCache";
  static const authCache = 'authCache';
  static const comparisonCache = 'comparisonCache';
  static const bookingCache = 'bookingCache';
}

class DBInfo {
  static const version = "version";
  static const lastUpdate = "lastUpdate";
  // static const sections = 'sections';
  // static const teachers = 'teachers';
  static const datesheetSections = 'datesheetSections';
  static const datesheetTeachers = 'datesheetTeachers';

  // static const searchComparisonTeacher = 'searchComparisonTeacher';

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

  static const overallTokens = "overallTokens";
  static const yearTokens = "yearTokens";
  static const sectionTokens = "sectionTokens";
  static const sectionVariantsTokens = "sectionVariantsTokens";
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
  static const cloudNoti = 'cloudNoti';

  static const darkMode = 'darkMode';

  static const carousel = 'carousel';
  static const latestNews = 'latestNews';
}

class DBPortals {
  static const studentData = "studentData";
  static const teacherData = "teacherData";
}

class DBRemainder {}

class DBRemainderCache {
  static const studentSection = 'section';
  static const teacherName = 'teacher';

  static const sectionHistory = "sectionHistory";
  static const sectionNotiRemainder = "sectionNotiRemainder";

  static const totalIds = "totalIds";

  // dynamically ids are stored w.r.t to the cache section.

}

class DBAuthCache {
  static const isRememberSignIn = 'isRememberSignIn';

  static const isSignIn = 'isSignIn';

  static const signInEmail = 'signInEmail';
  static const signInPass = 'signInPass';

  static const sectionName = 'sectionName';
}

class DBComparisonCache {
  static const section1 = 'section1';
  static const section2 = 'section2';

  static const searchTeacher = "searchTeacher";

  static const teacher1 = 'teacher1';
  static const teacher2 = 'teacher2';
}

class DBBookingCache {
  static const searchTeacher = "searchTeacher";
}
