import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import './forum_screen.dart';

abstract class ForumScreenViewModel extends State<ForumScreen> {
  TextEditingController searchTextController = TextEditingController();
  String filter = "";
  double width = 0.0;
  double height = 0.0;
  List forums = [];
  String token = "c49ea9d10ef8b6096192167acecd236d";
  int forumId = 0;

  getIdForumDicussion() {
    CourseServices.getIdCourses(widget.courseId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      jsonObject.forEach((e) {
        if (widget.name == e['name']) {
          forumId = e['id'];
        }
      });
      getDataDiscussion();
    });
  }

  getDataDiscussion() {
    CourseServices.getListDiscussion(forumId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      // ignore: avoid_print
      setState(() {
        jsonObject['discussions'].forEach((e) {
          forums.add(e);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIdForumDicussion();
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
