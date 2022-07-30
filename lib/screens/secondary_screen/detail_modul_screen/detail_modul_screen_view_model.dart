import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './detail_modul_screen.dart';

abstract class DetailModulScreenViewModel extends State<DetailModulScreen> {
  double width = 0.0;
  double height = 0.0;
  List content = [];
  String token = "";
  bool isLoading = true;

  getDataContent() {
    CourseServices.getContentByCourse(widget.courseId).then((value) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
      token = sp.getString("token")!;
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
