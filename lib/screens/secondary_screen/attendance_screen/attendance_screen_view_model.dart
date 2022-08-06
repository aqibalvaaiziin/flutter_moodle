import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/attendance_services.dart';
import 'package:flutter_moodle/helper/utils.dart';
import 'package:flutter_moodle/screens/secondary_screen/attendance_screen/attendance_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AttendanceScreenViewModel extends State<AttendanceScreen> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  List dataAttendance = [];
  bool isDoneAttendance = false;
  int userId = 0;
  int presentId = 9;
  String presentStatus = "Present";
  int lateId = 11;
  String lateStatus = "Late";

  getDataAttendance() {
    dataAttendance.clear();
    getuserId();
    AttendanceServices.getDataAttendance(widget.attendanceId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        jsonObject.forEach((e) {
          dataAttendance.add(e);
        });
        isLoading = false;
      });
    });
  }

  getuserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int dataUserId = sp.getInt("userId")!;
    setState(() {
      userId = dataUserId;
    });
  }

  sendPresent(int endTime, int sessionId) {
    setState(() {
      isLoading = true;
    });
    if (UtilsData.checkLateTime(endTime)) {
      AttendanceServices.addAttendance(
        sessionId,
        lateId,
        lateStatus,
      ).then((value) {
        getDataAttendance();
      });
    } else {
      AttendanceServices.addAttendance(
        sessionId,
        presentId,
        presentStatus,
      ).then((value) {
        getDataAttendance();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataAttendance();
    });
  }
}
