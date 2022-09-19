import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

class CurrentWeather {
  final int dt;
  final double temp;
  final double wind_speed;
  final int humidity;
  final int clouds;
  final List<Weather> weather;

  const CurrentWeather({
    required this.dt,
    required this.temp,
    required this.wind_speed,
    required this.humidity,
    required this.weather,
    required this.clouds,
  });
}
