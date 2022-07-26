// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/attendance_screen/attendance_screen_view.dart';

class AttendanceScreen extends StatefulWidget {
  final int attendanceId;
  final String title;

  const AttendanceScreen({
    super.key,
    required this.attendanceId,
    required this.title,
  });
  @override
  // ignore: unnecessary_new
  AttendanceScreenView createState() => new AttendanceScreenView();
}
