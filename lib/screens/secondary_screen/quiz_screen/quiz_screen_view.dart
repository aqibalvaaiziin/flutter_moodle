import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import './quiz_screen_view_model.dart';

class QuizScreenView extends QuizScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: isLoading ? loaderPage(): Html(data: htmlData));

    // return WebView(
    //   initialUrl:
    //       "http://192.168.0.100/moodle/mod/quiz/attempt.php?attempt=1&cmid=16",
    // );
  }
}
