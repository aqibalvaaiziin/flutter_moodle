import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import 'package:flutter_moodle/screens/main_screen/courses_screen/courses_screen.dart';

abstract class CoursesScreenViewModel extends State<CoursesScreen> {
  TextEditingController searchTextController = TextEditingController();
  String filter = "";
  double width = 0.0;
  double height = 0.0;
  List courses = [];
  String token = "c49ea9d10ef8b6096192167acecd236d";

  getDataCourses() {
    CourseServices.getListCourses().then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      // ignore: avoid_print
      setState(() {
        jsonObject['courses'].forEach((e) {
          courses.add(e);
        });
      });
    });
  }

  // data = new List<TopicModel>();
  //     json['data'].forEach((v) {
  //       data.add(new TopicModel.fromJson(v));
  //     });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataCourses();
      searchTextController.addListener(() {
        setState(() {
          filter = searchTextController.text;
        });
      });
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}
