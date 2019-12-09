import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';

class DetailTripView extends StatelessWidget {
  final Trip trip;

  DetailTripView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Trip Details'),
              backgroundColor: Colors.green,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: trip.getLocationImage(),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 60.00,
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(trip.title, style: TextStyle(fontSize: 40, color: Colors.green[900]),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Daily budget: \$${trip.budget.toString()}", style: TextStyle(color: Colors.deepOrange),),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

