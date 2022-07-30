import 'package:dio/dio.dart';
import 'package:flutter_moodle/api/config.dart';

class QuizServices {
  static Dio dio = Dio();
  static Response? response;

  static Future getQuestionList() async {
    return await dio.get(
      "$externalUrl/questions",
      queryParameters: {
        "name": ""
      },
    );
  }
}
