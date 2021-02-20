import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_budget/models/Trip.dart';

class TripDetailsCard extends StatelessWidget {
  TripDetailsCard(this.trip);
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: trip.getLocationImage(),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                )
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 15,
            right: 15,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: AutoSizeText(
                              trip.title,
                              style: TextStyle(fontSize: 30.0),
                              maxLines: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              "${DateFormat('MMM dd, yyyy').format(trip.startDate).toString()} - ${DateFormat('MMM dd, yyyy').format(trip.endDate).toString()}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("\$${(trip.budget.floor() * trip.getTotalTripDays()).toString()}",
                            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                          child: Text("total budget"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
