import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:weather_api/src/models/consolidated_weather.dart';
import 'package:weather_api/src/models/json_map.dart';

part 'weather.g.dart';


@immutable
@JsonSerializable()
class Weather extends Equatable {
  
  Weather({
    this.consolidatedWeather = const [],
    this.time,
    this.sunRise,
    this.sunSet,
    this.timezoneName = '',
    this.title = '',
    this.locationType = '',
    this.woeid,
    this.lattLong = '',
    this.timezone = '',
  });

  final List<ConsolidatedWeather> consolidatedWeather;
  final DateTime? time;
  final DateTime? sunRise;
  final DateTime? sunSet;
  final String timezoneName;
  final String title;
  final String locationType;
  final int? woeid;
  final String lattLong;
  final String timezone;

  /// Returns a copy of this todo with the given values updated.
  ///
  /// {@macro todo}
  Weather copyWith({
    List<ConsolidatedWeather>? consolidatedWeather,
    DateTime? time,
    DateTime? sunRise,
    DateTime? sunSet,
    String? timezoneName,
    String? title,
    String? locationType,
    int? woeid,
    String? lattLong,
    String? timezone,
  }) {
    return Weather(
      consolidatedWeather: consolidatedWeather ?? this.consolidatedWeather,
      time: time ?? this.time,
      sunRise: sunRise ?? this.sunRise,
      sunSet: sunSet ?? this.sunSet,
      timezoneName: timezoneName ?? this.timezoneName,
      title: title ?? this.title,
      locationType: locationType ?? this.locationType,
      woeid: woeid ?? this.woeid,
      lattLong: lattLong ?? this.lattLong,
      timezone: timezone ?? this.timezone,
    );
  }

  /// Deserializes the given [JsonMap] into a [Weather].
  static Weather fromJson(JsonMap json) => _$WeatherFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => [];
}
