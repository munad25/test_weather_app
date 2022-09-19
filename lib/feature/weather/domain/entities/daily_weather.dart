import 'package:test_weather_app/feature/weather/domain/entities/temperature.dart';
import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

class DailyWeather {
  final int dt;
  final Temperature temp;
  final int humidity;
  final double wind_speed;
  final int clouds;
  final List<Weather> weather;

  const DailyWeather({
    required this.dt,
    required this.temp,
    required this.weather,
    required this.humidity,
    required this.clouds,
    required this.wind_speed,
  });

}