import 'package:intl/intl.dart';

class DateService {
  String getDuration(int start, int stop) {
    DateTime stt = DateTime.fromMillisecondsSinceEpoch(start);
    DateTime stp = DateTime.fromMillisecondsSinceEpoch(stop);

    Duration dd = stt.difference(stp);

    String dudu = "";

    double days = dd.inDays.abs().toDouble();

    int yearCount = int.parse((days / 360).toStringAsFixed(0));
    if (yearCount > 0) {
      dudu = "$yearCount year${yearCount > 1 ? "s" : ""}";
    }

    days = days - (yearCount * 360);

    int monthCount = int.parse((days / 30).toStringAsFixed(0));
    if (monthCount > 0) {
      dudu = "$dudu $monthCount month${monthCount > 1 ? "s" : ""}";
    }

    days = days - (monthCount * 30);

    int dayCount = days.toInt();
    if (days > 0) {
      dudu = "$dudu $dayCount day${dayCount > 1 ? "s" : ""}";
    }

    return dudu;
  }

  String getCoolTime(int milliseconds) {
    final now = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    DateTime guy = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    String day =
        now.day == guy.day && now.month == guy.month && now.year == guy.year
            ? "Today"
            : yesterday.day == guy.day &&
                    yesterday.month == guy.month &&
                    yesterday.year == guy.year
                ? "Yesterday"
                : tomorrow.day == guy.day &&
                        tomorrow.month == guy.month &&
                        tomorrow.year == guy.year
                    ? "Tomorrow"
                    : dateFromMilliseconds(milliseconds);

    String time = timeIn24Hours(milliseconds);

    return "$day at $time";
  }

  datewithoutFirstWords(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    String rest = DateFormat.yMMMd().format(dt);

    return rest;
  }

  Map getWeekCountMap(int to, int from) {
    bool past = to < from;

    Duration dd = DateTime.fromMillisecondsSinceEpoch(from).difference(
      DateTime.fromMillisecondsSinceEpoch(to),
    );

    double days = dd.inDays.abs().toDouble();
    double weekCount = days / 7;

    return {
      "weeks": int.parse(weekCount.toStringAsFixed(0)),
      "past": past,
    };
  }

  String dateFromMilliseconds(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    String day = DateFormat.E().format(dt);
    String rest = DateFormat.yMMMd().format(dt);

    String concat = "$day $rest";
    return concat;
  }

  int convertMillisecondsToNightCount(int milliseconds) {
    double dd = milliseconds / (24 * 60 * 60 * 1000);

    return dd.toInt();
  }

  String dateInNumbers(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('EEEE d LLLL, y').format(dt);

    return formattedTime;
  }

  String timeIn24Hours(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('HH:mm').format(dt);

    return formattedTime;
  }

  String monthInText(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('LLLL').format(dt);

    return formattedTime;
  }

  String dayNumberInText(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('d').format(dt);

    return formattedTime;
  }
}
