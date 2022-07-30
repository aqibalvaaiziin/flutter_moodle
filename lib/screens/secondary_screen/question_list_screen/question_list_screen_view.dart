import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/detail_question_screen/detail_question_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/question_list_screen/question_list_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

class QuestionListScreenView extends QuestionListScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.quizName,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: isLoading
          ? loaderPage()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return buildListData(
                        index + 1,
                        questions[index]['questiontext'],
                        questions[index]['id'],
                      );
                    },
                  ),
                  buttonSelesai(),
                ],
              ),
            ),
    );
  }

  Widget buildListData(
    int number,
    String questionText,
    int questionId,
  ) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        boxShadow: customShadow(),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          nextPage(
            context,
            DetailQuestionScreen(
              questionText: questionText,
              questionId: questionId,
              quizId: widget.quizId,
              indexSoal: "Soal No. ${number.toString()}",
            ),
          );
        },
        child: customText(
          width * 0.03,
          "Soal No. ${number.toString()}",
          fw: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buttonSelesai() {
    return Container(
      width: width,
      height: height * 0.07,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.orange,
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 1),
            )
          ],
          borderRadius: BorderRadius.circular(6)),
      child: MaterialButton(
        minWidth: width,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.03,
        ),
        onPressed: () {
          openDialogSubmit();
        },
        child: customText(
          width * 0.04,
          "Selesai !",
          fw: FontWeight.bold,
        ),
      ),
    );
  }

  void openDialogSubmit() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: customText(
          width * 0.044,
          "Yakin Selesai Mengerjakan ?",
          ta: TextAlign.center,
          fw: FontWeight.bold,
        ),
        content: Container(
          margin: EdgeInsets.only(top: height * 0.01),
          child: customText(
            width * 0.035,
            "Pastikan Sudah Dikerjakan Semua !",
            th: 1.3,
            ta: TextAlign.center,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Tidak'),
            onPressed: () {
              backScreen(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Iya'),
            onPressed: () {
              submitQuiz();
            },
          ),
        ],
      ),
    );
  }
}
