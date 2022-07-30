import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/quiz_screen/quiz_screen_view.dart';

// ignore: use_key_in_widget_constructors
class QuizScreen extends StatefulWidget {
  final int attemptId;
  final String quizName;

  const QuizScreen({super.key, required this.attemptId, required this.quizName});

  @override
  // ignore: unnecessary_new
  QuizScreenView createState() => new QuizScreenView();
}
