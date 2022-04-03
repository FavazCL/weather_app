// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsolidatedWeather _$ConsolidatedWeatherFromJson(Map<String, dynamic> json) =>
    ConsolidatedWeather(
      id: json['id'] as int,
      weatherStateName: json['weather_state_name'] as String,
      weatherStateAbbr:
          $enumDecode(_$WeatherStateEnumMap, json['weather_state_abbr']),
      created: DateTime.parse(json['created'] as String),
      applicableDate: DateTime.parse(json['applicable_date'] as String),
      minTemp: (json['min_temp'] as num).toDouble(),
      maxTemp: (json['max_temp'] as num).toDouble(),
      theTemp: (json['the_temp'] as num).toDouble(),
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windDirection: (json['wind_direction'] as num).toDouble(),
      airPressure: (json['air_pressure'] as num).toDouble(),
      humidity: json['humidity'] as int,
      visibility: (json['visibility'] as num).toDouble(),
      predictability: json['predictability'] as int,
    );

const _$WeatherStateEnumMap = {
  WeatherState.snow: 'sn',
  WeatherState.sleet: 'sl',
  WeatherState.hail: 'h',
  WeatherState.thunderstorm: 't',
  WeatherState.heavyRain: 'hr',
  WeatherState.lightRain: 'lr',
  WeatherState.showers: 's',
  WeatherState.heavyCloud: 'hc',
  WeatherState.lightCloud: 'lc',
  WeatherState.clear: 'c',
  WeatherState.unmarked: 'unmarked',
};
