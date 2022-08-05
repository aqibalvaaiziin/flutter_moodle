import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_moodle/helper/utils.dart';
import 'package:flutter_moodle/screens/secondary_screen/assignment_screen/assignment_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentScreenView extends AssignmentScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? loaderPage()
          : Column(
              children: [
                subModule(FontAwesomeIcons.upload, "Assignment", widget.title),
                descriptionBox(),
                isSubmited
                    ? subModule(
                        Icons.check_box,
                        "Status",
                        "Submitted",
                        colors: Colors.green,
                        isStatus: true,
                      )
                    : const SizedBox(),
                itemId == 0
                    ? const SizedBox()
                    : subModule(FontAwesomeIcons.file, "Nama File : ",
                        UtilsData.replaceCalibraces(nameDataUpload)),
                buttonPickFile(),
                const Expanded(child: SizedBox()),
                itemId == 0 ? const SizedBox() : buttonSendAssignment(),
              ],
            ),
    );
  }

  Widget subModule(
    IconData icon,
    String type,
    String title, {
    Color colors = Colors.blue,
    bool isStatus = false,
  }) {
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
                iconBox(icon, colors: colors),
                SizedBox(width: width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                      width * 0.025,
                      type,
                      fw: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    SizedBox(height: height * 0.005),
                    isStatus
                        ? Row(
                            children: [
                              customText(
                                width * 0.035,
                                "$title ",
                              ),
                              customText(
                                width * 0.03,
                                UtilsData.isOverdue(dataAssignment['duedate'],
                                        submittedTime)
                                    ? "(Terlambat)"
                                    : "",
                                color: Colors.red,
                              )
                            ],
                          )
                        : customText(width * 0.035, title),
                    SizedBox(height: height * 0.005),
                    isStatus
                        ? customText(width * 0.03,
                            UtilsData.parseDateDataAMPM(submittedTime))
                        : const SizedBox()
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

  Widget iconBox(
    IconData iconData, {
    Color colors = Colors.blue,
  }) {
    return Container(
      width: width * 0.1,
      height: width * 0.1,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget descriptionBox() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            width * 0.025,
            "Waktu: ",
            fw: FontWeight.bold,
            color: Colors.grey,
          ),
          dateData(
            "Di Buka",
            UtilsData.parseDateDataAMPM(
                dataAssignment['allowsubmissionsfromdate']),
          ),
          dateData(
            "Sampai",
            UtilsData.parseDateDataAMPM(dataAssignment['duedate']),
          ),
          SizedBox(height: height * 0.01),
          Container(
            width: width,
            height: 3,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(bottom: height * 0.015),
          ),
          customText(
            width * 0.025,
            "Description: ",
            fw: FontWeight.bold,
            color: Colors.grey,
          ),
          SizedBox(height: height * 0.005),
          Transform.translate(
            offset: Offset(-width * 0.018, -5),
            child: Html(
              data: dataAssignment['intro'],
              style: {
                "p": Style(
                  fontSize: FontSize(width * 0.031),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                )
              },
            ),
          )
        ],
      ),
    );
  }

  Widget dateData(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.calendarDay,
            size: width * 0.04,
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Row(
              children: [
                customText(width * 0.03, "$title : "),
                customText(width * 0.03, value),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonPickFile() {
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
          setState(() {
            isLoading = true;
          });
          pickFiles();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.file_copy_rounded, size: width * 0.05),
              SizedBox(width: width * 0.02),
              customText(
                width * 0.032,
                itemId != 0 ? "Ganti File" : "Pilih File",
                fw: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonSendAssignment() {
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
          setState(() {
            isLoading = true;
          });
          sendAssignmentAction();
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.upload, size: width * 0.05),
              SizedBox(width: width * 0.02),
              customText(
                width * 0.032,
                "Kirim Tugas",
                fw: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
