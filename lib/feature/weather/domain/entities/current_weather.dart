import 'package:test_weather_app/feature/weather/domain/entities/abstract/abs_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

class CurrentWeather implements AbsWeather {
  // @override
  @override
  final int dt;
  final double temp;
  final double wind_speed;
  final int humidity;
  final int clouds;
  final List<Weather> weather;

   CurrentWeather({
    required this.dt,
    required this.temp,
    required this.wind_speed,
    required this.humidity,
    required this.weather,
    required this.clouds,
  });
  
}
