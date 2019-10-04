import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  Map budgetTypes;
  String travelType;


  Trip(
      this.title,
      this.startDate,
      this.endDate,
      this.budget,
      this.budgetTypes,
      this.travelType
      );

  // formatting for upload to Firbase
  Map<String, dynamic> toJson() => {
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
    'budget': budget,
    'budgetTypes': budgetTypes,
    'travelType': travelType,
  };

  // creating a Trip object from a firebase snapshot
  Trip.fromSnapshot(DocumentSnapshot snapshot) :
      title = snapshot['title'],
      startDate = snapshot['startDate'].toDate(),
      endDate = snapshot['endDate'].toDate(),
      budget = snapshot['budget'],
      budgetTypes = snapshot['budgetTypes'],
      travelType = snapshot['travelType'];



  Map<String, Icon> types() => {
    "car": Icon(Icons.directions_car, size: 50),
    "bus": Icon(Icons.directions_bus, size: 50),
    "train": Icon(Icons.train, size: 50),
    "plane": Icon(Icons.airplanemode_active, size: 50),
    "ship": Icon(Icons.directions_boat, size: 50),
    "other": Icon(Icons.directions, size: 50),
  };
}

