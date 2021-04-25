import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:travel_budget/widgets/trip_card.dart';


class PastTripsView extends StatefulWidget {
  @override
  _PastTripsViewState createState() => _PastTripsViewState();
}

class _PastTripsViewState extends State<PastTripsView> {
  TextEditingController _searchController = TextEditingController();

  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }


  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if(_searchController.text != "") {
      for(var tripSnapshot in _allResults){
        var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();

        if(title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }

    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    final uid = Provider.of(context).auth.getCurrentUID();
    var data = await FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('trips')
        .where("endDate", isLessThanOrEqualTo: DateTime.now())
        .orderBy('endDate')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Past Trips", style: TextStyle(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _resultsList.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, _resultsList[index]),
            )

          ),
        ],
      ),
    );
  }
}