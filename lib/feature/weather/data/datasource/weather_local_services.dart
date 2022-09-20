import 'package:get_storage/get_storage.dart';
import 'package:test_weather_app/feature/weather/data/model/daily_weather_model.dart';
import 'package:test_weather_app/feature/weather/data/model/today_weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';

abstract class WeatherLocalServices {
  factory WeatherLocalServices() = _WeatherLocalServices;

  Future<void> saveTodayWeatherData(TodayWeatherModel today);
  Future<TodayWeather?> getTodayWeatherData();
  Future<void> saveDailyWeatherData(List<DailyWeatherModel> data);
  Future<List<DailyWeather>?> getDailyWeatherData();
}

class _WeatherLocalServices implements WeatherLocalServices {
  final _storage = GetStorage();
  final _todayKey = 'today-data';
  final _dailyKey = 'daily-data';

  @override
  Future<void> saveTodayWeatherData(TodayWeatherModel today) async {
    await _storage.write(
      _todayKey,
      today.toJson(),
    );
  }

  @override
  Future<TodayWeather?> getTodayWeatherData() async {
    final data = await _storage.read(_todayKey);

    if (data != null) {
      return TodayWeatherModel.fromJson(data);
    }

    return null;
  }
  
  @override
  Future<void> saveDailyWeatherData(List<DailyWeatherModel> data) async {
    await _storage.write(_dailyKey, data.map((e) => e.toJson()).toList());
  }
  
  @override
  Future<List<DailyWeather>?> getDailyWeatherData() async {

    final data = await _storage.read(_dailyKey);

    if(data != null && data is List) {
      return data.map((e) => DailyWeatherModel.fromJson(e)).toList();
    }

    return null;
  }
}
