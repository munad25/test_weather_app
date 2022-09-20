import 'package:test_weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_local_repository.dart';

class GetDailyWeatherLocalUsecase implements Usecase<List<DailyWeather>, NoParams> {
  final WeatherLocalRepository _repository;

  const GetDailyWeatherLocalUsecase(this._repository);
  
  @override
  Future<Either<Failure, List<DailyWeather>>> call(NoParams params) {
    return _repository.getDailyWeather();
  }

}