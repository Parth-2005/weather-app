import 'package:flutter/material.dart';
import 'package:weather/Models/model.dart';
import 'package:weather/pages/weather.dart';

class City extends StatelessWidget {
  final cityData city;
  const City(this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[100], 
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
        child: Text(city.cityName!, style: TextStyle(fontSize: 20),),
      ),
      onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => currentWeather(city)));
    });
  }
}
