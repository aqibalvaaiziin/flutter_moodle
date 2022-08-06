import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_moodle/helper/utils.dart';
import 'package:flutter_moodle/screens/secondary_screen/attendance_screen/attendance_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendanceScreenView extends AttendanceScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        backgroundColor: const Color(0xFF673AB7),
      ),
      body: isLoading
          ? loaderPage()
          : Column(
              children: [
                subModule(),
                SizedBox(
                  width: width,
                  height: height * 0.73,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dataAttendance.length,
                      itemBuilder: (context, index) {
                        var data = dataAttendance[index];
                        bool isMe = false;
                        String logStatusId = "";
                        data['attendance_log'].forEach((e) {
                          if (e['studentid'] == userId) {
                            isMe = true;
                            logStatusId = e['statusid'];
                          }
                        });
                        return cardAttendance(
                          isMe,
                          // ignore: unrelated_type_equality_checks
                          logStatusId == presentId.toString()
                              ? "Hadir"
                              : "Terlambat",
                          data['id'],
                          data['sessdate'],
                          data['duration'],
                          data['description'],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget cardAttendance(
    bool isMe,
    String status,
    int sessionId,
    int openTime,
    int endTime,
    String description,
  ) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: customShadow(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      textIcon(
                          "Dibuka ", UtilsData.parseDateDataAMPM(openTime)),
                      textIcon("Ditutup",
                          UtilsData.parseDateDataAMPM(openTime + endTime)),
                    ],
                  ),
                ),
                isMe
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.007,
                        ),
                        decoration: BoxDecoration(
                            color: status == "Terlambat"
                                ? Colors.red
                                : Colors.green,
                            borderRadius: BorderRadius.circular(4)),
                        child: customText(
                          width * 0.03,
                          status,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          Container(
            width: width,
            height: 2,
            color: const Color.fromARGB(255, 212, 210, 210),
          ),
          description == ""
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: customText(width * 0.031, "Absensi"),
                )
              : Html(
                  data: description,
                  style: {
                    "p": Style(
                      fontSize: FontSize(width * 0.031),
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    )
                  },
                ),
          isMe
              ? const SizedBox()
              : Container(
                  width: width,
                  height: 2,
                  color: const Color.fromARGB(255, 212, 210, 210),
                ),
          isMe
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buttonSend(
                    openTime + endTime,
                    sessionId,
                    UtilsData.checkOpenAttendance(openTime),
                  ),
                )
        ],
      ),
    );
  }

  Widget textIcon(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            FontAwesomeIcons.calendarDays,
            size: width * 0.028,
          ),
          customText(width * 0.03, " $title : ", fw: FontWeight.bold),
          customText(width * 0.03, value),
        ],
      ),
    );
  }

  Widget subModule() {
    return Container(
      width: width,
      height: height * 0.1,
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
                      "Absensi",
                      fw: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    SizedBox(height: height * 0.005),
                    customText(width * 0.035, widget.title),
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
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Icon(
          FontAwesomeIcons.userCheck,
          color: Colors.white,
          size: 17,
        ),
      ),
    );
  }

  Widget buttonSend(int endTime, int sessionId, bool isOpen) {
    return Container(
      width: width,
      height: height * 0.045,
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xffFFC23C) : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          if (isOpen) {
            sendPresent(endTime, sessionId);
          }
        },
        child: customText(
          width * 0.03,
          isOpen ? "Kirim Absensi" : "Absensi Belum Dibuka",
          fw: FontWeight.bold,
          color: isOpen ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
