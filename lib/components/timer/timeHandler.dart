import 'package:shared_preferences/shared_preferences.dart';

class TimeHandler {
  final int numberOfDays = 3;

  Future<int> getCurrentDayIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int storedIndex = prefs.getInt('dayIndex') ?? 1;
    final String lastDate = prefs.getString('lastDate') ?? '';

    final String currentDate =
        DateTime.now().toIso8601String().substring(0, 10);

    if (lastDate != currentDate) {
      print('New day, resetting index $storedIndex ');
      final int newIndex = (storedIndex % numberOfDays) + 1;

      await prefs.setInt('dayIndex', newIndex);
      await prefs.setString('lastDate', currentDate);

      return newIndex;
    } else {
      return storedIndex;
    }
  }
}
