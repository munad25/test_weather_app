import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Weather {
  WeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() =>  _$WeatherModelToJson(this);
}
