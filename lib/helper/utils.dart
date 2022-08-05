import 'package:intl/intl.dart';

class UtilsData {
  static String capitalize(String data) {
    return "${data[0].toUpperCase()}${data.substring(1).toLowerCase()}";
  }

  static String mappingImageUrl(String url, String token) {
    String replacer = "";
    if (url.contains(".jpg")) {
      replacer = url.replaceAll(".jpg", ".jpg?token=$token");
    }
    if (url.contains(".jpeg")) {
      replacer = url.replaceAll(".jpeg", ".jpeg?token=$token");
    }
    if (url.contains(".png")) {
      replacer = url.replaceAll(".png", ".png?token=$token");
    }
    return replacer;
  }

  static String parseDateData(int time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }

  static bool isOverdue(int due, int submitted) {
    bool data = false;
    var dueTime = DateTime.fromMillisecondsSinceEpoch(due * 1000);
    var submittedTime = DateTime.fromMillisecondsSinceEpoch(submitted * 1000);
    if (dueTime.isBefore(submittedTime)) {
      data = true;
    } else {
      data = false;
    }
    return data;
  }

  static String replaceCalibraces(String name) {
    String replaceFirst = name.replaceAll("(", "");
    String finalData = replaceFirst.replaceAll(")", "");
    return finalData;
  }

  static String parseDateDataAMPM(int time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var d24 = DateFormat('dd-MM-yyyy, HH:mm').format(dt);
    return d24;
  }

  static String parseScore(String score) {
    double dataScore = double.parse(score);
    return dataScore.toStringAsFixed(2);
  }
}
