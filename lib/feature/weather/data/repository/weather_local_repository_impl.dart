import 'package:test_weather_app/feature/weather/data/datasource/weather_local_services.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_local_repository.dart';

class WeatherLocalRepositoryImpl implements WeatherLocalRepository {
  final WeatherLocalServices _services;

  const WeatherLocalRepositoryImpl(this._services);

  @override
  Future<Either<Failure, List<DailyWeather>>> getDailyWeather() async {
    try {
      final result = await _services.getDailyWeatherData();

      if (result != null) {
        return Right(result);
      }

      return const Left(
        Failure(message: 'Local data is empty', code: 'SD87WEYT'),
      );
    } catch (err) {
      return const Left(
        Failure(message: 'Local data is empty', code: 'KJHSD72I'),
      );
    }
  }

  @override
  Future<Either<Failure, TodayWeather>> getTodayWeather() async {
    try {
      final result = await _services.getTodayWeatherData();

      if(result != null) {
        return Right(result);
      }

      return const Left(
        Failure(message: 'Local data is empty', code: 'SAS3HU0T'),
      );
      
    } catch(err) {
      return const Left(
        Failure(message: 'Local data is empty', code: 'ASD1AS9Y'),
      );
    }
  }
}
