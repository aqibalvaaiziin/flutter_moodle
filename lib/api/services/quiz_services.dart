import 'package:dio/dio.dart';
import 'package:flutter_moodle/api/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizServices {
  static Dio dio = Dio();
  static Response? response;

  static Future checkScoreQuiz(int quizId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt("userId")!;

    return await dio.get(
      "$externalUrl/findGrade",
      queryParameters: {
        "user_id": userId,
        "quiz_id": quizId,
      },
    );
  }

  static Future getQuestionList(String quizName) async {
    return await dio.get(
      "$externalUrl/questions",
      queryParameters: {
        "name": quizName,
      },
    );
  }

  static Future getAnswerListByQuestion(int questionId) async {
    return await dio.get(
      "$externalUrl/answers",
      queryParameters: {
        "question_id": questionId,
      },
    );
  }

  static Future checkAnswer(int quizId, int questionId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt("userId")!;

    return await dio.get(
      "$externalUrl/checking",
      queryParameters: {
        "question_id": questionId,
        "quiz_id": quizId,
        "user_id": userId,
      },
    );
  }

  static Future sendAnswer(int quizId, int answerId, int questionId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt("userId")!;
    // print("userId : $userId");
    // print("answerId : $answerId");
    // print("questionId : $questionId");
    // print("quizId : $quizId");
    return await dio.post(
      "$externalUrl/answer",
      data: {
        "answer_id": answerId,
        "question_id": questionId,
        "user_id": userId,
        "quiz_id": quizId,
      },
    );
  }

  static Future updateAnswer(int answerId, int questionId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt("userId")!;

    return await dio.post(
      "$externalUrl/updateAnswers",
      data: {
        "answer_id": answerId,
        "question_id": questionId,
        "user_id": userId,
      },
    );
  }

  static Future submitQuiz(int quizId, int attemptId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt("userId")!;

    return await dio.post(
      "$externalUrl/grading",
      data: {
        "user_id": userId,
        "quiz_id": quizId,
        "attemptid": attemptId,
      },
    );
  }
}
