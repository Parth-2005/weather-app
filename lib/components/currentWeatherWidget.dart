import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/Models/model.dart';
import 'dart:math' as math;


class currentWeatherWidget extends StatelessWidget {
  currentWeatherWidget(this.weather, {super.key});
  currentWeatherData weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                )),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather!.cityName!,
                      style: TextStyle(fontSize: 32),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.all(5),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl:
                              "https://openweathermap.org/img/wn/${weather!.weatherIcon!}@4x.png",
                        ),
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              weather!.temp! + "°C",
                              style: TextStyle(fontSize: 44),
                            ),
                          ]),
                      Text(
                        weather!.weather!,
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        weather!.weatherDescription!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ])
                  ]),
            ])),
        Container(
          width: double.infinity,
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.blue[100],
                      ),
                      margin: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.water, size: 40),
                            Text(weather!.humidity!,
                                style: TextStyle(fontSize: 30)),
                          ])),
                ),
                Expanded(
                  child: Container(
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.download, size: 40),
                            Text(weather!.pressure!,
                                style: TextStyle(fontSize: 30)),
                          ])),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.blue[100],
                      ),
                      margin: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.visibility, size: 40),
                            Text(weather!.visibility!,
                                style: TextStyle(fontSize: 30)),
                          ])),
                ),
                Expanded(
                  child: Container(
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.air, size: 40),
                            Text(weather!.windSpeed!,
                                style: TextStyle(fontSize: 30)),
                            Transform.rotate(
                                angle: -(math.pi /
                                    180 *
                                    weather!.windDirection!),
                                child: Icon(Icons.arrow_circle_up_sharp,
                                    size: 40)),
                          ])),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                  child: Container(
                      height: 180,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.blue[100],
                      ),
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.sunny, size: 40),
                                    Text(
                                      weather!.sunrise!,
                                      style: TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.nights_stay, size: 40),
                                    Text(
                                      weather!.sunset!,
                                      style: TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                              ]),
                        ],
                      )))
            ])
          ]),
        )
      ]),
    );
  }
}
