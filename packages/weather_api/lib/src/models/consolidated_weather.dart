import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:weather_api/src/models/json_map.dart';

part 'consolidated_weather.g.dart';

@immutable
@JsonSerializable()
class ConsolidatedWeather extends Equatable {
    ConsolidatedWeather({
        this.id,
        this.weatherStateName = '',
        this.weatherStateAbbr = '',
        this.windDirectionCompass = '',
        this.created,
        this.applicableDate,
        this.minTemp = 0,
        this.maxTemp = 0,
        this.theTemp = 0,
        this.windSpeed = 0,
        this.windDirection = 0,
        this.airPressure = 0,
        this.humidity = 0,
        this.visibility = 0,
        this.predictability = 0,
    });

    int? id;
    String weatherStateName;
    String weatherStateAbbr;
    String windDirectionCompass;
    DateTime? created;
    DateTime? applicableDate;
    double minTemp;
    double maxTemp;
    double theTemp;
    double windSpeed;
    double windDirection;
    double airPressure;
    int humidity;
    double visibility;
    int predictability;

  /// Returns a copy of this todo with the given values updated.
  ///
  /// {@macro todo}
  ConsolidatedWeather copyWith({
    int? id,
    String? weatherStateName,
    String? weatherStateAbbr,
    String? windDirectionCompass,
    DateTime? created,
    DateTime? applicableDate,
    DateTime? sunSet,
    double? minTemp,
    double? maxTemp,
    double? theTemp,
    double? windSpeed,
    double? windDirection,
    double? airPressure,
    int? humidity,
    double? visibility,
    int? predictability,
  }) {
    return ConsolidatedWeather(
      id: id ?? this.id,
      weatherStateName: weatherStateName ?? this.weatherStateName,
      weatherStateAbbr: weatherStateAbbr ?? this.weatherStateAbbr,
      windDirectionCompass: windDirectionCompass ?? this.windDirectionCompass,
      created: created ?? this.created,
      applicableDate: applicableDate ?? this.applicableDate,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      theTemp: theTemp ?? this.theTemp,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      airPressure: airPressure ?? this.airPressure,
      humidity: humidity ?? this.humidity,
      visibility: visibility ?? this.visibility,
      predictability: predictability ?? this.predictability,
    );
  }

  /// Deserializes the given [JsonMap] into a [Weather].
  static ConsolidatedWeather fromJson(JsonMap json) => _$ConsolidatedWeatherFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$ConsolidatedWeatherToJson(this);

  @override
  List<Object?> get props => [];

}
