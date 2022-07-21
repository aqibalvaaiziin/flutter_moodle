import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/detail_modul_screen/detail_modul_screen_view.dart';

// ignore: use_key_in_widget_constructors
class DetailModulScreen extends StatefulWidget {
  final String name;
  final int courseId;

  const DetailModulScreen({super.key, required this.name, required this.courseId});
  @override
  // ignore: unnecessary_new
  DetailModulScreenView createState() => new DetailModulScreenView();
}
