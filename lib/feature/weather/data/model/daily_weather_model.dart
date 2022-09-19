import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/data/model/temperature_model.dart';
import 'package:test_weather_app/feature/weather/data/model/weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';

part 'daily_weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DailyWeatherModel extends DailyWeather {
  final List<WeatherModel> weather;
  final TemperatureModel temp;

  DailyWeatherModel({
    required super.dt,
    required super.clouds,
    required super.humidity,
    required super.wind_speed,
    required this.temp,
    required this.weather,
  }) : super(
          weather: weather,
          temp: temp,
        );

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) => _$DailyWeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$DailyWeatherModelToJson(this);
}
