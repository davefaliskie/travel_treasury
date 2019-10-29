import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'package:travel_budget/credentials.dart';

import 'budget_view.dart';

class NewTripDateView extends StatefulWidget {
  final Trip trip;

  NewTripDateView({Key key, @required this.trip}) : super(key: key);

  @override
  _NewTripDateViewState createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  Image getImage(photoReference) {
    final baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
    final maxWidth = "400";
    final maxHeight = "200";
    final url = "$baseUrl?maxwidth=$maxWidth&maxheight=$maxHeight&photoreference=$photoReference&key=$PLACES_API_KEY";
    return Image.network(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip - Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getImage(widget.trip.photoReference),
            buildSelectedDetails(context, widget.trip),

            Spacer(),
            Text("Location ${widget.trip.title}"),
            RaisedButton(
              child: Text("Select Dates"),
              onPressed: () async {
                await displayDateRangePicker(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    "Start Date: ${DateFormat('MM/dd/yyyy').format(_startDate).toString()}"),
                Text(
                    "End Date: ${DateFormat('MM/dd/yyyy').format(_endDate).toString()}"),
              ],
            ),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () {
                widget.trip.startDate = _startDate;
                widget.trip.endDate = _endDate;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewTripBudgetView(trip: widget.trip)),
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedDetails(BuildContext context, Trip trip) {
    return Hero(
      tag: "SelectedTrip-${trip.title}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: SingleChildScrollView(
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, bottom: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(trip.title, 
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 25.0)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Average Budget -- Not set up yet"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Trip Dates"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Trip Budget"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Trip Type"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
