import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_dashboard/models/news_model.dart';
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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = News.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.datePublication),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Card(
        shadowColor: Colors.indigo,
        elevation: 8.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              record.imagePath,
              fit: BoxFit.cover,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  record.title,
                  textAlign: TextAlign.justify,
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      record.datePublication,
                    ),
                    Text(
                      record.source,
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _launchURL() async {
                  final url = record.url;
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
              child: Text(
                "En savoir plus",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
