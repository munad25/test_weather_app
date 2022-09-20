import 'package:test_weather_app/feature/weather/domain/entities/abstract/abs_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

class HourlyWeather implements AbsWeather {
  final int dt;
  final int humidity;
  final double wind_speed;
  final int clouds;
  final double temp;
  final List<Weather> weather;

  const HourlyWeather({
    required this.dt,
    required this.humidity,
    required this.clouds,
    required this.wind_speed,
    required this.temp,
    required this.weather,
  });
  
}