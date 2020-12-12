import 'package:covid19_dashboard/data/data.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(30.0),
            shadowColor: Colors.indigo,
            elevation: 20.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/phone_img.jpg",
                  fit: BoxFit.cover,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Vous avez envie d'améliorer cette application ou vous avez une idée d'application à développer, contactez l'équipe.",
                    textAlign: TextAlign.justify,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.email,
                  ),
                  title: Text(
                    contact.first,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.message,
                  ),
                  title: Text(
                    'WhatsApp au ${contact.last}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
