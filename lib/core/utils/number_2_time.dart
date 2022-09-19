import 'package:calendar_time/calendar_time.dart';
import 'package:intl/intl.dart';
import 'package:test_weather_app/core/error/failure.dart';

enum TimeType{
  hours,
  date,
  day,
}

String number2Time({ required int number, required TimeType type}) {

  switch (type) {
    case TimeType.hours:
      return DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(number * 1000, isUtc: false));
    case TimeType.date:
      final date = DateTime.fromMillisecondsSinceEpoch(number * 1000);
      final day = CalendarTime(date);
      final dayLable = day.isToday ? 'Today' : day.isTomorrow ? 'Tomorrow' : DateFormat('E').format(date); 
      return DateFormat('$dayLable, dd MM yyyy').format(DateTime.fromMillisecondsSinceEpoch(number * 1000));
    case TimeType.day:
      final date = DateTime.fromMillisecondsSinceEpoch(number * 1000, isUtc: true);
      final day = CalendarTime(date);
      return day.isToday ? 'Today' : day.isTomorrow ? 'Tomorrow' : DateFormat('E').format(date); 
    default:
      throw const Failure(message: 'Type undefined', code: 'SDFIWE');
  }
  
} 