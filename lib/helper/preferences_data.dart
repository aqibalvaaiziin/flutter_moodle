import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  Future setUserData(
    String username,
    String token,
    int userId,
  ) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("username", username);
    sp.setString("token", token);
    sp.setInt("userId", userId);
  }

  Future setQuizData(
    int quizId,
    int attemptId,
  ) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("quizId", quizId);
    sp.setInt("attemptId", attemptId);
  }
}
