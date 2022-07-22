import 'package:intl/intl.dart';

class UtilsData {
  static String capitalize(String data) {
    return "${data[0].toUpperCase()}${data.substring(1).toLowerCase()}";
  }

  static String mappingImageUrl(String url, String token) {
    String replacer = "";
    if (url.contains(".jpg")) {
      replacer = url.replaceAll(".jpg", ".jpg?token=$token");
    } else if (url.contains(".jpeg")) {
      replacer = url.replaceAll(".jpeg", ".jpeg?token=$token");
    } else if (url.contains(".png")) {
      replacer = url.replaceAll(".png", ".png?token=$token");
    }
    return replacer;
  }

  static String parseDateData(int time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }
}
