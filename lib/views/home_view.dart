import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:travel_budget/views/home_widgets/home_header.dart';
import 'package:travel_budget/views/home_widgets/trip_details_card.dart';


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
          homeHeader(context, widget.trip),
          tripDetailsCard(context, widget.trip),
        ],
      ),
    );
  }

}