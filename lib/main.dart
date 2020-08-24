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
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: BottomNavScreen(),
      image: Image.asset('assets/images/splash.png'),
      photoSize: 150.0,
      backgroundColor: Colors.deepPurpleAccent[700],
      loaderColor: Colors.white,
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', 'FR'), // Hebrew, no country code
      ],
      locale: Localizations.of(context, GlobalMaterialLocalizations),
      title: 'COVID-19 Benin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(),
    );
  }
}
*/
