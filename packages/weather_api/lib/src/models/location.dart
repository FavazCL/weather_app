import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()

/// Location class
class Location {
  /// Constructor of [Location] class
  const Location({
    required this.title,
    required this.woeid,
  });

  /// Function to parse from json to [Location] class
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Title of the current location
  final String title;

  /// Identifier of the current location
  final int woeid;
}
