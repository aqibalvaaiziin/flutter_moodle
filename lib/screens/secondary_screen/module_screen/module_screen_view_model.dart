import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import './module_screen.dart';

abstract class ModuleScreenViewModel extends State<ModuleScreen> {
  double width = 0.0;
  double height = 0.0;
  List moduleList = [];
  bool isLoading = true;

  getDataModule() {
    CourseServices.getAllModuleByCourseId(widget.courseId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        jsonObject.forEach((datas) {
          if (datas['name'].toLowerCase().contains('bab') ||
              datas['name'].toLowerCase().contains('forum') ||
              datas['name'].toLowerCase().contains('absensi') ||
              datas['name'].toLowerCase().contains('quiz') ||
              datas['name'].toLowerCase().contains('tugas')) {
            moduleList.add(datas);
          }
        });
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataModule();
  }
}
