import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/detail_question_screen/detail_question_screen_view.dart';

class DetailQuestionScreen extends StatefulWidget {
  final String questionText;
  final int questionId;
  final int quizId;
  final String indexSoal;

  const DetailQuestionScreen({
    super.key,
    required this.questionText,
    required this.questionId,
    required this.quizId,
    required this.indexSoal,
  });

  @override
  // ignore: unnecessary_new
  DetailQuestionScreenView createState() => new DetailQuestionScreenView();
}
