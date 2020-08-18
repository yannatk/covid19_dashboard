import 'dart:async';
import 'dart:convert';

import 'package:covid19_dashboard/models/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

Future<SummaryOfCases> fetchGlobalCases() async {
  final response = await http.get("https://api.covid19api.com/summary");

  if (response.statusCode == 200) {
    return SummaryOfCases.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load the summary");
  }
}

RegExp regWorld = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function matchFuncWorld = (Match match) => '${match[1]},';

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
            var activeCases = snapshot.data.global.totalConfirmed -
                snapshot.data.global.totalRecovered -
                snapshot.data.global.totalDeaths;

            return ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
                              snapshot.data.global.totalConfirmed
                                  .toString()
                                  .replaceAllMapped(regWorld, matchFuncWorld),
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
                              "+${snapshot.data.global.newConfirmed.toString().replaceAllMapped(regWorld, matchFuncWorld)}",
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sous Traitement",
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
                              FontAwesomeIcons.hospitalUser,
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$activeCases'
                                  .toString()
                                  .replaceAllMapped(regWorld, matchFuncWorld),
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "+${snapshot.data.global.newConfirmed.toString().replaceAllMapped(regWorld, matchFuncWorld)}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 25.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cas Guéris",
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
                              FontAwesomeIcons.heartbeat,
                              color: Colors.greenAccent[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.global.totalRecovered
                                  .toString()
                                  .replaceAllMapped(regWorld, matchFuncWorld),
                              style: TextStyle(
                                  color: Colors.greenAccent[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "+${snapshot.data.global.newRecovered.toString().replaceAllMapped(regWorld, matchFuncWorld)}",
                          style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontSize: 25.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Décès",
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
                              FontAwesomeIcons.skull,
                              color: Colors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.global.totalDeaths
                                  .toString()
                                  .replaceAllMapped(regWorld, matchFuncWorld),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "+${snapshot.data.global.newDeaths.toString().replaceAllMapped(regWorld, matchFuncWorld)}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
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
