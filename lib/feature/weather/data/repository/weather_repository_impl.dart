import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_weather_app/core/utils/local_data.dart';
import 'package:test_weather_app/feature/weather/data/datasource/weather_local_services.dart';
import 'package:test_weather_app/feature/weather/data/datasource/weather_network_services.dart';
import 'package:test_weather_app/feature/weather/data/model/daily_weather_model.dart';
import 'package:test_weather_app/feature/weather/data/model/today_weather_model.dart';
import 'package:test_weather_app/feature/weather/data/model/week_weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_weather_app/feature/weather/domain/entities/week_weather.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_repository.dart';
import 'package:test_weather_app/feature/weather/domain/schema/get_weather_schema.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherNetworkSerices _networkServices;
  final WeatherLocalServices _localServices;
  final _localData = LocalData();

  WeatherRepositoryImpl(this._networkServices, this._localServices);

  @override
  Future<Either<Failure, TodayWeather>> getTodayWeather(
      Position position) async {
    try {
      final queries = GetWeatherSchema(
        lat: position.latitude,
        lon: position.longitude,
        exclude: ['daily', 'minutely'],
      );

      final response = await _networkServices.getWeatherData(queries.build());
      final todayWeather = TodayWeatherModel.fromJson(response.data);
      await _localData.setLatestUpdate(DateTime.now());
      await _localServices.saveTodayWeatherData(todayWeather);
      return Right(todayWeather);
    } on DioError catch (err) {
      return const Left(
        Failure(
          code: 'S8DY621U',
          message: 'Getting data failed',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<DailyWeather>>> getDailyWeather(
      Position position) async {
    try {
      final queries = GetWeatherSchema(
        lat: position.latitude,
        lon: position.longitude,
        exclude: ['hourly', 'minutely', 'current'],
      );

      final response = await _networkServices.getWeatherData(queries.build());
      await _localData.setLatestUpdate(DateTime.now());
      final List<dynamic> rawData = response.data['daily'] ?? [];
      final dailyWeather = rawData.map((e) => DailyWeatherModel.fromJson(e)).toList();

      _localServices.saveDailyWeatherData(dailyWeather);
      return Right(dailyWeather);
    } on DioError catch (err) {
      return const Left(
        Failure(
          message: 'Failed getting data',
          code: '7SDW0WHY',
        ),
      );
    }
  }
}
