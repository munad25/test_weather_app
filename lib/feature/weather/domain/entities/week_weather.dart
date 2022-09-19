import 'package:test_weather_app/feature/weather/domain/entities/current_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';

class WeekWeather {
  final CurrentWeather current;
  final List<DailyWeather> daily;

  const WeekWeather({
    required this.current,
    required this.daily,
  });
}
