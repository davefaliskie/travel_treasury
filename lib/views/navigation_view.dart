import 'package:flutter/material.dart';
import 'package:travel_budget/views/home_view.dart';
import 'package:travel_budget/views/new_trips/location_view.dart';
import 'deposit_view.dart';
import 'profile_view.dart';
import 'package:travel_budget/models/Trip.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    DepositView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newTrip = new Trip(null, null, null, null, null, null);
    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTabTapped(1);
        },
        tooltip: "Add Savings",
        child: Icon(Icons.attach_money, color: Colors.indigo),
        elevation: 4.0,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.attach_money),
              title: new Text("Save"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}