import 'package:flutter/material.dart';
import 'package:flutter_moodle/screens/secondary_screen/chat_forum_screen/chat_forum_screen.dart';
import 'package:flutter_moodle/screens/secondary_screen/forum_screen/forum_screen_view_model.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

class ForumScreenView extends ForumScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      // body: Text("dsadsadasdsa"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90),
                ...forums.map((e) {
                  return filter == ""
                      ? cardDiscussion(
                          e['id'],
                          e['name'],
                          e['userfullname'],
                          e['usermodifiedfullname'],
                          e['created'].toString(),
                          e['modified'].toString(),
                        )
                      : e['name'].toLowerCase().contains(filter.toLowerCase())
                          ? cardDiscussion(
                              e['id'],
                              e['name'],
                              e['userfullname'],
                              e['usermodifiedfullname'],
                              e['created'].toString(),
                              e['modified'].toString(),
                            )
                          : const SizedBox();
                })
              ],
            ),
          ),
          searchInput(),
        ],
      ),
    );
  }

  Widget searchInput() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: width,
      height: 80,
      color: Colors.white,
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.only(left: 20, top: 8),
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: customShadow()),
        child: TextField(
          controller: searchTextController,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20.0,
            ),
            border: InputBorder.none,
            hintText: 'Cari Diskusi',
          ),
        ),
      ),
    );
  }

  Widget cardDiscussion(
    int postId,
    String discussionName,
    String author,
    String lastAuthor,
    String dateCreated,
    String lastModified,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.06,
        vertical: width * 0.025,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: customShadow(),
      ),
      width: width,
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        onPressed: () {
          nextPage(
              context,
              ChatForumScreen(
                postId: postId,
                discussionName: discussionName,
              ));
          // print("object");
        },
        child: Column(
          children: [
            Icon(
              Icons.chat_rounded,
              size: width * 0.1,
              color: Colors.orangeAccent,
            ),
            SizedBox(height: height * 0.01),
            customText(width * 0.035, discussionName, fw: FontWeight.w700),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              width: width,
              height: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boxUser("Di mulai", author, dateCreated, true),
                  Container(
                    width: 2,
                    height: height * 0.08,
                    color: Colors.grey,
                  ),
                  boxUser("Terakhir dilihat", lastAuthor, lastModified, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget boxUser(
    String time,
    String author,
    String date,
    bool isRight,
  ) {
    return Column(
      crossAxisAlignment:
          !isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        customText(
          width * 0.027,
          time,
          color: Colors.grey,
          fw: FontWeight.bold,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            isRight
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      customText(width * 0.03, author, fw: FontWeight.bold),
                      const SizedBox(height: 3),
                      customText(
                        width * 0.025,
                        date,
                      ),
                    ],
                  ),
            SizedBox(width: width * 0.01),
            Container(
              width: width * 0.08,
              height: width * 0.08,
              decoration: BoxDecoration(
                color: !isRight ? Colors.grey : Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Center(
                  child: Icon(
                Icons.person,
                color: Colors.white,
              )),
            ),
            SizedBox(width: width * 0.01),
            !isRight
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(width * 0.03, author, fw: FontWeight.bold),
                      const SizedBox(height: 3),
                      customText(
                        width * 0.025,
                        date,
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  Widget boxParent() {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: customShadow(),
      ),
      child: Column(
        children: [Row()],
      ),
    );
  }
}