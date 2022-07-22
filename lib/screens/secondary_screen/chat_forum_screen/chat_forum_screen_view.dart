import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/helper/utils.dart';
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
      body: isLoader
          ? loaderPage()
          : Column(
              children: [
                buildBoxDiscussion(
                  mainObject['author']['id'],
                  mainObject['subject'],
                  mainObject['author']['fullname'],
                  mainObject['author']['urls']['profileimage'],
                  mainObject['timecreated'].toString(),
                  mainObject['message'],
                ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: <Widget>[
                //         buildMessageList(),
                //         const SizedBox(height: 10),
                //       ],
                //     ),
                //   ),
                // ),
                buildMessageList(),
                buildInputArea(),
              ],
            ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.08,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: width,
      color: Colors.orange,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          SizedBox(width: width * 0.01),
          buildSendButton(),
        ],
      ),
    );
  }

  Widget buildSendButton() {
    return Container(
      width: width * 0.1,
      height: width * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: customShadow(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            sendFeedback();
          },
          child: Center(
              child: Icon(
            Icons.send,
            color: Colors.orange,
            size: width * 0.06,
          )),
        ),
      ),
    );
  }

  Widget buildChatInput() {
    return Expanded(
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: customShadow(),
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
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        controller: scrollController,
        itemCount: dataChat.length,
        itemBuilder: (BuildContext context, int index) {
          return dataChat[index]['id'] == mainObject['id']
              ? const SizedBox()
              : buildBoxDiscussion(
                  dataChat[index]['author']['id'],
                  dataChat[index]['replysubject'],
                  dataChat[index]['author']['fullname'],
                  dataChat[index]['author']['urls']['profileimage'],
                  dataChat[index]['timecreated'].toString(),
                  dataChat[index]['message'],
                  isList: true,
                );
        },
      ),
    );
  }

  Widget buildBoxDiscussion(
    int authorId,
    String subject,
    String author,
    String authorImage,
    String time,
    String message, {
    bool isList = false,
  }) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: isList ? height * 0.01 : height * 0.02,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: customShadow(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.08,
            height: width * 0.08,
            decoration: BoxDecoration(
              color: isList ? Colors.grey : CustomColor.mainColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(authorImage)),
            ),
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(width * 0.033, subject, fw: FontWeight.w700),
                SizedBox(height: height * 0.003),
                customText(
                  width * 0.028,
                  isMe == authorId ? "by Me - $time" : "by $author - $time",
                  color: isMe == authorId ? CustomColor.mainColor : Colors.grey,
                  fw: isMe == authorId ? FontWeight.bold : FontWeight.normal,
                ),
                SizedBox(height: height * 0.01),
                Transform.translate(
                  offset: Offset(-width * 0.02, 0),
                  child: Html(
                    data: message.contains(".jpg")
                        ? UtilsData.mappingImageUrl(message, token)
                        : message.contains(".jpeg")
                            ? UtilsData.mappingImageUrl(message, token)
                            : message.contains(".png")
                                ? UtilsData.mappingImageUrl(message, token)
                                : message,
                    style: {
                      "p": Style(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                      )
                    },
                  ),
                )
              ],
            ),
          ),
          isList
              ? Icon(
                  Icons.question_answer,
                  color:
                      isMe == authorId ? CustomColor.mainColor : Colors.orange,
                  size: width * 0.04,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
