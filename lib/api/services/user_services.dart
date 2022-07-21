import 'package:dio/dio.dart';

class UserServices {
  static Dio dio = Dio();
  static Response? response;

  static Future loginUser({
    String? username,
    String? password,
  }) async {
    try {
      response = await dio.post(
        'http://192.168.100.98/moodle/login/token.php?service=moodle_mobile_app&username=$username&password=$password',
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
}
