import 'package:flutter/material.dart';
import 'package:weather_app/weather_repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';
import 'package:weather_app/weather_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(
        weatherRepository: WeatherRepository(),
      ),
    ),
  ], child: const MaterialApp(home: WeatherPage())));
}
