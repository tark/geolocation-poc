import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:geolocation_poc/util/date_time_extensions.dart';

import 'log.dart';

final dateFormatterDay = DateFormat('d MMMM');
final dayFormatter = DateFormat('d');
final monthFormatter = DateFormat('MMMM');
final yearFormatter = DateFormat('yyyy');

DateTime startOfCurrentYear() {
  return DateTime(DateTime.now().year);
}

DateTime endOfCurrentYear() {
  return DateTime(DateTime.now().year + 1);
}

DateTime startOfCurrentMonth() {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
}

DateTime endOfCurrentMonth() {
  final now = DateTime.now();
  return now.month == 12
      ? DateTime(now.year + 1, 1)
      : DateTime(now.year, now.month + 1);
}

DateTime startOfCurrentWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day)
      .subtract(Duration(days: now.weekday - 1));
}

DateTime endOfCurrentWeek() {
  return startOfCurrentWeek().add(const Duration(days: 7));
}

DateTime startOfPreviousWeek() {
  final weekAgo = DateTime.now().subtract(const Duration(days: 7));
  return DateTime(weekAgo.year, weekAgo.month, weekAgo.day)
      .subtract(Duration(days: weekAgo.weekday - 1));
}

DateTime endOfPreviousWeek() {
  final weekAgo = DateTime.now().subtract(const Duration(days: 7));
  return DateTime(weekAgo.year, weekAgo.month, weekAgo.day)
      .add(Duration(days: 7 - weekAgo.weekday));
}

DateTime startOfToday() {
  return DateTime.now().startOfDay();
}

DateTime endOfToday() {
  return DateTime.now().add(const Duration(days: 1)).startOfDay();
}

bool isCurrentWeek(DateTime dateTime) {
  return !dateTime.isBefore(startOfCurrentWeek()) &&
      !dateTime.isAfter(endOfCurrentWeek());
}

bool isToday(DateTime date) {
  final now = DateTime.now();
  return startOfDayForDate(now) == startOfDayForDate(date);
}

bool isYesterday(DateTime date) {
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  return startOfDayForDate(yesterday) == startOfDayForDate(date);
}

DateTime startOfDay(String? dateString) {
  final date = DateTime.parse(dateString ?? '');
  return DateTime(date.year, date.month, date.day);
}

DateTime startOfDayForDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

bool sameDay(DateTime dateOne, DateTime dateTwo) {
  return dateOne.year == dateTwo.year &&
      dateOne.month == dateTwo.month &&
      dateOne.day == dateTwo.day;
}

String formatDate({required DateTime? datetime, required String? dateFormat}) {
  return (datetime != null && dateFormat != null)
      ? DateFormat(dateFormat).format(datetime)
      : '';
}

bool isDateYesterday(DateTime dateTime) {
  final now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime testDate =
      DateTime(dateTime.year, dateTime.month, dateTime.day);
  return today.difference(testDate).inDays == 1;
}

bool isPeriodToday(DateTime from, DateTime to) {
  return from == startOfToday() && to == endOfToday();
}

bool isPeriodYesterday(DateTime from, DateTime to) {
  return from == yesterday().startOfDay() && to == yesterday().endOfDay();
}

bool isPeriodThisWeek(DateTime from, DateTime to) {
  return from == startOfCurrentWeek() && to == endOfCurrentWeek();
}

bool isPeriodPreviousWeek(DateTime from, DateTime to) {
  return from == startOfPreviousWeek() && to == endOfPreviousWeek();
}

bool isPeriodThisMonth(DateTime from, DateTime to) {
  return from == startOfCurrentMonth() && to == endOfCurrentMonth();
}

bool isPeriodThisYear(DateTime from, DateTime to) {
  return from.year == DateTime.now().year &&
      from.month == 1 &&
      from.day == 1 &&
      to == from.addYear();
}

DateTime tomorrow() {
  return DateTime.now().add(const Duration(days: 1));
}

DateTime yesterday() {
  return DateTime.now().subtract(const Duration(days: 1));
}

String periodName(DateTime? from, DateTime? to) {
  if (from == null && to == null) {
    return 'unknown_period'.tr();
  }

  if (from == null && to != null) {
    return 'to_date'.tr(args: [dateFormatterDay.format(to)]);
  }

  if (from != null && to == null) {
    return 'from_date'.tr(args: [dateFormatterDay.format(from)]);
  }

  if (from == null || to == null) {
    return 'unknown_period'.tr();
  }

  if (isPeriodToday(from, to)) {
    return 'today'.tr();
  }

  if (isPeriodYesterday(from, to)) {
    return 'yesterday'.tr();
  }

  if (from == from.startOfDay() && to == from.endOfDay()) {
    return dateFormatterDay.format(from);
  }

  if (isPeriodThisWeek(from, to)) {
    return 'this_week'.tr();
  }

  if (isPeriodPreviousWeek(from, to)) {
    return 'last_week'.tr();
  }

  if (from.weekday == 1 && to == from.add(const Duration(days: 7))) {
    if (from.month == to.month) {
      return '${dayFormatter.format(from)}-${dayFormatter.format(to)} ${monthFormatter.format(from)}';
    } else {
      return '${dateFormatterDay.format(from)} - ${dateFormatterDay.format(to)}';
    }
  }

  if (isPeriodThisMonth(from, to)) {
    return 'this_month'.tr();
  }

  if (from.day == 1 && to == from.addMonth()) {
    return monthFormatter.format(from);
  }

  if (isPeriodThisYear(from, to)) {
    return 'this_year'.tr();
  }

  if (from.month == 1 && from.day == 1 && to == from.addYear()) {
    return yearFormatter.format(from);
  }

  return '${dateFormatterDay.format(from)} - ${dateFormatterDay.format(to)}';
}
