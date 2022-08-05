import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import 'package:flutter_moodle/screens/main_screen/courses_screen/courses_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoursesScreenViewModel extends State<CoursesScreen> {
  TextEditingController searchTextController = TextEditingController();
  String filter = "";
  double width = 0.0;
  double height = 0.0;
  List courses = [];
  String token = "";
  bool isLoading = true;

  getDataCourses() {
    CourseServices.getListCourses().then((value) async {
      SharedPreferences sp = await SharedPreferences.getInstance();

      var jsonObject = jsonDecode(jsonEncode(value.data));
      // ignore: avoid_print
      setState(() {
        jsonObject['courses'].forEach((e) {
          if (e['visible'] == 1) {
            courses.add(e);
          }
        });

        token = sp.getString("token")!;
        isLoading = false;
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
