import 'package:dartz/dartz.dart';
import 'package:test_weather_app/core/error/failure.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';

abstract class WeatherLocalRepository {
  Future<Either<Failure, TodayWeather>> getTodayWeather();
  Future<Either<Failure, List<DailyWeather>>> getDailyWeather();
}