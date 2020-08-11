import 'package:covid19_dashboard/data/data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:async/async.dart';

/*
Future<News> fetchNews() async {
  final response = await http.get(
      "https://newsapi.org/v2/top-headlines?q=coronavirus&language=fr&apiKey=369bd54d9e0b4eb3945f29d71f24d234");

  if (response.statusCode == 200) {
    return News.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load the news");
  }
}
*/

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  /*
  Future<News> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }
  */

  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualités"),
        backgroundColor: Colors.deepPurple[900],
        actions: [
          Center(
            child: Text(
              currentDate.toString().substring(0, 10),
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
