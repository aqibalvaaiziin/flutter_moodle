import 'package:flutter/material.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/helper/utils.dart';
import 'package:flutter_moodle/screens/secondary_screen/assignment_screen/assignment_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/attemption_quiz_screen/attemption_quiz_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/attendance_screen/attendance_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/detail_modul_screen/detail_modul_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/forum_screen/forum_screen.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './module_screen_view_model.dart';

class ModuleScreenView extends ModuleScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.courseName,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        backgroundColor: CustomColor.mainColor,
      ),
      body: isLoading
          ? loaderPage()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ...moduleList.map((e) {
                    return boxModule(e['name'], e['modules']);
                  })
                ],
              ),
            ),
    );
  }

  Widget boxModule(String name, List datas) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: customShadow(),
        borderRadius: BorderRadius.circular(6),
      ),
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              color: name.toLowerCase().contains("forum")
                  ? Colors.orange
                  : name.toLowerCase().contains("quiz")
                      ? Colors.pinkAccent
                      : name.toLowerCase().contains("tugas")
                          ? Colors.blue
                          : name.toLowerCase().contains("absensi")
                              ? Colors.deepPurple
                              : CustomColor.mainColor,
              boxShadow: customShadow(),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6),
                topLeft: Radius.circular(6),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
              vertical: height * 0.01,
            ),
            child: Center(
              child: customText(width * 0.039, name,
                  color: Colors.white,
                  fw: FontWeight.bold,
                  ta: TextAlign.center),
            ),
          ),
          datas.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: customText(
                      width * 0.033,
                      "Tidak Ada Layanan",
                      fw: FontWeight.w700,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: datas.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return datas[index]['modname'].toLowerCase() == "forum" ||
                            datas[index]['modname'].toLowerCase() == "page" ||
                            datas[index]['modname'].toLowerCase() ==
                                "attendance" ||
                            datas[index]['modname'].toLowerCase() == "assign"
                        ? subModule(
                            datas[index]['id'],
                            datas[index]['name'],
                            UtilsData.capitalize(datas[index]['modname']),
                            datas[index]['instance'],
                            datas.length,
                            index,
                          )
                        : const SizedBox();
                  },
                ),
        ],
      ),
    );
  }

  Widget subModule(
    int id,
    String subName,
    String type,
    int attendanceId,
    int dataLength,
    int index,
  ) {
    return SizedBox(
      width: width,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.015,
          width * 0.05,
          height * 0.015,
        ),
        onPressed: () {
          if (type.toLowerCase() == "forum") {
            nextPage(
              context,
              ForumScreen(
                name: subName,
                courseId: widget.courseId,
              ),
            );
          } else if (type.toLowerCase() == "quiz") {
            nextPage(
                context,
                AttemptionQuizScreen(
                  courseId: widget.courseId,
                  quizName: subName,
                ));
          } else if (type.toLowerCase() == "assign") {
            nextPage(
                context,
                AssignmentScreen(
                  courseId: widget.courseId,
                  title: subName,
                  assignmentId: id,
                ));
          } else if (type.toLowerCase() == "attendance") {
            nextPage(
                context,
                AttendanceScreen(
                  attendanceId: attendanceId,
                  title: subName,
                ));
          } else {
            nextPage(
              context,
              DetailModulScreen(
                name: subName,
                courseId: widget.courseId,
              ),
            );
          }
        },
        child: Center(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconBox(type.toLowerCase()),
                  SizedBox(width: width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(width * 0.032, type, fw: FontWeight.bold),
                      SizedBox(height: height * 0.005),
                      customText(width * 0.031, subName),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconBox(String type) {
    return Container(
      width: width * 0.1,
      height: width * 0.1,
      decoration: BoxDecoration(
        color: type == "forum"
            ? Colors.orange
            : type == "quiz"
                ? Colors.pinkAccent
                : type == "assign"
                    ? Colors.blue
                    : type == "attendance"
                        ? Colors.deepPurple
                        : CustomColor.mainColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Icon(
          type == "forum"
              ? Icons.chat
              : type == "quiz"
                  ? FontAwesomeIcons.question
                  : type == "assign"
                      ? FontAwesomeIcons.upload
                      : type == "attendance"
                          ? FontAwesomeIcons.userCheck
                          : Icons.book_rounded,
          color: Colors.white,
          size: width * 0.045,
        ),
      ),
    );
  }
}
