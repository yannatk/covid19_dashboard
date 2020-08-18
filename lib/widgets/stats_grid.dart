import 'dart:async';
import 'dart:convert';

import 'package:covid19_dashboard/data/data.dart';
import 'package:covid19_dashboard/models/summary_model.dart';
import 'package:covid19_dashboard/widgets/covid_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

Future<SummaryOfCases> fetchSummaryOfCases() async {
  final response = await http.get("https://api.covid19api.com/summary");

  if (response.statusCode == 200) {
    return SummaryOfCases.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load the summary");
  }
}

RegExp regMyCountry = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function matchFuncMyCountry = (Match match) => '${match[1]},';

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
            var activeCases = snapshot.data.countries[18].totalConfirmed -
                snapshot.data.countries[18].totalRecovered -
                snapshot.data.countries[18].totalDeaths;

            return ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: 250.0,
                  height: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cas Confirmés",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.countries[18].totalConfirmed
                                  .toString()
                                  .replaceAllMapped(
                                      regMyCountry, matchFuncMyCountry),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Aujourd'hui: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "+${snapshot.data.countries[18].newConfirmed.toString().replaceAllMapped(regMyCountry, matchFuncMyCountry)}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sous Traitement",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.hospitalUser,
                                color: Colors.orange,
                              ),
                              Text(
                                '$activeCases'.toString().replaceAllMapped(
                                    regMyCountry, matchFuncMyCountry),
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "+${snapshot.data.countries[18].newConfirmed.toString().replaceAllMapped(regMyCountry, matchFuncMyCountry)}",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Cas Guéris",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.heartbeat,
                                color: Colors.greenAccent[400],
                              ),
                              Text(
                                snapshot.data.countries[18].totalRecovered
                                    .toString()
                                    .replaceAllMapped(
                                        regMyCountry, matchFuncMyCountry),
                                style: TextStyle(
                                  color: Colors.greenAccent[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "+${snapshot.data.countries[18].newRecovered.toString().replaceAllMapped(regMyCountry, matchFuncMyCountry)}",
                              style: TextStyle(
                                color: Colors.greenAccent[400],
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Décès",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.skull,
                                color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.countries[18].totalDeaths
                                  .toString()
                                  .replaceAllMapped(
                                      regMyCountry, matchFuncMyCountry),
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(300.0, 0, 0, 0),
                        child: Text(
                          "+${snapshot.data.countries[18].newDeaths.toString().replaceAllMapped(regMyCountry, matchFuncMyCountry)}",
                          style: TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CovidBarChart(
                    covidCases: covidBeninDailyNewCases,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Données non disponible actuellement due à un problème de connectivité internet. Veuillez réessayer ultérieurement !",
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
