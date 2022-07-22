import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/user_services.dart';
import './profile_screen.dart';

abstract class ProfileScreenViewModel extends State<ProfileScreen> {
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  // ignore: prefer_typing_uninitialized_variables
  var userData;

  getUserData() {
    UserServices.getUserProfile().then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));

      setState(() {
        userData = jsonObject[0];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }
}
