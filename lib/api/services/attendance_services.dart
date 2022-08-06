import 'package:dio/dio.dart';
import 'package:flutter_moodle/api/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceServices {
  static Dio dio = Dio();
  static Response? response;

  static Future getDataAttendance(int attendanceId) async {
    String token = "343564177ed8a5cf4925ca3f065fb429";

    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_attendance_get_sessions&moodlewsrestformat=json&attendanceid=$attendanceId",
    );
  }

  static Future addAttendance(
      int sessionId, int statusId, String status) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = "343564177ed8a5cf4925ca3f065fb429";
    int userId = sp.getInt("userId")!;
    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_attendance_update_user_status&moodlewsrestformat=json&sessionid=$sessionId&studentid=$userId&takenbyid=$userId&statusid=$statusId&statusset=$status",
    );
  }
}
