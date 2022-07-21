import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/chat_forum_screen/chat_forum_screen.dart';

abstract class ChatForumScreenViewModel extends State<ChatForumScreen> {
  double width = 0.0;
  double height = 0.0;
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();

  scrollBehaviour() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 700),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
