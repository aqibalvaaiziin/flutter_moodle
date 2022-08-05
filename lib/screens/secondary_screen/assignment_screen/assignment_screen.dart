import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/assignment_screen/assignment_screen_view.dart';

// ignore: use_key_in_widget_constructors
class AssignmentScreen extends StatefulWidget {
  final int courseId;
  final String title;
  final int assignmentId;

  const AssignmentScreen({
    super.key,
    required this.courseId,
    required this.title,
    required this.assignmentId,
  });

  @override
  // ignore: unnecessary_new
  AssignmentScreenView createState() => new AssignmentScreenView();
}
