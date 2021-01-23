import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_budget/views/home_view.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
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
    _nextTrip = _getNextTrip();
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
      HomeView(),
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

  _getNextTrip() async {
    final uid = Provider.of(context).auth.getCurrentUID();
    var snapshot = await FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('trips')
        .orderBy('startDate')
        .limit(1)
        .get();
    return Trip.fromSnapshot(snapshot.docs.first);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}