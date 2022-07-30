import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import 'package:flutter_moodle/helper/preferences_data.dart';
import 'package:flutter_moodle/screens/secondary_screen/attemption_quiz_screen/attemption_quiz_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/quiz_screen/quiz_screen.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

abstract class AttemptionQuizScreenViewModel
    extends State<AttemptionQuizScreen> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  int quizId = 0;
  PreferencesData preferencesData = PreferencesData();
  final gagalAttempt = SnackBar(
    content: customText(
      12,
      "Ujian sedang berjalan",
      color: Colors.white,
    ),
  );

  getDataAttemption() {
    CourseServices.getQuizIdFromCourseId(widget.courseId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      jsonObject['quizzes'].forEach((element) {
        if (element['name'] == widget.quizName) {
          setState(() {
            quizId = element['id'];
          });
        }
      });
    });
  }

  attemptionAction() {
    CourseServices.getDataAttemption(quizId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));

      if (jsonObject['errorcode'] == "attemptstillinprogress") {
        ScaffoldMessenger.of(context).showSnackBar(gagalAttempt);
      } else {
        int attemptId = jsonObject['attempt']['id'];
        preferencesData.setQuizData(quizId, attemptId);
        nextPage(
          context,
          QuizScreen(
            attemptId: attemptId,
            quizName: widget.quizName,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAttemption();
  }
}
