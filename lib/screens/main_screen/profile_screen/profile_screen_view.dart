import 'package:flutter/material.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import './profile_screen_view_model.dart';

class ProfileScreenView extends ProfileScreenViewModel {
  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: Center(
        child: customText(10, "ini Profile"),
      ),
    );
  }
}
