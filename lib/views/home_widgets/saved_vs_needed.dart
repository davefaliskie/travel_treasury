import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';

Widget savedVsNeeded(BuildContext context, Trip trip) {
  final saved = (trip.saved ?? 0.0).floor();
  final totalBudget = trip.budget.floor() * trip.getTotalTripDays();
  final needed = (totalBudget - saved).floor();


  return Container (
    height: MediaQuery.of(context).size.height * 0.30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      gradient: LinearGradient(
        colors: [Colors.blueAccent, Colors.indigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text("saved", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: (saved > totalBudget) ? 1 : (saved/totalBudget),
                  child: Container(
                    width: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text("\$$saved", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text("needed", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: (needed <= 0) ? 0 : (needed/totalBudget),
                  child: Container(
                    width: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text("\$${(needed <= 0) ? 0 : needed}", style: TextStyle(color: Colors.white)),
            ),
          ],
        )
      ],
    ),
  );

}