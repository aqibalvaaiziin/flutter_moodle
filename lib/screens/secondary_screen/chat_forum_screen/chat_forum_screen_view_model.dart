import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_moodle/api/services/course_services.dart';
import 'package:flutter_moodle/screens/secondary_screen/chat_forum_screen/chat_forum_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatForumScreenViewModel extends State<ChatForumScreen> {
  double width = 0.0;
  double height = 0.0;
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var mainObject;
  bool isLoader = true;
  String token = "";
  List dataChat = [];
  int isMe = 0;

  scrollBehaviour() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 700),
      curve: Curves.ease,
    );
  }

  getDataMainDiscussion() {
    CourseServices.getMainDiscussion(widget.postId).then((value) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      int userId = sp.getInt("userId")!;
      var jsonObject = jsonDecode(jsonEncode(value.data));

      setState(() {
        isMe = userId;
        mainObject = jsonObject['post'];
        token = sp.getString("token")!;
        getDataListDiscussion(mainObject['discussionid']);
      });
    });
  }

  getDataListDiscussion(int discussionId) {
    CourseServices.getListDiscussionByDiscussion(discussionId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      setState(() {
        dataChat.clear();
        jsonObject['posts'].forEach((element) {
          dataChat.add(element);
        });
        isLoader = false;
      });
    });
  }

  sendFeedback() {
    CourseServices.sendFeedbackDiscussion(
      widget.postId,
      mainObject['subject'],
      textController.text,
    ).then((value) {
      setState(() {
        isLoader = true;
        textController.clear();
        getDataListDiscussion(mainObject['discussionid']);
      });
    });
  }

  @override
  void initState() {
    getDataMainDiscussion();
    super.initState();
  }
}
