import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/attemption_quiz_screen/attemption_quiz_screen_view.dart';

// ignore: use_key_in_widget_constructors
class AttemptionQuizScreen extends StatefulWidget {
  final int courseId;
  final String quizName;

  const AttemptionQuizScreen({super.key, required this.courseId, required this.quizName});

  @override
  // ignore: unnecessary_new
  AttemptionQuizScreenView createState() => new AttemptionQuizScreenView();
}
