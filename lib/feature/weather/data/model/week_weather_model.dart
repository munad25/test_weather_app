import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/data/model/current_weather_model.dart';
import 'package:test_weather_app/feature/weather/data/model/daily_weather_model.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/week_weather.dart';

part 'week_weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeekWeatherModel extends WeekWeather {

  final CurrentWeatherModel current;
  final List<DailyWeatherModel> daily;
  
  WeekWeatherModel({
    required this.current,
    required this.daily,
  }) : super(current: current, daily: daily);

  factory WeekWeatherModel.fromJson(Map<String, dynamic> json) => _$WeekWeatherModelFromJson(json);
  Map<String,dynamic> toJson() => _$WeekWeatherModelToJson(this);
}
