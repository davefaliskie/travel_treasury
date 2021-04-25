import 'package:flutter/material.dart';
import 'package:travel_budget/services/firebase_service.dart';
import 'package:travel_budget/views/home_view.dart';
import 'deposit_view.dart';
import 'profile_view.dart';
import 'package:travel_budget/models/Trip.dart';

class NavigationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationViewState();
  }
}

class _NavigationViewState extends State<NavigationView> {
  Future _nextTrip;
  Trip _trip;
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nextTrip = FirebaseService.getNextTrip(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _nextTrip,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData) {
            _trip = snapshot.data;
            return _buildView();
          } else {
            // TODO update when user has no trips
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _buildView() {
    final List<Widget> _children = [
      HomeView(trip: _trip),
      DepositView(trip: _trip),
      ProfileView(),
    ];

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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.attach_money),
              label: "Save",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              label: "Profile",
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
