import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import './detail_modul_screen.dart';

abstract class DetailModulScreenViewModel extends State<DetailModulScreen> {
  double width = 0.0;
  double height = 0.0;
  List content = [];
  String token = "c49ea9d10ef8b6096192167acecd236d";
  bool isLoading = true;

  getDataContent() {
    CourseServices.getContentByCourse(widget.courseId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        jsonObject['pages'].forEach((e) {
          if (e['name'] == widget.name) {
            content.add(e);
          }
        });
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataContent();
  }
}
