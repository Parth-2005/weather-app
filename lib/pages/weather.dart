import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/Models/model.dart';
import 'package:weather/apiServices/ApiServices.dart';
import 'package:weather/components/currentWeatherWidget.dart';
import 'package:weather/components/forecastRedirectBTN.dart';

class currentWeather extends StatefulWidget {
  cityData? city;
  currentWeather(this.city, {super.key});

  @override
  State<currentWeather> createState() => _currentWeatherState();
}

class _currentWeatherState extends State<currentWeather> {
  @override
  void initState() {
    super.initState();
    if (widget.city != null) {
      if (widget.city!.latitude != null && widget.city!.longitude != null) {
        weather = ApiServices()
            .getCurrentWeather(widget.city!.latitude, widget.city!.longitude);
      }
    } else {
      weather = ApiServices().getCurrentWeather(null, null);
    }
  }

  late Future<currentWeatherData> weather;
  // get data from shared preferences
  late final SharedPreferences prefs;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    if (widget.city != null) {
      if (widget.city!.latitude != null && widget.city!.longitude != null) {
        weather = ApiServices()
            .getCurrentWeather(widget.city!.latitude, widget.city!.longitude);
      }
    } else {
      weather = ApiServices().getCurrentWeather(null, null);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<currentWeatherData?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('current_weather');
    if (json != null) {
      return currentWeatherData.fromJson(jsonDecode(json));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 60),
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
                future: weather,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return currentWeatherWidget(snapshot.data);
                  }
                  //load previous data from shared preferences while waiting for new data to load
                  return FutureBuilder(
                      future: getWeatherData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return currentWeatherWidget(snapshot.data);
                        }
                        return const Center(child: CircularProgressIndicator());
                      });
                }),
            if (widget.city != null) forecastBTN(widget.city!),
          ],
        ),
      ),
    );
  }
}
