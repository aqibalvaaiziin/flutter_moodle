import 'package:flutter/material.dart';
import 'package:flutter_moodle/helper/global_variable.dart';
import 'package:flutter_moodle/screens/main_screen/courses_screen/courses_screen_view_model.dart';
import 'package:flutter_moodle/screens/secondary_screen/module_screen/module_screen.dart';
import 'package:flutter_moodle/widgets/custom_widget.dart';
import 'package:flutter_moodle/widgets/route.dart';

class CoursesScreenView extends CoursesScreenViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      body: isLoading
          ? loaderPage()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      ...courses.map((e) {
                        return filter == ""
                            ? cardCourse(
                                e['id'],
                                e['displayname'],
                                e['contacts'][0]['fullname'],
                                "${e['overviewfiles'][0]['fileurl']}?token=$token",
                              )
                            : e['displayname']
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? cardCourse(
                                    e['id'],
                                    e['displayname'],
                                    e['contacts'][0]['fullname'],
                                    "${e['overviewfiles'][0]['fileurl']}?token=$token",
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
      color: CustomColor.mainColor,
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
        ),
        child: TextField(
          controller: searchTextController,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20.0,
            ),
            border: InputBorder.none,
            hintText: 'Cari Course',
          ),
        ),
      ),
    );
  }

  Widget cardCourse(
    int courseId,
    String courseName,
    String teacherName,
    String imageUrl,
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
        padding: EdgeInsets.zero,
        onPressed: () {
          nextPage(
              context,
              ModuleScreen(
                courseId: courseId,
                courseName: courseName,
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              child: Image.network(
                imageUrl,
                width: width,
                height: height * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.015,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(width * 0.035, courseName, fw: FontWeight.w800),
                    const SizedBox(height: 10),
                    customText(width * 0.03, teacherName, color: Colors.grey),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
