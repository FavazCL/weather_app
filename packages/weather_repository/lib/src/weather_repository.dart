import 'package:weather_api/weather_api.dart';
import 'package:weather_repository/weather_repository.dart';


/// A repository that handles weather related requests.
class WeatherRepository {
  /// Constructor of [WeatherRepository] class
  WeatherRepository({WeatherApi? weatherApi})
      : _weatherApi = weatherApi ?? WeatherApi();

  final WeatherApi _weatherApi;
  
  /// Function that return a Future of [Weather] class
  Future<Weather> getWeather(String city) async {
    final location = await _weatherApi.locationSearch(city);
    final woeid = location.woeid;
    final weather = await _weatherApi.getWeather(woeid);
    return weather;
  }
}
