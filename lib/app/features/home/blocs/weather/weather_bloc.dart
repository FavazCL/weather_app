import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherState()) {
    on<WeatherRequested>(_onWeatherRequested);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onWeatherRequested(
    WeatherRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    final response = await _weatherRepository.getWeather('london');

    if (response != null) {
      emit(state.copyWith(status: WeatherStatus.success, weather: response));
    } else {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }
}
