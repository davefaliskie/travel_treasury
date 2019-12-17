import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'edit_notes_view.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
            SliverList(
              delegate: SliverChildListDelegate([
                tripDetails(),
                totalBudgetCard(),
                daysOutCard(),
                notesCard(context),
                Container(
                  height: 200,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  // DAYS TILL TRIP CARD
  Widget daysOutCard() {
    return Card(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("${getDaysUntilTrip()}", style: TextStyle(fontSize: 75)),
            Text("days until your trip", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }

  // TRIP DETAILS
  Widget tripDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  trip.title,
                  style: TextStyle(fontSize: 30, color: Colors.green[900]),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                    "${DateFormat('MM/dd/yyyy').format(trip.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(trip.endDate).toString()}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // BUDGET CARD
  Widget totalBudgetCard() {
    return Card(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Daily Budget",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: AutoSizeText(
                    "\$${trip.budget.floor()}",
                    style: TextStyle(fontSize: 100),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blue[900],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text(
                      "\$${trip.budget.floor() * getTotalTripDays()} total",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // NOTES CARD
  Widget notesCard(context) {
    return Hero(
      tag: "TripNotes-${trip.title}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.deepPurpleAccent,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text("Trip Notes",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: setNoteText(),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditNotesView(trip: trip)));
          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {
    if (trip.notes == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [Text(trip.notes, style: TextStyle(color: Colors.grey[300]))];
    }
  }

  int getTotalTripDays() {
    return trip.endDate.difference(trip.startDate).inDays;
  }

  int getDaysUntilTrip() {
    int diff = trip.startDate.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
    }
    return diff;
  }
}
