import 'package:weather_api/weather_api.dart';
import 'package:weather_repository/weather_repository.dart';

/// {@template weather_repository}
/// A repository that handles weather related requests.
/// {@endtemplate}
class WeatherRepository {
  /// {@macro weather_repository}
  WeatherRepository({WeatherApi? weatherApi})
      : _weatherApi = weatherApi ?? WeatherApi();

  final WeatherApi _weatherApi;
  
  /// 
  Future<Weather> getWeather(String city) async {
    final location = await _weatherApi.locationSearch(city);
    final woeid = location.woeid;
    final weather = await _weatherApi.getWeather(woeid);
    return weather;
  }
}
