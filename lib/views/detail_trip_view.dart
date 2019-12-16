import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'edit_notes_view.dart';

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(trip.title, style: TextStyle(fontSize: 30, color: Colors.green[900]),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Daily budget: \$${trip.budget.toString()}", style: TextStyle(color: Colors.deepOrange),),
                ),
                notesCard(context),
              ]),
            )
          ],
        ),
      ),
    );
  }

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
                    Text("Trip Notes", style: TextStyle(fontSize: 24, color: Colors.white)),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotesView(trip: trip) ));
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
      return [
        Text(trip.notes, style: TextStyle(color: Colors.grey[300]))
      ];
    }
  }
}

