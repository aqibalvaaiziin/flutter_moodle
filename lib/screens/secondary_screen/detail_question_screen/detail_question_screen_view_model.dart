import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/quiz_services.dart';
import 'package:flutter_moodle/screens/secondary_screen/detail_question_screen/detail_question_screen.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

abstract class DetailQuestionScreenViewModel
    extends State<DetailQuestionScreen> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  bool isUpdate = false;
  List answers = [];
  int answerId = 0;
  final pilihJawaban = SnackBar(
    backgroundColor: Colors.red,
    content: customText(
      12,
      "Isi jawaban terlebih dahulu",
      color: Colors.white,
      fw: FontWeight.bold,
    ),
  );
  final jawabanTerkirim = SnackBar(
    backgroundColor: Colors.green,
    content: customText(
      12,
      "Jawaban Terkirim",
      color: Colors.white,
      fw: FontWeight.bold,
    ),
  );

  checkTheLastAnswer() {
    QuizServices.checkAnswer(widget.quizId, widget.questionId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        if (jsonObject['success'] == true) {
          answerId = jsonObject['data']['answer_id'];
          isUpdate = true;
        }
        isLoading = false;
      });
    });
  }

  getListAnswer() {
    QuizServices.getAnswerListByQuestion(widget.questionId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        jsonObject['answer'].forEach((element) {
          answers.add(element);
        });
      });
    });
    checkTheLastAnswer();
  }

  buttonSendAction() {
    setState(() {
      isLoading = true;
    });
    if (isUpdate) {
      updateAnswerAction();
    } else {
      addAnswerAction();
    }
  }

  addAnswerAction() {
    if (answerId != 0) {
      QuizServices.sendAnswer(widget.quizId, answerId, widget.questionId)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(jawabanTerkirim);
        backScreen(context);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(pilihJawaban);
    }
  }

  updateAnswerAction() {
    QuizServices.updateAnswer(answerId, widget.questionId).then((value) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(jawabanTerkirim);
      backScreen(context);
    });
  }

 
  @override
  void initState() {
    super.initState();
    getListAnswer();
  }
}
