import 'dart:async';
import 'dart:convert';

import 'package:covid19_dashboard/data/data.dart';
import 'package:covid19_dashboard/models/summary_model.dart';
import 'package:covid19_dashboard/widgets/covid_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<SummaryOfCases> fetchSummaryOfCases() async {
  final response = await http.get("https://api.covid19api.com/summary");

  if (response.statusCode == 200) {
    return SummaryOfCases.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load the summary");
  }
}

class StatsGrid extends StatefulWidget {
  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  Future<SummaryOfCases> futureSummaryOfCases;

  @override
  void initState() {
    super.initState();
    futureSummaryOfCases = fetchSummaryOfCases();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: FutureBuilder<SummaryOfCases>(
        future: futureSummaryOfCases,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Nouveaux Cas Confirmés',
                          snapshot.data.countries[18].newConfirmed.toString(),
                          Colors.deepOrange),
                      _buildStatCard(
                          'Total Cas Confirmés',
                          snapshot.data.countries[18].totalConfirmed.toString(),
                          Colors.deepOrange),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Nouveaux Cas Guéris',
                          snapshot.data.countries[18].newRecovered.toString(),
                          Colors.green),
                      _buildStatCard(
                          'Total Cas Guéris',
                          snapshot.data.countries[18].totalRecovered.toString(),
                          Colors.green),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Nouveaux Décès',
                          snapshot.data.countries[18].newDeaths.toString(),
                          Colors.grey),
                      _buildStatCard(
                          'Total Décès',
                          snapshot.data.countries[18].totalDeaths.toString(),
                          Colors.grey),
                    ],
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 100.0,
                  child: _buildStatCard(
                      'Sous traitement',
                      '${snapshot.data.countries[18].totalConfirmed - snapshot.data.countries[18].totalRecovered - snapshot.data.countries[18].totalDeaths}',
                      Colors.orange),
                ),
                Flexible(
                  child: CovidBarChart(covidCases: covidBeninDailyNewCases),
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
                          'Cas confirmés', snapshot.error, Colors.red),
                      _buildStatCard('Décès', snapshot.error, Colors.grey),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Cas guéris', snapshot.error, Colors.green),
                      _buildStatCard(
                          'Sous traitement', snapshot.error, Colors.orange),
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
            SizedBox(
              height: 20,
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
