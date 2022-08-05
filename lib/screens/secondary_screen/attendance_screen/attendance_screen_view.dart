import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/attendance_screen/attendance_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';

class AttendanceScreenView extends AttendanceScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Center(
      child: customText(20, "absen"),
    ));
  }
}
