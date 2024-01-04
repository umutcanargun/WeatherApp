import 'package:weather_app/weather_model/daily_forecast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class WeatherRepository {
  Future<Weather> fetchCurrentWeather() async {
    Location location = new Location();
    LocationData _locationData;
    _locationData = await location.getLocation();

    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=ec7979dd0f8b4b6eba7102023232112&q=${_locationData.latitude},${_locationData.longitude}&days=7&aqi=no&alerts=no");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    final Weather weather = Weather.fromJson(jsonData);
    return weather;
  }

  Future<Weather> fetchStringWeather(String locationName) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=ec7979dd0f8b4b6eba7102023232112&q=${locationName}&days=7&aqi=no&alerts=no");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    final Weather weather = Weather.fromJson(jsonData);
    return weather;
  }
}
