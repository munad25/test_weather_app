import 'package:test_weather_app/feature/weather/domain/entities/current_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/hourly_weather.dart';

class TodayWeather {
  final CurrentWeather current;
  final List<HourlyWeather> hourly;

  const TodayWeather({
    required this.current,
    required this.hourly,
  });
}
