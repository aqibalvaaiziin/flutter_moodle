import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/quiz_services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './quiz_screen.dart';

abstract class QuizScreenViewModel extends State<QuizScreen> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  List questions = [];

  String htmlData = "";

  getQuiz() {
    QuizServices.getQuestionList().then((value) {
      // var jsonObject = jsonDecode(jsonEncode(value.data));
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    getQuiz();
  }
}
