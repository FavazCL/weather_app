part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherRequested extends WeatherEvent {
  const WeatherRequested(
    this.location,
  );

  final String location;

  @override
  List<Object> get props => [location];
}

class UnitChanged extends WeatherEvent {
  const UnitChanged();
}

class CurrentWeatherChanged extends WeatherEvent {
    const CurrentWeatherChanged(
    this.id,
  );

  final int id;

  @override
  List<Object> get props => [id];
}
