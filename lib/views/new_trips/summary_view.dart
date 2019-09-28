import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_budget/widgets/provider_widget.dart';

class NewTripSummaryView extends StatelessWidget {
  final db = Firestore.instance;

  final Trip trip;
  NewTripSummaryView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Trip Summary'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Finish"),
                Text("Location ${trip.title}"),
                Text("Start Date ${trip.startDate}"),
                Text("End Date ${trip.endDate}"),

                RaisedButton(
                  child: Text("Finish"),
                  onPressed: () async {
                    // save data to fiebase
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    await db.collection("userData").document(uid).collection("trips").add(trip.toJson());
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            )
        )
    );
  }
}
