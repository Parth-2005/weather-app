import 'package:intl/intl.dart';

class currentWeatherData {
  late String? cityName;
  late String? temp;
  late String? feelsLike;
  late String? minTemp;
  late String? maxTemp;
  late String? pressure;
  late String? weather;
  late String? weatherIcon;
  late String? weatherDescription;
  late String? humidity;
  late String? windSpeed;
  late String? sunrise;
  late String? sunset;
  late String? visibility;
  late int? windDirection;

  currentWeatherData({
    required this.cityName,
    required this.temp,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.pressure,
    required this.weather,
    required this.weatherIcon,
    required this.weatherDescription,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.visibility,
    required this.windDirection,
  });

  Map<String, dynamic> toJson() {
    return {
      "cityName": cityName,
      "temp": temp,
      "feelsLike": feelsLike,
      "minTemp": minTemp,
      "maxTemp": maxTemp,
      "pressure": pressure,
      "weather": weather,
      "weatherIcon": weatherIcon,
      "weatherDescription": weatherDescription,
      "humidity": humidity,
      "windSpeed": windSpeed,
      "sunrise": sunrise,
      "sunset": sunset,
      "visibility": visibility,
      "windDirection": windDirection,
    };
  }

  factory currentWeatherData.fromJson(Map<String, dynamic> json) {
    return currentWeatherData(
        cityName: json['name'],
        temp: kelvinToCelcius(json['main']['temp']).toString(),
        feelsLike: kelvinToCelcius(json['main']['feels_like']).toString(),
        minTemp: kelvinToCelcius(json['main']['temp_min']).toString(),
        maxTemp: kelvinToCelcius(json['main']['temp_max']).toString(),
        pressure: json['main']['pressure'].toString(),
        weather: json['weather'][0]['main'].toString(),
        weatherIcon: json['weather'][0]['icon'].toString(),
        weatherDescription: json['weather'][0]['description'].toString(),
        humidity: json['main']['humidity'].toString(),
        windSpeed: json['wind']['speed'].toString(),
        windDirection: json['wind']['deg'],
        sunrise: unixToDateTime(json['sys']['sunrise']),
        sunset: unixToDateTime(json['sys']['sunset']),
        visibility: json['visibility'].toString());
  }
}

class forecastWeatherData {
  late String? date;
  late String? minTemp;
  late String? maxTemp;
  late String? pressure;
  late String? weather;
  late String? weatherIcon;
  late String? weatherDescription;
  late String? humidity;
  late String? windSpeed;
  late String? sunrise;
  late String? sunset;
  late String? visibility;
  late int? windDirection;

  forecastWeatherData({
    this.date,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.weather,
    this.weatherIcon,
    this.weatherDescription,
    this.humidity,
    this.windSpeed,
    this.sunrise,
    this.sunset,
    this.visibility,
    this.windDirection,
  });
  factory forecastWeatherData.fromJson(Map<String, dynamic> json) {
    return forecastWeatherData(
      date: unixToDay(json['dt']),
      minTemp: kelvinToCelcius(json['temp']['min']).toString(),
      maxTemp: kelvinToCelcius(json['temp']['max']).toString(),
      pressure: json['pressure'].toString(),
      humidity: json['humidity'].toString(),
      weather: json['weather'][0]['main'].toString(),
      weatherIcon: json['weather'][0]['icon'].toString(),
      weatherDescription: json['weather'][0]['description'].toString(),
      windSpeed: json['speed'].toString(),
      windDirection: json['deg'],
      sunrise: unixToDateTime(json['sunrise']),
      sunset: unixToDateTime(json['sunset']),
      visibility: json['visibility'].toString(),
    );
  }
}

String kelvinToCelcius(var temp) {
  return (temp - 273.15).toStringAsFixed(2);
}

String unixToDateTime(var time) {
  var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  var formattedDate = DateFormat('hh:mm a').format(date);
  return formattedDate;
}

String unixToDay(var time) {
  var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  var formattedDate = DateFormat('EEEE').format(date);
  return formattedDate;
}

class cityData {
  late String? cityName;
  late double? latitude;
  late double? longitude;
  late var id;

  cityData({this.cityName, this.latitude, this.longitude, this.id});

  factory cityData.fromJson(Map<String, dynamic> json) {
    return cityData(
      cityName: json['name'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      id: json['id'],
    );
  }
}
