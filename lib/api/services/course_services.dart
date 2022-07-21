import 'package:dio/dio.dart';
import 'package:flutter_moodle/api/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CourseServices {
  static Dio dio = Dio();
  static Response? response;

  static Future getListCourses() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=core_course_get_courses_by_field&moodlewsrestformat=json&field=category&value=1",
    );
  }

  static Future getAllModuleByCourseId(int courseId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    // String token = "c49ea9d10ef8b6096192167acecd236d";
    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=core_course_get_contents&moodlewsrestformat=json&courseid=$courseId",
    );
  }

  static Future getContentByCourse(int courseId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_page_get_pages_by_courses &moodlewsrestformat=json&courseids[0]=$courseId",
    );
  }

  static Future getIdCourses(int courseId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_forum_get_forums_by_courses&moodlewsrestformat=json&courseids[0]=$courseId",
    );
  }

  static Future getListDiscussion(int forumId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    return await dio.get(
      "$baseUrl?wstoken=$token&wsfunction=mod_forum_get_forum_discussions&moodlewsrestformat=json&forumid=$forumId",
    );
  }
}
