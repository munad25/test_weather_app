import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

abstract class AbsWeather {
 int get dt;
 int get clouds;
 int get humidity;
 double get temp;
 double get wind_speed;
 List<Weather> get weather;
}