import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:travel_budget/widgets/trip_card.dart';


class PastTripsView extends StatelessWidget {
  Stream<QuerySnapshot> getUsersPastTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('trips')
        .where("endDate", isLessThanOrEqualTo: DateTime.now())
        .orderBy('endDate')
        .snapshots();
  }


  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Past Trips", style: TextStyle(fontSize: 20)),
          Expanded(
            child: StreamBuilder(
                stream: getUsersPastTripsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildTripCard(context, snapshot.data.documents[index]));
                }),
          ),
        ],
      ),
    );
  }
}