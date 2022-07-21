import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/module_screen/module_screen_view.dart';

// ignore: use_key_in_widget_constructors
class ModuleScreen extends StatefulWidget {
  final int courseId;
  final String courseName;

  const ModuleScreen(
      {super.key, required this.courseId, required this.courseName});

  @override
  // ignore: unnecessary_new
  ModuleScreenView createState() => new ModuleScreenView();
}
