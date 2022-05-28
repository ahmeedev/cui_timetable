import 'package:get/get.dart';

import '../models/timetable_model.dart';

class TimetableProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Timetable.fromJson(map);
      if (map is List)
        return map.map((item) => Timetable.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Timetable?> getTimetable(int id) async {
    final response = await get('timetable/$id');
    return response.body;
  }

  Future<Response<Timetable>> postTimetable(Timetable timetable) async =>
      await post('timetable', timetable);
  Future<Response> deleteTimetable(int id) async =>
      await delete('timetable/$id');
}
