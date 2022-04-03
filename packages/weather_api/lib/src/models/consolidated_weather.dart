import 'package:json_annotation/json_annotation.dart';

part 'consolidated_weather.g.dart';

/// Enums to describe the weather states
enum WeatherState {
  @JsonValue('sn')

  /// sn means Snow state
  snow,
  @JsonValue('sl')

  /// sl means Sleet state
  sleet,
  @JsonValue('h')

  /// h means Hail state
  hail,
  @JsonValue('t')

  /// t means Thunderstorm state
  thunderstorm,
  @JsonValue('hr')

  /// hr means HeavyRain state
  heavyRain,
  @JsonValue('lr')

  /// lr means LightRain state
  lightRain,
  @JsonValue('s')

  /// s means Showers state
  showers,
  @JsonValue('hc')

  /// hc means HeavyCloud state
  heavyCloud,
  @JsonValue('lc')

  /// lc means LightCloud state
  lightCloud,
  @JsonValue('c')

  /// c means Clear
  clear,

  /// Unmarked when state is unkown
  unmarked,
}

@JsonSerializable()

/// Class for Consolidated Weather
class ConsolidatedWeather {
  /// Constructor of the class
  ConsolidatedWeather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  /// Function to parse from json to [ConsolidatedWeather] class
  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedWeatherFromJson(json);

  /// Identifier of consolidated weather
  final int id;

  /// Name of the weather state
  final String weatherStateName;

  /// Abbreviation of weather state
  final WeatherState weatherStateAbbr;

  /// Date when this object was created.
  final DateTime created;

  /// Date that specify the real date for specific weather.
  final DateTime applicableDate;

  /// Min temperature
  double minTemp;

  /// Max temperature
  double maxTemp;

  /// Current temperature
  double theTemp;

  /// Speed of wind
  final double windSpeed;

  /// Direction of wind
  final double windDirection;

  /// Pressure of air
  final double airPressure;

  /// Current humidity
  final int humidity;

  /// Current visibility
  final double visibility;

  /// Current predictability
  final int predictability;
}
