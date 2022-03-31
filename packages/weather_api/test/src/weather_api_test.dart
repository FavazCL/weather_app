// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart';

void main() {
  group('WeatherApi', () {
    test('can be instantiated', () {
      expect(WeatherApi(), isNotNull);
    });
  });
}
