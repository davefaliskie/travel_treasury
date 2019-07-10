import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'budget_view.dart';

class NewTripDateView extends StatelessWidget {
  final Trip trip;
  NewTripDateView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Trip - Date'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Location ${trip.title}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Enter a Start Date"),
                    Text("Enter a End Date"),
                  ],
                ),
                RaisedButton(
                  child: Text("Continue"),
                  onPressed: () {
                    trip.startDate = DateTime.now();
                    trip.endDate = DateTime.now();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewTripBudgetView(trip: trip)),
                    );
                  },
                ),
              ],
            )
        )
    );
  }
}
