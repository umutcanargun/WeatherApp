import 'package:weather_app/weather_model/daily_forecast.dart';
import 'package:weather_app/weather_repository/weather_repository.dart';
import 'package:weather_app/weather_bloc/weather_event.dart';
import 'package:weather_app/weather_bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldtime/worldtime.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final _worldtimePlugin = Worldtime();
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<currentWeather>(_currentWeather);
    on<stringWeather>(_stringWeather);
  }
  void _currentWeather(currentWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final Weather weather = await weatherRepository.fetchCurrentWeather();

      final DateTime weatherDate = await _worldtimePlugin.timeByLocation(
          latitude: weather.location.lat, longitude: weather.location.lon);
      emit(WeatherLoaded(weather: weather, weatherTime: weatherDate));
    } catch (e) {
      emit(WeatherError());
    }
  }

  void _stringWeather(stringWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final Weather weather =
          await weatherRepository.fetchStringWeather(event.query);
      final DateTime weatherDate = await _worldtimePlugin.timeByLocation(
          latitude: weather.location.lat, longitude: weather.location.lon);
      emit(WeatherLoaded(weather: weather, weatherTime: weatherDate));
    } catch (e) {
      emit(WeatherError());
    }
  }
}
