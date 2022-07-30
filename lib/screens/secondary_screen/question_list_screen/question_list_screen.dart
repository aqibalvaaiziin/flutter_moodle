import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/question_list_screen/question_list_screen_view.dart';

// ignore: use_key_in_widget_constructors
class QuestionListScreen extends StatefulWidget {
  final int attemptId;
  final int quizId;
  final String quizName;

  const QuestionListScreen(
      {super.key,
      required this.attemptId,
      required this.quizName,
      required this.quizId});

  @override
  // ignore: unnecessary_new
  QuestionListScreenView createState() => new QuestionListScreenView();
}
