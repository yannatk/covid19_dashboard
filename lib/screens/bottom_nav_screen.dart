import 'package:covid19_dashboard/screens/help_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:covid19_dashboard/screens/screens.dart';

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
          Icon(
            Icons.home,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.insert_chart,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.event_note,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.help,
            size: 20,
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
