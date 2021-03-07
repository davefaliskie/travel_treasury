import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:travel_budget/views/edit_notes_view.dart';

class Notes extends StatelessWidget {
  final Trip trip;

  Notes({@required this.trip});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "TripNotes-${trip.title}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.amberAccent,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Notes", style: TextStyle(fontSize: 24, color: Colors.black)),
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
              MaterialPageRoute(builder: (context) => EditNotesView(trip: trip)),
            );
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
          child: Icon(Icons.add_circle_outline, color: Colors.grey),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.black)),
      ];
    } else {
      return [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              trip.notes,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.fade,
              maxLines: 5,
            ),
          ),
        )
      ];
    }
  }
}
