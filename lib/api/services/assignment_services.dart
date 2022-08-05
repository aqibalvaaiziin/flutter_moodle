import 'package:dio/dio.dart';
import 'package:flutter_moodle/api/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentServices {
  static Dio dio = Dio();
  static Response? response;

  static Future checkStatusAssignment(int assignId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    int userId = sp.getInt("userId")!;

    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_assign_get_submission_status&moodlewsrestformat=json&assignid=$assignId&userid=$userId",
    );
  }

  static Future getDataAssignment(int courseId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;

    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_assign_get_assignments&moodlewsrestformat=json&courseids[0]=$courseId",
    );
  }

  static Future uploadFileAssignment(String? path, String fileName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    int userId = sp.getInt("userId")!;
    var formData = FormData.fromMap({
      "component": "users",
      "userid": userId,
      "filearea": "draft",
      "filename": fileName,
      "filepath": "/",
      'source': await MultipartFile.fromFile(path!, filename: fileName),
    });
    return await dio.post(
      "http://192.168.0.100/moodle/webservice/upload.php?token=$token",
      data: formData,
    );
  }

  static Future postAssignment(
    int assignmentId,
    String fileName,
    int itemId,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;

    return await dio.post(
      "$baseUrl?wstoken=$token&wsfunction=mod_assign_save_submission&moodlewsrestformat=json&assignmentid=$assignmentId&plugindata[onlinetext_editor][text]=$fileName&plugindata[onlinetext_editor][format]=1&plugindata[onlinetext_editor][itemid]=$itemId&plugindata[files_filemanager]=$itemId",
    );
  }
}
