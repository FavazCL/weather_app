part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState({
    this.weather,
    this.status = WeatherStatus.initial,
  });

  final WeatherStatus status;
  final Weather? weather;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weather,
      ];
}
