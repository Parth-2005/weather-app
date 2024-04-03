import 'package:flutter/material.dart';
import 'package:weather/Models/model.dart';
import 'package:weather/pages/forecast.dart';

class forecastBTN extends StatelessWidget {
  cityData city;
  forecastBTN(this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Forecast(city)));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )
        ),
        child: Text("Forecast", style: TextStyle(fontSize: 20),),
      )
    );
  }
}