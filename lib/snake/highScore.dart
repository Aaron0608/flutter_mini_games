import 'package:shared_preferences/shared_preferences.dart';

const HIGH_SCORE = 'highScore';

/// Retrieves the saved High Score for Snake game.
///
/// Returns 'Future' because this function is asynchronous. This means
/// the calling function must also be asynchronous so it can await for the
/// result. Look for where this function is called to understand.
Future<int> getHighScore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // '??' is Dart's null aware operator. The expression on the left is
  // returned unless it results to null. In that case, right side '0' is
  // returned.
  return prefs.getInt(HIGH_SCORE) ?? 0;
}

/// Updates the High Score saved for Snake game with the new [newHighScore].
Future<void> updateHighScore(int newHighScore) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(HIGH_SCORE, newHighScore);
}

/// Resets the High Score of Snake game back to 0.
Future<void> resetHighScore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(HIGH_SCORE, 0);
}
