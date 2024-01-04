abstract class WeatherEvent {}

class currentWeather extends WeatherEvent {}

class stringWeather extends WeatherEvent {
  final String query;

  stringWeather(this.query);
}
