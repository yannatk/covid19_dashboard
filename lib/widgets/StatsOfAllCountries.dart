import 'dart:convert';
import 'dart:io';

import 'package:covid19_dashboard/models/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<SummaryOfCases> fetchAllCountriesCases() async {
  String fileName = "CacheData.json";
  var cacheDir = await getTemporaryDirectory();

  if (await File(cacheDir.path + "/" + fileName).exists()) {
    var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
    return SummaryOfCases.fromJson(json.decode(jsonData));
  } else {
    var response = await http.get("https://api.covid19api.com/summary");

    if (response.statusCode == 200) {
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      file.writeAsString(response.body, flush: true, mode: FileMode.write);

      return SummaryOfCases.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load the Data");
    }
  }
}

RegExp regAllCountries = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function matchFuncAllCountries = (Match match) => '${match[1]},';

class StatsOfAllCountries extends StatefulWidget {
  @override
  _StatsOfAllCountriesState createState() => _StatsOfAllCountriesState();
}

class _StatsOfAllCountriesState extends State<StatsOfAllCountries> {
  Future<SummaryOfCases> futureAllCountriesCases;

  @override
  void initState() {
    super.initState();
    futureAllCountriesCases = fetchAllCountriesCases();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: FutureBuilder<SummaryOfCases>(
        future: futureAllCountriesCases,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var i = 0; i < snapshot.data.countries.length; i++)
                  Card(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.flag,
                        color: Colors.purple[700],
                      ),
                      title: Column(
                        children: [
                          Text(
                            snapshot.data.countries[i].countryName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.blue,
                              ),
                              Text(
                                snapshot.data.countries[i].totalConfirmed
                                    .toString()
                                    .replaceAllMapped(
                                      regAllCountries,
                                      matchFuncAllCountries,
                                    ),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(FontAwesomeIcons.heartbeat,
                                  color: Colors.green),
                              Text(
                                snapshot.data.countries[i].totalRecovered
                                    .toString()
                                    .replaceAllMapped(
                                      regAllCountries,
                                      matchFuncAllCountries,
                                    ),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.hospitalUser,
                                color: Colors.orange,
                              ),
                              Text(
                                "${snapshot.data.countries[i].totalConfirmed - snapshot.data.countries[i].totalRecovered - snapshot.data.countries[i].totalDeaths}"
                                    .toString()
                                    .replaceAllMapped(
                                      regAllCountries,
                                      matchFuncAllCountries,
                                    ),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.skull,
                                color: Colors.red,
                              ),
                              Text(
                                snapshot.data.countries[i].totalDeaths
                                    .toString()
                                    .replaceAllMapped(
                                      regAllCountries,
                                      matchFuncAllCountries,
                                    ),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.chartBar,
                        color: Colors.purple[700],
                      ),
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
