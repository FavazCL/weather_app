// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      consolidatedWeather: (json['consolidated_weather'] as List<dynamic>)
          .map(
            (dynamic e) => ConsolidatedWeather.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      time: DateTime.parse(json['time'] as String),
      title: json['title'] as String,
      woeid: json['woeid'] as int,
    );
