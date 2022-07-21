import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/forum_screen/forum_screen_view.dart';

// ignore: use_key_in_widget_constructors
class ForumScreen extends StatefulWidget {
  final String name;
  final int courseId;

  const ForumScreen({super.key, required this.name, required this.courseId});

  @override
  // ignore: unnecessary_new
  ForumScreenView createState() => new ForumScreenView();
}
