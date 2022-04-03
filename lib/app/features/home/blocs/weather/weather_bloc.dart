import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_api/weather_api.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherState()) {
    on<WeatherRequested>(_onWeatherRequested);
    on<UnitChanged>(_onUnitChanged);
    on<CurrentWeatherChanged>(_onCurrentWeatherChanged);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onWeatherRequested(
    WeatherRequested event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(status: WeatherStatus.loading));
      final response = await _weatherRepository.getWeather(event.location);

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: response,
          currentConsolidated: response.consolidatedWeather.first,
          isCelsius: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> _onUnitChanged(
    UnitChanged event,
    Emitter<WeatherState> emit,
  ) async {
    final consolidatedWeather = state.weather!.consolidatedWeather.map((e) {
      e.maxTemp =
          (state.isCelsius) ? toCelsius(e.maxTemp) : toFahrenheit(e.maxTemp);
      e.minTemp =
          (state.isCelsius) ? toCelsius(e.maxTemp) : toFahrenheit(e.maxTemp);
      e.theTemp =
          (state.isCelsius) ? toCelsius(e.maxTemp) : toFahrenheit(e.maxTemp);
      return e;
    }).toList();

    final weather = state.weather;
    weather!.consolidatedWeather = consolidatedWeather;

    emit(
      state.copyWith(
        isCelsius: !state.isCelsius,
        weather: weather,
        currentConsolidated: weather.consolidatedWeather.first,
      ),
    );
  }

  double toFahrenheit(double temp) => (temp * 9 / 5) + 32;
  double toCelsius(double temp) => (temp - 32) * 5 / 9;

  Future<void> _onCurrentWeatherChanged(
    CurrentWeatherChanged event,
    Emitter<WeatherState> emit,
  ) async {
    final currentWeather = state.weather!.consolidatedWeather
        .firstWhere((weather) => weather.id == event.id);

    emit(state.copyWith(currentConsolidated: currentWeather));
  }
}
