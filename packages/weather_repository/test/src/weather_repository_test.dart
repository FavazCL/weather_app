// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherApi extends Mock
    implements WeatherApi {}

class MockLocation extends Mock implements Location {}

class MockWeather extends Mock implements Weather {}

void main() {
  group('WeatherRepository', () {
    late WeatherApi weatherApi;
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherApi = MockWeatherApi();
      weatherRepository = WeatherRepository(
        weatherApi: weatherApi,
      );
    });

    group('Check injection', () {
      test('check if WeatherRepository is injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const city = 'berlin';
      const woeid = 638242;

      test('Get location with the current city', () async {
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => weatherApi.locationSearch(city)).called(1);
      });

      test('throws when locationSearch fails', () async {
        final exception = Exception();
        when(() => weatherApi.locationSearch(any()))
            .thenThrow(exception);
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('call GET getWeather with the current woeid', () async {
        final location = MockLocation();
        when(() => location.woeid).thenReturn(woeid);
        when(() => weatherApi.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => weatherApi.getWeather(woeid)).called(1);
      });

      test('throws when getWeather fails', () async {
        final exception = Exception();
        final location = MockLocation();
        when(() => location.woeid).thenReturn(woeid);
        when(() => weatherApi.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(() => weatherApi.getWeather(any())).thenThrow(exception);
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });
    });
  });
}
