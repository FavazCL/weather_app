import 'package:json_annotation/json_annotation.dart';
import 'package:weather_api/src/models/lat_lng.dart';
import 'package:weather_api/src/models/lat_lng_converter.dart';

part 'location.g.dart';

enum LocationType {
  @JsonValue('City')
  city,
  @JsonValue('Region')
  region,
  @JsonValue('State')
  state,
  @JsonValue('Province')
  province,
  @JsonValue('Country')
  country,
  @JsonValue('Continent')
  continent
}

@JsonSerializable()
class Location {
  const Location({
    required this.title,
    required this.locationType,
    required this.latLng,
    required this.woeid,
  });

  final String title;
  @JsonKey(name: 'location_type')
  final LocationType locationType;
  @JsonKey(name: 'latt_long')
  @LatLngConverter()
  final LatLng latLng;
  final int woeid;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}