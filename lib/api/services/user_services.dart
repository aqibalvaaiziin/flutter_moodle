import 'package:dio/dio.dart';
import 'package:flutter_moodle/api/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Dio dio = Dio();
  static Response? response;

  static Future loginUser({
    String? username,
    String? password,
  }) async {
    try {
      response = await dio.post(
        '$baseUrlLogin?service=moodle_mobile_app&username=$username&password=$password',
      );
      return response;
    } on DioError catch (ex) {
      // ignore: avoid_print
      print(ex.error.toString());
      if (ex.type == DioErrorType.response) {
        // ignore: avoid_print
        print("login form Error");
        if (ex.response!.statusCode == 404) {
          // ignore: avoid_print
          print("warning api");
        }
      } else if (ex.type == DioErrorType.response) {
        // ignore: avoid_print
        print("error default");
        throw Exception(ex.error.message);
      } else {
        // ignore: avoid_print
        print("timeout");
      }
    }
  }

  static Future getUserProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token")!;
    String username = sp.getString("username")!;
    return await dio.post(
      "$baseUrl?moodlewsrestformat=json&wstoken=$token&wsfunction=core_user_get_users_by_field&field=username&values[0]=$username",
    );
  }

  static Future getUserProfileOnLogin(String token, String username) async {
    return await dio.post(
      "$baseUrl?moodlewsrestformat=json&wstoken=$token&wsfunction=core_user_get_users_by_field&field=username&values[0]=$username",
    );
  }
}
