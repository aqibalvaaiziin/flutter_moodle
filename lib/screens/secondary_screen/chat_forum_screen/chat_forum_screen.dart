import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/chat_forum_screen/chat_forum_screen_view.dart';

// ignore: use_key_in_widget_constructors
class ChatForumScreen extends StatefulWidget {
  final int postId;
  final String discussionName;

  const ChatForumScreen({
    super.key,
    required this.postId,
    required this.discussionName,
  });
  @override
  // ignore: unnecessary_new
  ChatForumScreenView createState() => new ChatForumScreenView();
}
