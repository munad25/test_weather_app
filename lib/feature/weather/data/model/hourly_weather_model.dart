import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/data/model/weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/hourly_weather.dart';

part 'hourly_weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HourlyWeatherModel extends HourlyWeather {
  final List<WeatherModel> weather;
  HourlyWeatherModel({
    required super.dt,
    required super.temp,
    required this.weather,
  }) : super(weather: weather);


  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) => _$HourlyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherModelToJson(this);
}
