import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'edit_notes_view.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:travel_budget/widgets/money_text_field.dart';
import 'package:travel_budget/widgets/calculator_widget.dart';

class DetailTripView extends StatefulWidget {
  final Trip trip;

  DetailTripView({Key key, @required this.trip}) : super(key: key);

  @override
  _DetailTripViewState createState() => _DetailTripViewState();
}

class _DetailTripViewState extends State<DetailTripView> {
  TextEditingController _budgetController = TextEditingController();
  var _budget;

  void initState() {
    super.initState();
    _budgetController.text = widget.trip.budget.toStringAsFixed(0);
    _budget = widget.trip.budget.floor();
  }

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
                background: widget.trip.getLocationImage(),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () {
                    _tripEditModalBottomSheet(context);
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                tripDetails(),
                CalculatorWidget(trip: widget.trip),
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

  Widget daysOutCard() {
    return Card(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("${widget.trip.getDaysUntilTrip()}", style: TextStyle(fontSize: 75)),
            Text("days until your trip", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }

  Widget tripDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.trip.title,
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
                    "${DateFormat('MM/dd/yyyy').format(widget.trip.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(widget.trip.endDate).toString()}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
                    "\$$_budget",
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
                      "\$${_budget * widget.trip.getTotalTripDays()} total",
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

  Widget notesCard(context) {
    return Hero(
      tag: "TripNotes-${widget.trip.title}",
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
                    builder: (context) => EditNotesView(trip: widget.trip)));
          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {
    if (widget.trip.notes == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [
        Text(widget.trip.notes, style: TextStyle(color: Colors.grey[300]))
      ];
    }
  }


  void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Edit Trip"),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.trip.title,
                      style: TextStyle(fontSize: 30, color: Colors.green[900]),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MoneyTextField(
                        controller: _budgetController,
                        helperText: "Budget",
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Submit'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () async {
                        widget.trip.budget = double.parse(_budgetController.text);
                        setState(() {
                          _budget = widget.trip.budget.floor();
                        });
                        await updateTrip(context);
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        await deleteTrip(context);
                        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future updateTrip(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance
        .collection('userData')
        .document(uid)
        .collection("trips")
        .document(widget.trip.documentId);

    return await doc.setData(widget.trip.toJson());
  }

  Future deleteTrip(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance
        .collection('userData')
        .document(uid)
        .collection("trips")
        .document(widget.trip.documentId);

    return await doc.delete();
  }
}
