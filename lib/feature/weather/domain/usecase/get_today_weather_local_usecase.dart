import 'package:test_weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_local_repository.dart';

class GetTodayWeatherLocalUsecase implements Usecase<TodayWeather, NoParams> {
  final WeatherLocalRepository _repository;
  
  const GetTodayWeatherLocalUsecase(this._repository);
  
  @override
  Future<Either<Failure, TodayWeather>> call(NoParams params) {
    return _repository.getTodayWeather();
  }

}