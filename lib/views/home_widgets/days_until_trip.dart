import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';

Widget daysUntilTrip(BuildContext context, Trip trip) {
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
              child: Text("${trip.getDaysUntilTrip()}", style: TextStyle(fontSize: 60, color: Colors.white)),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("days until your trip", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}
