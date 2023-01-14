import 'package:cui_timetable/app/modules/home/views/home_view2.dart';
import 'package:get/get.dart';

import '../modules/adminPanel/adminFeedback/bindings/admin_feedback_binding.dart';
import '../modules/adminPanel/adminFeedback/views/admin_feedback_view.dart';
import '../modules/adminPanel/adminNotifications/bindings/admin_notifications_binding.dart';
import '../modules/adminPanel/adminNotifications/views/admin_notifications_view.dart';
import '../modules/adminPanel/announcement/bindings/announcement_binding.dart';
import '../modules/adminPanel/announcement/views/announcement_view.dart';
import '../modules/adminPanel/bindings/admin_panel_binding.dart';
import '../modules/adminPanel/bookingRequest/bindings/booking_request_binding.dart';
import '../modules/adminPanel/bookingRequest/views/booking_request_view.dart';
import '../modules/adminPanel/views/admin_panel_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/signIn/bindings/sign_in_binding.dart';
import '../modules/authentication/signIn/views/sign_in_view.dart';
import '../modules/authentication/signUp/bindings/sign_up_binding.dart';
import '../modules/authentication/signUp/views/sign_up_view.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/bookingApproval/bindings/booking_approval_binding.dart';
import '../modules/booking/bookingApproval/views/booking_approval_view.dart';
import '../modules/booking/bookingDate/bindings/booking_date_binding.dart';
import '../modules/booking/bookingDate/views/booking_date_view.dart';
import '../modules/booking/bookingDetails/bindings/booking_details_binding.dart';
import '../modules/booking/bookingDetails/views/booking_details_view.dart';
import '../modules/booking/bookingDetailsView/bindings/booking_details_view_binding.dart';
import '../modules/booking/bookingDetailsView/views/booking_details_view_view.dart';
import '../modules/booking/bookingInfo/bindings/booking_info_binding.dart';
import '../modules/booking/bookingInfo/views/booking_info_view.dart';
import '../modules/booking/bookingRoom/bindings/booking_room_binding.dart';
import '../modules/booking/bookingRoom/views/booking_room_view.dart';
import '../modules/booking/cancelBooking/bindings/cancel_booking_binding.dart';
import '../modules/booking/cancelBooking/views/cancel_booking_view.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/comparison/bindings/comparision_binding.dart';
import '../modules/comparison/sec_sec/bindings/sec_sec_binding.dart';
import '../modules/comparison/sec_sec/views/sec_sec_view.dart';
import '../modules/comparison/teac_sect/bindings/teac_sect_binding.dart';
import '../modules/comparison/teac_sect/views/teac_sect_view.dart';
import '../modules/comparison/teac_teac/bindings/teac_teac_binding.dart';
import '../modules/comparison/teac_teac/views/teac_teac_view.dart';
import '../modules/comparison/views/comparison_view.dart';
import '../modules/contributions/bindings/contributions_binding.dart';
import '../modules/contributions/views/contributions_view.dart';
import '../modules/datesheet/bindings/datesheet_binding.dart';
import '../modules/datesheet/student_datesheet/bindings/student_datesheet_binding.dart';
import '../modules/datesheet/student_datesheet/views/student_datesheet_view.dart';
import '../modules/datesheet/teacher_datesheet/bindings/teacher_datesheet_binding.dart';
import '../modules/datesheet/teacher_datesheet/views/teacher_datesheet_view.dart';
import '../modules/datesheet/views/datesheet_view.dart';
import '../modules/freerooms/bindings/freerooms_binding.dart';
import '../modules/freerooms/views/freerooms_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/home_view3.dart';
import '../modules/location/bindings/location_binding.dart';
import '../modules/location/views/location_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_view.dart';
import '../modules/pages/about_us/about_us_view.dart';
import '../modules/pages/director_vision/director_vision.dart';
import '../modules/pages/news/news.dart';
import '../modules/portals/bindings/portals_binding.dart';
import '../modules/portals/views/portals_view.dart';
import '../modules/remainder/bindings/remainder_binding.dart';
import '../modules/remainder/student_remainder/bindings/student_remainder_binding.dart';
import '../modules/remainder/student_remainder/views/student_remainder_view.dart';
import '../modules/remainder/views/remainder_view.dart';
import '../modules/reports/bindings/reports_binding.dart';
import '../modules/reports/newReport/bindings/new_report_binding.dart';
import '../modules/reports/newReport/views/new_report_view.dart';
import '../modules/reports/views/reports_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view2.dart';
import '../modules/socities/bindings/socities_binding.dart';
import '../modules/socities/views/socities_view.dart';
import '../modules/sync/bindings/sync_binding.dart';
import '../modules/sync/views/sync_view.dart';
import '../modules/timetable/bindings/timetable_binding.dart';
import '../modules/timetable/student_timetable/bindings/student_timetable_binding.dart';
import '../modules/timetable/student_timetable/views/student_timetable_view.dart';
import '../modules/timetable/teacher_timetable/bindings/teacher_timetable_binding.dart';
import '../modules/timetable/teacher_timetable/views/teacher_timetable_view.dart';
import '../modules/timetable/views/timetable_view.dart';
import '../modules/transport/bindings/transport_binding.dart';
import '../modules/transport/views/transport_view.dart';

