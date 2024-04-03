import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather/Models/model.dart';
import 'package:weather/components/city.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search City',
                      ),
                      onChanged: (value) async {
                        Uri url = Uri.parse(
                            "https://ssip-upload-server.onrender.com/search/$value");
                        final response = await http.post(url);
                        if (response.statusCode == 200) {
                          setState(() {
                            data = json.decode(response.body);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Column(children: [
              for (var i in data) City(cityData.fromJson(i)),
            ]))
          ],
        ),
      ),
    );
  }
}
