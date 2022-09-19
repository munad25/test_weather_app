import 'package:get_storage/get_storage.dart';
import 'package:test_weather_app/feature/weather/data/model/today_weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';

abstract class WeatherLocalServices {
  factory WeatherLocalServices() = _WeatherLocalServices;

  Future<void> saveTodayWeatherData(TodayWeatherModel today);
  Future<TodayWeather?> getTodayWeatherData();
}

class _WeatherLocalServices implements WeatherLocalServices {
  final _storage = GetStorage();
  final _todayKey = 'today-data';

  @override
  Future<void> saveTodayWeatherData(TodayWeatherModel today) async{
    await _storage.write(
      _todayKey,
      today.toJson(),
    );
  }
  
  @override
  Future<TodayWeather?> getTodayWeatherData() async {
    final data = await _storage.read(_todayKey);

    if(data != null) {
     return TodayWeatherModel.fromJson(data);
    }

    return null;
  }
}