// import '../modules/signin/bindings/signin_binding.dart';
// import '../modules/signin/views/signin_view.dart';

// Package imports:

// Project imports:

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
    ),
    GetPage(
      name: _Paths.DIRECTOR_VISION,
      page: () => const DirectorVisionView(),
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => const News(),
      children: [
        GetPage(
          name: _Paths.NEWS,
          page: () => const NewsView(),
          binding: NewsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.TIMETABLE,
      page: () => TimetableView(),
      binding: TimetableBinding(),
      children: [
        GetPage(
          name: _Paths.STUDENT_TIMETABLE,
          page: () => StudentTimetableView(),
          binding: StudentTimetableBinding(),
        ),
        GetPage(
          name: _Paths.TEACHER_TIMETABLE,
          page: () => TeacherTimetableView(),
          binding: TeacherTimetableBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SYNC,
      page: () => const SyncView(),
      binding: SyncBinding(),
    ),
    GetPage(
      name: _Paths.FREEROOMS,
      page: () => FreeroomsView(),
      binding: FreeroomsBinding(),
    ),
    GetPage(
      name: _Paths.PORTALS,
      page: () => const PortalsView(),
      binding: PortalsBinding(),
    ),
    GetPage(
      name: _Paths.DATESHEET,
      page: () => const DatesheetView(),
      binding: DatesheetBinding(),
      children: [
        GetPage(
          name: _Paths.STUDENT_DATESHEET,
          page: () => StudentDatesheetView(),
          binding: StudentDatesheetBinding(),
        ),
        GetPage(
          name: _Paths.TEACHER_DATESHEET,
          page: () => TeacherDatesheetView(),
          binding: TeacherDatesheetBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.REMAINDER,
      page: () => const RemainderView(),
      binding: RemainderBinding(),
      children: [
        GetPage(
          name: _Paths.STUDENT_REMAINDER,
          page: () => const StudentRemainderView(),
          binding: StudentRemainderBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView2(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
      children: [
        GetPage(
          name: _Paths.SIGN_IN,
          page: () => const SignInView(),
          binding: SignInBinding(),
        ),
        GetPage(
          name: _Paths.SIGN_UP,
          page: () => const SignUpView(),
          binding: SignUpBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.COMPARISON,
        page: () => ComparisonView(),
        binding: ComparisionBinding(),
        children: [
          GetPage(
            name: _Paths.SEC_SEC,
            page: () => const SecSecView(),
            binding: SecSecBinding(),
          ),
          GetPage(
            name: _Paths.TEAC_SECT,
            page: () => const TeacSectView(),
            binding: TeacSectBinding(),
          ),
          GetPage(
            name: _Paths.TEAC_TEAC,
            page: () => const TeacTeacView(),
            binding: TeacTeacBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.TRANSPORT,
      page: () => const TransportView(),
      binding: TransportBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
      children: [
        GetPage(
          name: _Paths.BOOKING_DETAILS,
          page: () => const BookingDetailsView(),
          binding: BookingDetailsBinding(),
        ),
        GetPage(
          name: _Paths.BOOKING_INFO,
          page: () => const BookingInfoView(),
          binding: BookingInfoBinding(),
        ),
        GetPage(
          name: _Paths.BOOKING_ROOM,
          page: () => const BookingRoomView(),
          binding: BookingRoomBinding(),
        ),
        GetPage(
          name: _Paths.BOOKING_DETAILS_VIEW,
          page: () => const BookingDetailsViewView(),
          binding: BookingDetailsViewBinding(),
        ),
        GetPage(
          name: _Paths.CANCEL_BOOKING,
          page: () => const CancelBookingView(),
          binding: CancelBookingBinding(),
        ),
        GetPage(
          name: _Paths.BOOKING_APPROVAL,
          page: () => const BookingApprovalView(),
          binding: BookingApprovalBinding(),
        ),
        GetPage(
          name: _Paths.BOOKING_DATE,
          page: () => const BookingDateView(),
          binding: BookingDateBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => const LocationView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => const ReportsView(),
      binding: ReportsBinding(),
      children: [
        GetPage(
          name: _Paths.NEW_REPORT,
          page: () => const NewReportView(),
          binding: NewReportBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ADMIN_PANEL,
      page: () => const AdminPanelView(),
      binding: AdminPanelBinding(),
      children: [
        GetPage(
          name: _Paths.ANNOUNCEMENT,
          page: () => const AnnouncementView(),
          binding: AnnouncementBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN_FEEDBACK,
          page: () => const AdminFeedbackView(),
          binding: AdminFeedbackBinding(),
        ),
        GetPage(
          name: _Paths.BOOKING_REQUEST,
          page: () => const BookingRequestView(),
          binding: BookingRequestBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN_NOTIFICATIONS,
          page: () => const AdminNotificationsView(),
          binding: AdminNotificationsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SOCITIES,
      page: () => const SocitiesView(),
      binding: SocitiesBinding(),
    ),
    GetPage(
      name: _Paths.CONTRIBUTIONS,
      page: () => const ContributionsView(),
      binding: ContributionsBinding(),
    ),
  ];
}
