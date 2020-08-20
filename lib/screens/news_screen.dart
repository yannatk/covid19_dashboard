import 'package:covid19_dashboard/data/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'stats_screen.dart';

var newFormatDate = DateFormat.yMMMEd().format(dateTime);

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualités"),
        backgroundColor: Colors.deepPurple[900],
        actions: [
          Center(
            child: Text(
              newFormatDate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: latestNews
            .map((e) => Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Image.asset(
                          e.values.last,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(e.values.first,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          e.values.elementAt(2),
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          e.values.elementAt(1),
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    onTap: () {
                      _launchURL() async {
                        final url = e.values.elementAt(3).toString();
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }

                      setState(() {
                        _launchURL();
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
