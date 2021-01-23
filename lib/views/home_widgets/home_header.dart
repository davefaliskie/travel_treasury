import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';

Widget homeHeader(BuildContext context, Trip trip) {
  final saved = (trip.saved ?? 0.0).floor();

  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.25,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.blueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )
    ),

    child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("\$$saved", style: TextStyle(color: Colors.white, fontSize: 65)),
            ),
          ),
          Text("Total Saved", style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
