import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';

class TravelType extends StatelessWidget {
  TravelType(this.trip);
  final Trip trip;

  Widget getTypeIcon() {
    if (trip.types().containsKey(trip.travelType)) {
      return trip.types(color: Colors.white)[trip.travelType];
    } else {
      return Icon(Icons.directions, size: 40, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    "transport",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: getTypeIcon(),
              ),
              Text(trip.travelType, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),

    );
  }
}
