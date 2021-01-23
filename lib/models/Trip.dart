import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_budget/credentials.dart';


class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  Map budgetTypes;
  String travelType;
  String photoReference;
  String notes;
  String documentId;
  double saved;
  List ledger;


  Trip(
      this.title,
      this.startDate,
      this.endDate,
      this.budget,
      this.budgetTypes,
      this.travelType
      );

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() => {
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
    'budget': budget,
    'budgetTypes': budgetTypes,
    'travelType': travelType,
    'photoReference': photoReference,
  };

  // creating a Trip object from a firebase snapshot
  Trip.fromSnapshot(DocumentSnapshot snapshot) :
      title = snapshot.data()['title'],
      startDate = snapshot.data()['startDate'].toDate(),
      endDate = snapshot.data()['endDate'].toDate(),
      budget = snapshot.data()['budget'],
      budgetTypes = snapshot.data()['budgetTypes'],
      travelType = snapshot.data()['travelType'],
      photoReference = snapshot.data()['photoReference'],
      notes = snapshot.data()['notes'],
      documentId = snapshot.id,
      saved = snapshot.data()['saved'],
      ledger = snapshot.data()['ledger'];



  Map<String, Icon> types() => {
    "car": Icon(Icons.directions_car, size: 50),
    "bus": Icon(Icons.directions_bus, size: 50),
    "train": Icon(Icons.train, size: 50),
    "plane": Icon(Icons.airplanemode_active, size: 50),
    "ship": Icon(Icons.directions_boat, size: 50),
    "other": Icon(Icons.directions, size: 50),
  };

  // return the google places image
  Image getLocationImage() {
    final baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
    final maxWidth = "1000";
    final url = "$baseUrl?maxwidth=$maxWidth&photoreference=$photoReference&key=$PLACES_API_KEY";
    return Image.network(url, fit: BoxFit.cover);
  }

  int getTotalTripDays() {
    int total = endDate.difference(startDate).inDays;
    if (total < 1) {
      total = 1;
    }
    return total;
  }

  int getDaysUntilTrip() {
    int diff = startDate.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
    }
    return diff;
  }

  int getCurrentDailyBudget() {
    if (saved == 0 || saved == null) {
      return 0;
    } else {
      return (saved / getTotalTripDays()).floor();
    }
  }

  Map<String, dynamic> ledgerItem(String amount, String type) {
    var amountDouble = double.parse(amount);
    if (type == "spent") {
      amountDouble = double.parse("-" + amount);
    }
    return {
      'ledger': FieldValue.arrayUnion([
        {
          "date": DateTime.now(),
          "amount": amountDouble,
        },
      ]),
      'saved': FieldValue.increment(amountDouble)
    };
  }
}

