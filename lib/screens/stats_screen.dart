import 'package:covid19_dashboard/data/data.dart';
import 'package:covid19_dashboard/widgets/covid_bar_chart.dart';
import 'package:covid19_dashboard/widgets/stats_grid.dart';
import 'package:covid19_dashboard/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Statistiques",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          bottom: TabBar(
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepPurple[900],
              ),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: Colors.deepPurple[900], width: 1),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Mon Pays"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: Colors.deepPurple[900], width: 1),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Le Monde"),
                    ),
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          StatsGrid(),
          StatsGridWorld(),
        ]),
      ),
    );
  }
}
