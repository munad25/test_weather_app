import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_weather_app/core/error/failure.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/week_weather.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_repository.dart';

class GetDailyWeatherNetworkUsecase implements Usecase<List<DailyWeather>, Position> {
  final WeatherRepository _repository;

  const GetDailyWeatherNetworkUsecase(this._repository);
  
  @override
  Future<Either<Failure, List<DailyWeather>>> call(Position params) {
    return _repository.getDailyWeather(params);
  }

}