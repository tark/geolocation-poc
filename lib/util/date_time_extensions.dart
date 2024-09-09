import 'package:geolocation_poc/util/format_util.dart';

import 'date_util.dart';

extension DateTimeExtensions on DateTime {
  bool isBeforeOrEqual(DateTime date) {
    return isBefore(date) || isAtSameMomentAs(date);
  }

  bool isAfterOrEqual(DateTime date) {
    return isAfter(date) || isAtSameMomentAs(date);
  }

  DateTime subtractMonth() {
    if (month == 1) {
      return DateTime(year - 1, 12, day);
    }
    return DateTime(year, month - 1, day);
  }

  DateTime addMonth() {
    if (month == 12) {
      return DateTime(year + 1, 1, day);
    }
    return DateTime(year, month + 1, day);
  }

  DateTime subtractYear() {
    return DateTime(year - 1, month, day);
  }

  DateTime addYear() {
    return DateTime(year + 1, month, day);
  }

  bool isToday() {
    return DateTime.now().startOfDay() == startOfDay();
  }

  bool isYesterday() {
    return DateTime.now().subtract(const Duration(days: 1)).startOfDay() ==
        startOfDay();
  }

  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day).add(const Duration(days: 1));
  }

  bool isPreviousWeek() {
    return add(const Duration(days: 7)).isCurrentWeek();
  }

  bool isCurrentWeek() {
    return isAfterOrEqual(startOfCurrentWeek()) &&
        isBeforeOrEqual(endOfCurrentWeek());
  }

  bool isCurrentMonth() {
    return DateTime.now().month == month && DateTime.now().year == year;
  }

  bool isCurrentYear() {
    return DateTime.now().year == year;
  }

  String formatYYYYMMDD() {
    return dateFormatter.format(this);
  }
}
