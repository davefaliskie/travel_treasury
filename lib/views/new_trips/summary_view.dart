import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:travel_budget/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';


class NewTripSummaryView extends StatelessWidget {
  final db = Firestore.instance;
  final Trip trip;
  final ams = AdMobService();

  NewTripSummaryView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InterstitialAd newTripAd = ams.getNewTripInterstitial();
    newTripAd.load();
    final tripTypes = trip.types();
    var tripKeys = tripTypes.keys.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Trip Summary'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Submit", style: TextStyle(fontSize: 20, color: Colors.green),),
                ),
                Text("${trip.title}"),
                Text("${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(trip.endDate).toString()}"),
                Text("\$${trip.budget.toStringAsFixed(2)}"),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    scrollDirection: Axis.vertical,
                    primary: false,
                    children: List.generate(tripTypes.length, (index) {
                      return FlatButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            tripTypes[tripKeys[index]],
                            Text(tripKeys[index]),
                          ],
                        ),
                        onPressed: () async {
                          trip.travelType = tripKeys[index];
                          final uid = await Provider.of(context).auth.getCurrentUID();
                          await db.collection("userData").document(uid).collection("trips").add(trip.toJson());
                          newTripAd.show(
                            anchorType: AnchorType.bottom,
                            anchorOffset: 0.0,
                            horizontalCenterOffset: 0.0,
                          );
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      );
                    }),
                  ),
                ),
              ],
            )
        )
    );
  }
}
