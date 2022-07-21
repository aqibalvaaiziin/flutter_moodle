import 'package:flutter/material.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/screens/secondary_screen/chat_forum_screen/chat_forum_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';

class ChatForumScreenView extends ChatForumScreenViewModel {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          widget.discussionName,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height * 0.899,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  buildMessageList(),
                  const SizedBox(height: 10),
                  buildInputArea(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.08,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: width,
      color: Colors.green,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  Widget buildSendButton() {
    return IconButton(
      color: Colors.white,
      onPressed: () {},
      icon: const Icon(
        Icons.send,
        size: 25,
      ),
    );
  }

  Widget buildChatInput() {
    return Expanded(
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: CustomColor.input,
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextField(
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration.collapsed(
            hintText: 'Send a message...',
            fillColor: CustomColor.input,
            focusColor: CustomColor.input,
            hoverColor: CustomColor.input,
          ),
          controller: textController,
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Expanded(
      flex: 9,
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Container();
        },
      ),
    );
  }
}
