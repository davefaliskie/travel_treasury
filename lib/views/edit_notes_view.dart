import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:travel_budget/widgets/rounded_button.dart';

class EditNotesView extends StatefulWidget {
  final Trip trip;

  EditNotesView({Key key, @required this.trip}) : super(key: key);

  @override
  _EditNotesViewState createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {
  TextEditingController _notesController = new TextEditingController();

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.trip.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amberAccent,
        child: Hero(
          tag: "TripNotes-${widget.trip.title}",
          transitionOnUserGestures: true,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildHeading(context),
                  buildNotesText(),
                  buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeading(context) {
    return Material(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Trip Notes",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            FlatButton(
              child: Icon(Icons.close, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildNotesText() {
    return Material(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          maxLines: null,
          controller: _notesController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          cursorColor: Colors.black,
          autofocus: true,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget buildSubmitButton(context) {
    return Material(
      color: Colors.amberAccent,
      child: RoundedButton(
        child: Text("Save", style: TextStyle(color: Colors.white)),
        color: Colors.indigo,
        onPressed: () async {
          widget.trip.notes = _notesController.text;

          final uid =  Provider.of(context).auth.getCurrentUID();

          await db.collection("userData")
                  .doc(uid)
                  .collection("trips")
                  .doc(widget.trip.documentId)
                  .update({'notes': _notesController.text});

          Navigator.of(context).pop();

        },
      ),
    );
  }
}
