import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_weather_app/core/error/failure.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_repository.dart';

class GetTodayWeatherNetworkUsecase implements Usecase<TodayWeather, Position> {
  final WeatherRepository _repository;

  const GetTodayWeatherNetworkUsecase(this._repository);
  
  @override
  Future<Either<Failure, TodayWeather>> call(Position params) {
    return _repository.getTodayWeather(params);
  }

}