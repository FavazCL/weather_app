part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState({
    this.weather,
    this.currentConsolidated,
    this.status = WeatherStatus.initial,
    this.isCelsius = true,
  });

  final WeatherStatus status;
  final Weather? weather;
  final ConsolidatedWeather? currentConsolidated;
  final bool isCelsius;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    ConsolidatedWeather? currentConsolidated,
    bool? isCelsius,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      currentConsolidated: currentConsolidated ?? this.currentConsolidated,
      isCelsius: isCelsius ?? this.isCelsius,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weather,
        currentConsolidated,
        isCelsius,
      ];
}
