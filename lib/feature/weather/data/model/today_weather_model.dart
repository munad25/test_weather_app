import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/data/model/current_weather_model.dart';
import 'package:test_weather_app/feature/weather/data/model/hourly_weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/hourly_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';

part 'today_weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TodayWeatherModel extends TodayWeather {
  final CurrentWeatherModel current;
  final List<HourlyWeatherModel> hourly;

  TodayWeatherModel({
    required this.current,
    required this.hourly,
  }) : super(
          current: current,
          hourly: hourly,
        );

  factory TodayWeatherModel.fromJson(Map<String, dynamic> json) => _$TodayWeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodayWeatherModelToJson(this);
}
