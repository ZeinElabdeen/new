import 'package:intl/intl.dart';

class TextHelper {
  String formatDate({DateTime date}) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String formatTime({DateTime date}) {
    String _formattedTime = DateFormat.Hm().format(date);
    return _formattedTime;
  }

  String formatDateTime({DateTime date}) {
    String _formattedTime = DateFormat.Hm().format(date);
    String _formattedDate = formatDate(date: date);
    return _formattedDate + ' ' + _formattedTime;
  }

  String name({String name}) {
    if (name.length < 10) {
      return name;
    } else {
      return ' .. ' + name.substring(0, 10);
    }
  }

  String nameProfile({String name}) {
    if (name.length < 20) {
      return name;
    } else {
      return ' .. ' + name.substring(0, 20);
    }
  }
}
