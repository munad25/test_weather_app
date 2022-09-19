import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

class HourlyWeather {
  final int dt;
  final double temp;
  final List<Weather> weather;

  const HourlyWeather({
    required this.dt,
    required this.temp,
    required this.weather,
  });
}