import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_weather_app/core/error/failure.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/week_weather.dart';
import 'package:test_weather_app/feature/weather/domain/schema/get_weather_schema.dart';

abstract class WeatherRepository {
  Future<Either<Failure, TodayWeather>> getTodayWeather(Position position);
  Future<Either<Failure, List<DailyWeather>>> getDailyWeather(Position position);
  
}