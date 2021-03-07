import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:travel_budget/views/home_widgets/home_header.dart';
import 'package:travel_budget/views/home_widgets/percent_saved.dart';
import 'package:travel_budget/views/home_widgets/saved_vs_needed.dart';
import 'package:travel_budget/views/home_widgets/travel_type.dart';
import 'package:travel_budget/views/home_widgets/trip_details_card.dart';

import 'home_widgets/current_daily_budget.dart';
import 'home_widgets/days_until_trip.dart';
import 'home_widgets/notes.dart';

class HomeView extends StatefulWidget {
  final Trip trip;

  HomeView({
    @required this.trip,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(widget.trip),
          TripDetailsCard(widget.trip),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: DaysUntilTrip(widget.trip),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 12,
                    child: CurrentDailyBudget(widget.trip),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SavedVsNeeded(widget.trip),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TravelType(widget.trip),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 12,
                    child: PercentSaved(widget.trip),
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Notes(trip: widget.trip),
          ),

          Container(height: 40)
        ],
      ),
    );
  }
}

