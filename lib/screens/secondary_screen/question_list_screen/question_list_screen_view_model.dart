import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/quiz_services.dart';
import 'package:flutter_moodle/screens/navigation_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/question_list_screen/question_list_screen.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

abstract class QuestionListScreenViewModel extends State<QuestionListScreen> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = false;
  List questions = [];
  final ujianSelesai = SnackBar(
    backgroundColor: Colors.green,
    content: customText(
      12,
      "Quiz Selesai!",
      color: Colors.white,
      fw: FontWeight.bold,
    ),
  );

  getListQuestion() {
    QuizServices.getQuestionList(widget.quizName).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        jsonObject['data'].forEach((element) {
          questions.add(element);
        });
      });
    });
  }

  submitQuiz() {
    setState(() {
      isLoading = true;
    });
    QuizServices.submitQuiz(widget.quizId, widget.attemptId).then((value) {
      nextPageRemove(context, const NavigationControl());
      ScaffoldMessenger.of(context).showSnackBar(ujianSelesai);
    });
  }

  @override
  void initState() {
    super.initState();
    getListQuestion();
  }
}
