import 'package:json_annotation/json_annotation.dart';
import 'package:weather_api/src/models/consolidated_weather.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Weather({
    required this.consolidatedWeather,
    required this.time,
    required this.title, 
    required this.woeid,
  });

  List<ConsolidatedWeather> consolidatedWeather;
  final DateTime time;
  final String title;
  final int woeid;


  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
