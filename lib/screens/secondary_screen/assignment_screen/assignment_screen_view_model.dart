import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_moodle/api/services/assignment_services.dart';
import 'package:flutter_moodle/helper/utils.dart';
import 'package:flutter_moodle/screens/secondary_screen/assignment_screen/assignment_screen.dart';

abstract class AssignmentScreenViewModel extends State<AssignmentScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  // ignore: prefer_typing_uninitialized_variables
  var dataAssignment;
  List data = [];
  FileType pickingType = FileType.any;
  bool userAborted = false;
  List<PlatformFile>? paths;
  String? directoryPath;
  String? extension;
  String? fileName;
  String nameDataUpload = "";
  int itemId = 0;
  bool isSubmited = false;
  int submittedTime = 0;

  getDataAssigment() {
    AssignmentServices.getDataAssignment(widget.courseId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      List dummy = [];
      setState(() {
        jsonObject['courses'].forEach((e) {
          dummy.add(e);
        });
        dummy[0]['assignments'].forEach((e) {
          if (e['cmid'] == widget.assignmentId) {
            data.add(e);
          }
        });
        dataAssignment = data[0];
        checkStatusAssignment(dataAssignment['id']);
      });
    });
  }

  checkStatusAssignment(int assignId) {
    AssignmentServices.checkStatusAssignment(assignId).then((value) {
      var jsonObject = jsonDecode(jsonEncode(value.data));
      bool status =
          jsonObject['lastattempt']['submission']['status'] == "submitted";
      setState(() {
        if (status) {
          isSubmited = true;
          submittedTime =
              jsonObject['lastattempt']['submission']['timecreated'];
        }
        isLoading = false;
      });
    });
  }

  pickFiles() async {
    setState(() {
      isLoading = true;
    });
    resetState();
    try {
      directoryPath = null;
      paths = (await FilePicker.platform.pickFiles(
        type: pickingType,
        allowMultiple: false,
        // ignore: avoid_print
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (extension?.isNotEmpty ?? false)
            ? extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;

      // print(paths?[0].path);

    } on PlatformException catch (e) {
      // ignore: prefer_interpolation_to_compose_strings
      logException('Unsupported operation' + e.toString());
    } catch (e) {
      logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      fileName = paths != null ? paths!.map((e) => e.name).toString() : '...';
      userAborted = paths == null;
      if (fileName != null) {
        uploadAssigment(paths?[0].path, fileName!);
      }
    });
  }

  uploadAssigment(String? path, String fileNameData) {
    AssignmentServices.uploadFileAssignment(path, fileNameData).then((value) {
      var jsonObject = jsonDecode(value.data);
      List dummy = [];
      setState(() {
        jsonObject.forEach((e) {
          dummy.add(e);
        });

        // ignore: prefer_typing_uninitialized_variables, unused_local_variable
        var dataUpload;
        dataUpload = dummy[0];
        nameDataUpload = dataUpload['filename'];
        itemId = dataUpload['itemid'];
        isLoading = false;
      });
    });
  }

  void resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      directoryPath = null;
      fileName = null;
      paths = null;
      userAborted = false;
    });
  }

  logException(String message) {
    // ignore: deprecated_member_use
    scaffoldKey.currentState?.hideCurrentSnackBar();
    // ignore: deprecated_member_use
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  sendAssignmentAction() {
    AssignmentServices.postAssignment(
      dataAssignment['id'],
      UtilsData.replaceCalibraces(nameDataUpload),
      itemId,
    ).then((value) {
      setState(() {
        isLoading = false;
      });
      getDataAssigment();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAssigment();
  }
}
