import 'package:flutter/material.dart';
import 'package:covid19_dashboard/screens/screens.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
        seconds: 10,
        navigateAfterSeconds: BottomNavScreen(),
        image: Image.asset(
          'assets/images/icon.png',
        ),
        title: Text(
          "Benin COVID-19",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        loadingText: Text(
          "© 2020 Katakori Inc.",
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        photoSize: 150.0,
        backgroundColor: Colors.deepPurple[900],
        loaderColor: Colors.white,
      ),
    );
  }
}
