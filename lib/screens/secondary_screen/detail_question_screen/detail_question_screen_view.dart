import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_moodle/screens/secondary_screen/detail_question_screen/detail_question_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';

class DetailQuestionScreenView extends DetailQuestionScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.indexSoal,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: isLoading
          ? loaderPage()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Html(
                      data: widget.questionText,
                      style: {
                        "p": Style(
                          fontSize: FontSize(width * 0.037),
                        ),
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        return buildListAnswer(
                            answers[index]['id'], answers[index]['answer']);
                      },
                    ),
                    buttonSendAnswer(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildListAnswer(int answerIdValue, String answer) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: answerId == answerIdValue ? Colors.pinkAccent : Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.pink,
        ),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            answerId = answerIdValue;
          });
        },
        child: Html(
          data: answer,
          style: {
            "p": Style(
              fontSize: FontSize(width * 0.032),
              color: answerId == answerIdValue ? Colors.white : Colors.black,
            ),
          },
        ),
      ),
    );
  }

  Widget buttonSendAnswer() {
    return Container(
      width: width,
      margin: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.orange,
        boxShadow: customShadow(),
      ),
      padding: EdgeInsets.zero,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          buttonSendAction();
        },
        child: Center(
          child: customText(
            width * 0.032,
            isUpdate ? "Ubah Jawaban" : "Kirim Jawaban",
            fw: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
