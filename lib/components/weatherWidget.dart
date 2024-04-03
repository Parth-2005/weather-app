import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/Models/model.dart';

class weatherWidget extends StatelessWidget {
  weatherWidget(this.weather, {super.key});
  forecastWeatherData weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue[100], 
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${weather.date}",
                  style: TextStyle(
                    fontSize: 24,
                  )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(imageUrl: "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png"),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            weather.weather!,
                            style: TextStyle(
                              fontSize: 22
                            )
                          ),
                          Text(
                            weather.weatherDescription!,
                            style: TextStyle(
                              fontSize: 16
                            )
                          )
                        ]
                      ),
                  Column(
                    children: [
                      Text(
                        "${weather.maxTemp}°C",
                        style: TextStyle(
                          fontSize: 24
                        )
                      ),
                      Text(
                        "${weather.minTemp}°C",
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                    ]
                  )
                    ],
                  ),
                ),
              ),
            ],
          )
        ]
      )
    );
  }
}