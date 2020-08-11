import 'package:flutter/material.dart';
import 'package:covid19_dashboard/data/data.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Image.asset("assets/images/phone_img.jpg"),
          ),
          Container(
            child: Text(
              "Vous avez envie d'améliorer cette application ou vous avez une idée d'application à développer, contactez l'équipe.",
              textAlign: TextAlign.justify,
            ),
          ),
          Divider(
            color: Colors.grey[800],
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text("Ecrivez-nous"),
            trailing: Text(contact.elementAt(0)),
          ),
          Divider(
            color: Colors.grey[800],
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text("Appelez-nous"),
            trailing: Text(contact.elementAt(1)),
          ),
          Divider(
            color: Colors.grey[800],
          ),
          Text("© 2020 Katakori Inc."),
        ],
      ),
    );
  }
}
