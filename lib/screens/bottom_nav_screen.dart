import 'package:covid19_dashboard/screens/help_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:covid19_dashboard/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    HomeScreen(),
    StatsScreen(),
    NewsScreen(),
    HelpScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple[900],
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.deepPurple[900],
        height: 50,
        items: <Widget>[
          FaIcon(
            FontAwesomeIcons.home,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.chartBar,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.newspaper,
            color: Colors.white,
          ),
          FaIcon(
            FontAwesomeIcons.handsHelping,
            color: Colors.white,
          ),
        ],
        animationDuration: Duration(milliseconds: 200),
        index: _currentIndex,
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
