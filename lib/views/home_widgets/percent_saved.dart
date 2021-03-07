import 'package:flutter/material.dart';
import 'package:travel_budget/classes/progress_painter.dart';
import 'package:travel_budget/models/Trip.dart';

class PercentSaved extends StatelessWidget {
  PercentSaved(this.trip);
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final totalBudget = trip.budget.floor() * trip.getTotalTripDays();
    final saved = (trip.saved ?? 0).floor();
    final percentComplete = (saved / totalBudget) * 100;

    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
            colors: [Colors.indigoAccent, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Center(
                          child: Text("${percentComplete.toStringAsFixed(0)}%",
                              style: TextStyle(color: Colors.white, fontSize: 30))),
                      CustomPaint(
                        child: Center(),
                        painter: ProgressPainter(
                          circleWidth: 40,
                          completedPercentage: percentComplete,
                          defaultCircleColor: Colors.white30,
                          percentageCompletedCircleColor: Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("percent saved", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
