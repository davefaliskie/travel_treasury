import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:travel_budget/models/Trip.dart';
import 'detail_trip_view.dart';
import 'package:google_fonts/google_fonts.dart';



class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
          }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection(
        'trips').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot document) {
    final trip = Trip.fromSnapshot(document);
    final tripType = trip.types();

    return new Container(
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(trip.title, style: GoogleFonts.seymourOne(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                  child: Row(children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy')
                            .format(trip.startDate)
                            .toString()} - ${DateFormat('dd/MM/yyyy').format(
                            trip.endDate).toString()}"),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text("\$${(trip.budget == null) ? "n/a" : trip.budget
                          .toStringAsFixed(2)}",
                        style: new TextStyle(fontSize: 35.0),),
                      Spacer(),
                      (tripType.containsKey(trip.travelType)) ? tripType[trip
                          .travelType] : tripType["other"],
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailTripView(trip: trip)),
            );
          },
        ),
      ),
    );
  }
}
