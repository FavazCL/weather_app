// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsolidatedWeather _$ConsolidatedWeatherFromJson(Map<String, dynamic> json) =>
    ConsolidatedWeather(
      id: json['id'] as int?,
      weatherStateName: json['weatherStateName'] as String? ?? '',
      weatherStateAbbr: json['weatherStateAbbr'] as String? ?? '',
      windDirectionCompass: json['windDirectionCompass'] as String? ?? '',
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      applicableDate: json['applicableDate'] == null
          ? null
          : DateTime.parse(json['applicableDate'] as String),
      minTemp: (json['minTemp'] as num?)?.toDouble() ?? 0,
      maxTemp: (json['maxTemp'] as num?)?.toDouble() ?? 0,
      theTemp: (json['theTemp'] as num?)?.toDouble() ?? 0,
      windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0,
      windDirection: (json['windDirection'] as num?)?.toDouble() ?? 0,
      airPressure: (json['airPressure'] as num?)?.toDouble() ?? 0,
      humidity: json['humidity'] as int? ?? 0,
      visibility: (json['visibility'] as num?)?.toDouble() ?? 0,
      predictability: json['predictability'] as int? ?? 0,
    );

Map<String, dynamic> _$ConsolidatedWeatherToJson(
        ConsolidatedWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weatherStateName': instance.weatherStateName,
      'weatherStateAbbr': instance.weatherStateAbbr,
      'windDirectionCompass': instance.windDirectionCompass,
      'created': instance.created?.toIso8601String(),
      'applicableDate': instance.applicableDate?.toIso8601String(),
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'theTemp': instance.theTemp,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'airPressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };
