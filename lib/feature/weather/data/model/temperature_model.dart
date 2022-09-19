import 'package:json_annotation/json_annotation.dart';
import 'package:test_weather_app/feature/weather/domain/entities/temperature.dart';

part 'temperature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemperatureModel extends Temperature {
  TemperatureModel({
    required super.day,
    required super.min,
    required super.max,
    required super.night,
    required super.eve,
    required super.morn,
  });

factory TemperatureModel.fromJson(Map<String, dynamic> json) => _$TemperatureModelFromJson(json);
Map<String, dynamic> toJson() => _$TemperatureModelToJson(this);
}
