import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/data/model/weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/current_weather.dart';
part 'current_weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentWeatherModel extends CurrentWeather {

  @override
  final List<WeatherModel> weather;
  
  CurrentWeatherModel({
    required super.dt,
    required super.temp,
    required super.wind_speed,
    required super.humidity,
    required super.clouds,
    required this.weather,
  }) : super(weather: weather);

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => _$CurrentWeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);
}
