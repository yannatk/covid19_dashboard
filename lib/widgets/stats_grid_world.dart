import 'dart:async';
import 'dart:convert';

import 'package:covid19_dashboard/models/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<SummaryOfCases> fetchGlobalCases() async {
  final response = await http.get("https://api.covid19api.com/summary");

  if (response.statusCode == 200) {
    return SummaryOfCases.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load the summary");
  }
}

class StatsGridWorld extends StatefulWidget {
  @override
  _StatsGridWorldState createState() => _StatsGridWorldState();
}

class _StatsGridWorldState extends State<StatsGridWorld> {
  Future<SummaryOfCases> futureGlobalCases;

  @override
  void initState() {
    super.initState();
    futureGlobalCases = fetchGlobalCases();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: FutureBuilder<SummaryOfCases>(
        future: futureGlobalCases,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Nouveaux Cas Confirmés',
                          snapshot.data.global.newConfirmed.toString(),
                          Colors.deepOrange),
                      _buildStatCard(
                          'Total Cas Confirmés',
                          snapshot.data.global.totalConfirmed.toString(),
                          Colors.deepOrange),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Nouveaux Cas Guéris',
                          snapshot.data.global.newRecovered.toString(),
                          Colors.green),
                      _buildStatCard(
                          'Total Cas Guéris',
                          snapshot.data.global.totalRecovered.toString(),
                          Colors.green),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Nouveaux Décès',
                          snapshot.data.global.newDeaths.toString(),
                          Colors.grey),
                      _buildStatCard(
                          'Total Décès',
                          snapshot.data.global.totalDeaths.toString(),
                          Colors.grey),
                    ],
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 100.0,
                  child: _buildStatCard(
                      'Sous traitement',
                      '${snapshot.data.global.totalConfirmed - snapshot.data.global.totalRecovered - snapshot.data.global.totalDeaths}',
                      Colors.orange),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Cas confirmés', snapshot.error, Colors.orange),
                      _buildStatCard('Décès', snapshot.error, Colors.red),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Cas guéris', snapshot.error, Colors.green),
                      _buildStatCard(
                          'Sous traitement', snapshot.error, Colors.lightBlue),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
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
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
