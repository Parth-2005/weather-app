import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/Models/model.dart';

class ApiServices {
  // https://openweathermap.org/img/wn/10d@2x.png
  // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key} //currentWeather
  // api.openweathermap.org/data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}&appid={API key} // 15 day daily forecast

  final String API_KEY = "ac24b913d68baa74fa58761fcead0838";
  Future<Map<String, double>?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position = await Geolocator.getCurrentPosition();
    try {
      return {'latitude': position.latitude, 'longitude': position.longitude};
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<currentWeatherData> getCurrentWeather(
      double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      Map<String, double>? position = await determinePosition();
      if (position != null) {
        latitude = position['latitude'];
        longitude = position['longitude'];
      }
    }
    if (latitude != null && longitude != null) {
      final Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$API_KEY");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final _prefs = await SharedPreferences.getInstance();
        if (_prefs.getString('current_weather') != null) {
          _prefs.remove('current_weather');
        }
        _prefs.setString('current_weather', json.encode(data));
        return currentWeatherData.fromJson(data);
      }
      return Future.error("Error");
    }
    return Future.error("Error");
  }

  Future<List<forecastWeatherData>> getForecastWeather(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      Map<String, double>? position = await determinePosition();
      if (position != null) {
        latitude = position['latitude'];
        longitude = position['longitude'];
      }
    }
    List<forecastWeatherData> list = [];
    final Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=${latitude}&lon=${longitude}&appid=$API_KEY&cnt=7");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['list'];
      for (var i in data) {
        list.add(forecastWeatherData.fromJson(i));
      }
      final _prefs = await SharedPreferences.getInstance();
      if (_prefs.getStringList('forecast_weather') != null) {
        _prefs.remove('forecast_weather');
      }
      _prefs.setStringList(
          'forecast_weather', data.map((e) => json.encode(e)).toList());
      return list;
    }
    return Future.error("Error");
  }
}
