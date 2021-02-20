import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';

class CurrentDailyBudget extends StatelessWidget {
  CurrentDailyBudget(this.trip);
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.blue],
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
                child: Text("\$${trip.getCurrentDailyBudget()}", style: TextStyle(fontSize: 60, color: Colors.white)),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("current daily budget", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

