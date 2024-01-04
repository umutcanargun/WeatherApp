import 'package:weather_app/weather_model/daily_forecast.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final DateTime weatherTime;

  WeatherLoaded({required this.weather, required this.weatherTime});
}

class WeatherError extends WeatherState {}
