import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';
import 'package:weather_app/weather_bloc/weather_event.dart';
import 'package:weather_app/weather_bloc/weather_state.dart';
import 'package:weather_app/weather_model/daily_forecast.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 48, 48, 255),
        body: Center(
          child: SingleChildScrollView(child:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherInitial) {
              context.read<WeatherBloc>().add(currentWeather());
              return const Center(
                  child: Text(
                "Data is being requested....",
                style: TextStyle(fontFamily: 'ClearSans'),
              ));
            }
            if (state is WeatherLoading) {
              return CircularProgressIndicator();
            }

            if (state is WeatherLoaded) {
              Weather _weather = state.weather;
              Current weatherNow = _weather.current;

              List<Hour> hourlyForecast = [];

              final now = state.weatherTime;

              if (now.hour > 0) {
                for (int i = now.hour; i < 24; i++) {
                  hourlyForecast.add(_weather.forecast.forecastday[0].hour[i]);
                }
                for (int i = 0; i <= now.hour; i++) {
                  hourlyForecast.add(_weather.forecast.forecastday[1].hour[i]);
                }
              } else {
                for (int i = 0; i < 24; i++) {
                  hourlyForecast.add(_weather.forecast.forecastday[0].hour[i]);
                }
              }

              List<Forecastday> dailyForecast = [];
              for (int i = 0; i <= 6; i++) {
                dailyForecast.add(_weather.forecast.forecastday[i]);
              }
              final myController = TextEditingController();
              return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(Icons.place, color: Colors.white),
                              Text(_weather.location.name,
                                  style: TextStyle(
                                      fontFamily: 'ClearSans',
                                      color: Colors.white,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('Current Weather:',
                          style: TextStyle(
                              fontFamily: 'ClearSans',
                              color: Colors.white,
                              fontSize: 20)),
                      SizedBox(
                        height: 180,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 255, 255, 255))),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                    'assets/images/${weatherNow.condition.code}.png',
                                    width: 128,
                                    height: 128),
                                SizedBox(height: 10),
                                Text(
                                    weatherNow.tempC.toString() +
                                        " \u2103" +
                                        ' - ' +
                                        weatherNow.condition.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'ClearSans',
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('24-Hour Forecast:',
                          style: TextStyle(
                              fontFamily: 'ClearSans',
                              color: Colors.white,
                              fontSize: 20)),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 25);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: hourlyForecast.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255))),
                              child: Column(
                                children: [
                                  Text(hourlyForecast[index].time,
                                      style: TextStyle(
                                          fontFamily: 'ClearSans',
                                          color: Colors.white)),
                                  Image.asset(
                                      'assets/images/${hourlyForecast[index].condition.code}.png',
                                      width: 128,
                                      height: 128),
                                  Text(
                                      hourlyForecast[index].tempC.toString() +
                                          " \u2103",
                                      style: TextStyle(
                                          fontFamily: 'ClearSans',
                                          color: Colors.white))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('7-Day Forecast:',
                          style: TextStyle(
                              fontFamily: 'ClearSans',
                              color: Colors.white,
                              fontSize: 20)),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 25,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: dailyForecast.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255))),
                                  child: Column(
                                    children: [
                                      Text(dailyForecast[index].date,
                                          style: TextStyle(
                                              fontFamily: 'ClearSans',
                                              color: Colors.white)),
                                      Image.asset(
                                          'assets/images/${dailyForecast[index].day.condition?.code}.png',
                                          width: 128,
                                          height: 128),
                                      Text(
                                          dailyForecast[index]
                                                  .day
                                                  .maxtempC
                                                  .toString() +
                                              " \u2103",
                                          style: TextStyle(
                                              fontFamily: 'ClearSans',
                                              color: Colors.white)),
                                      Text(
                                          dailyForecast[index]
                                                  .day
                                                  .mintempC
                                                  .toString() +
                                              " \u2103",
                                          style: TextStyle(
                                              fontFamily: 'ClearSans',
                                              color: Colors.white))
                                    ],
                                  ));
                            }),
                      ),
                      const SizedBox(height: 30),
                      Text('Search For Location:',
                          style: TextStyle(
                              fontFamily: 'ClearSans',
                              color: Colors.white,
                              fontSize: 20)),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ClearSans'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                                controller: myController,
                              ),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                context
                                    .read<WeatherBloc>()
                                    .add(stringWeather(myController.text));
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                context
                                    .read<WeatherBloc>()
                                    .add(currentWeather());
                              },
                              child: Icon(
                                Icons.refresh,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ));
            }

            if (state is WeatherError) {
              return const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Data fetch is failed!!",
                    style: TextStyle(
                        fontFamily: 'ClearSans',
                        color: Colors.white,
                        fontSize: 20),
                  ));
            }

            return const Center(
              child: Text("Unknown State",
                  style: TextStyle(
                      fontFamily: 'ClearSans',
                      color: Colors.white,
                      fontSize: 20)),
            );
          })),
        ));
  }
}
