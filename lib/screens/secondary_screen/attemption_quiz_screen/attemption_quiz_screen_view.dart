import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/attemption_quiz_screen/attemption_quiz_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttemptionQuizScreenView extends AttemptionQuizScreenViewModel {
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
      body: Column(
        children: [
          subModule(),
          const Expanded(
            child: SizedBox(),
          ),
          buttonStartAttemp(),
        ],
      ),
    );
  }

  Widget subModule() {
    return Container(
      width: width,
      margin: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: customShadow(),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.fromLTRB(
        width * 0.05,
        height * 0.015,
        width * 0.05,
        height * 0.015,
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconBox(),
                SizedBox(width: width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                      width * 0.025,
                      "QUIZ",
                      fw: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    SizedBox(height: height * 0.005),
                    customText(width * 0.035, widget.quizName),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }

  Widget iconBox() {
    return Container(
      width: width * 0.1,
      height: width * 0.1,
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          FontAwesomeIcons.question,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buttonStartAttemp() {
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
          attemptionAction();
        },
        child: Center(
          child: customText(
            width * 0.032,
            "Mulai Quiz",
            fw: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
