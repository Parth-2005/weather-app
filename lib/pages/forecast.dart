import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/Models/model.dart';
import 'package:weather/apiServices/ApiServices.dart';
import 'package:weather/components/weatherWidget.dart';

class Forecast extends StatefulWidget {
  cityData? city;
  Forecast(this.city, {super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  late Future<List<forecastWeatherData>> weather;

  @override
  void initState() {
    if (widget.city != null) {
      if (widget.city!.latitude != null && widget.city!.longitude != null) {
        weather = ApiServices().getForecastWeather(widget.city!.latitude, widget.city!.longitude);
      }
    }
    else {
      weather = ApiServices().getForecastWeather(null, null);
    }
    super.initState();
  }

  late final SharedPreferences prefs;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<forecastWeatherData>> getWeatherListData() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getStringList('forecast_weather');
    if (json != null) {
      var data = json.map((e) => forecastWeatherData.fromJson(jsonDecode(e))).toList();
      return data;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(5, 20, 5, 60),
        child: FutureBuilder(
            future: weather,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                              for (var weather in snapshot.data!) weatherWidget(weather),
                            ]);
              }
              return FutureBuilder(
                  future: getWeatherListData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                                          for (var weather in snapshot.data!) weatherWidget(weather),
                                        ]);
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            }),
      ),
    );
  }
}
