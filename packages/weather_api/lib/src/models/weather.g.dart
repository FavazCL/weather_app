// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      consolidatedWeather: (json['consolidatedWeather'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      sunRise: json['sunRise'] == null
          ? null
          : DateTime.parse(json['sunRise'] as String),
      sunSet: json['sunSet'] == null
          ? null
          : DateTime.parse(json['sunSet'] as String),
      timezoneName: json['timezoneName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      locationType: json['locationType'] as String? ?? '',
      woeid: json['woeid'] as int?,
      lattLong: json['lattLong'] as String? ?? '',
      timezone: json['timezone'] as String? ?? '',
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'consolidatedWeather': instance.consolidatedWeather,
      'time': instance.time?.toIso8601String(),
      'sunRise': instance.sunRise?.toIso8601String(),
      'sunSet': instance.sunSet?.toIso8601String(),
      'timezoneName': instance.timezoneName,
      'title': instance.title,
      'locationType': instance.locationType,
      'woeid': instance.woeid,
      'lattLong': instance.lattLong,
      'timezone': instance.timezone,
    };
