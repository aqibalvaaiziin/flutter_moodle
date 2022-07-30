import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/user_services.dart';
import 'package:flutter_moodle/helper/preferences_data.dart';
import 'package:flutter_moodle/screens/login_screen/login_screen.dart';
import 'package:flutter_moodle/screens/navigation_screen.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

abstract class LoginScreenViewModel extends State<LoginScreen> {
  TextEditingController username = TextEditingController(text: "galihp");
  TextEditingController password = TextEditingController(text: "Galih@123");

  double width = 0.0;
  double height = 0.0;
  bool isVisible = true;
  bool isLoading = false;

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      // ignore: unnecessary_new
      new GlobalKey<ScaffoldMessengerState>();
  PreferencesData preferencesData = PreferencesData();
  final belumterdaftar = SnackBar(
    content: customText(
      12,
      "User Belum Terdaftar",
      color: Colors.white,
    ),
  );
  final isidulu = SnackBar(
    content: customText(
      12,
      "User Belum Terdaftar",
      color: Colors.white,
    ),
  );

  void loginUserAction() {
    bool condition = username.text.isNotEmpty && password.text.isNotEmpty;

    if (condition) {
      setState(() {
        isLoading = true;
      });
      authAction();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(isidulu);
    }
  }

  authAction() {
    UserServices.loginUser(username: username.text, password: password.text)
        .then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      if (jsonObject['errorcode'] == "invalidlogin") {
        ScaffoldMessenger.of(context).showSnackBar(belumterdaftar);
        setState(() {
          isLoading = false;
        });
      } else {
        setUserData(jsonObject['token'], username.text);
        nextPageRemove(context, const NavigationControl());
      }
    });
  }

  setUserData(String token, String username) {
    UserServices.getUserProfileOnLogin(token, username).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      preferencesData.setUserData(
        username,
        token,
        jsonObject[0]['id'],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}
