import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsGrid extends StatefulWidget {
  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  var data = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchData();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    var url =
        "https://api.covid19api.com/country/benin?from=2020-07-25T00:00:00Z&to=2020-07-26T00:00:00Z";
    var response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      var dataInJson = jsonDecode(response.body);
      setState(() {
        data = dataInJson;
        isLoading = false;
      });
    } else {
      data = {};
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    /*if (data.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ));
    }*/
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Cas confirmés', '1.81 M', Colors.orange),
                _buildStatCard('Décès', '105 K', Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Cas guéris', '391 K', Colors.green),
                _buildStatCard('Sous traitement', 'N/A', Colors.lightBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
