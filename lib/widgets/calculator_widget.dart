import 'package:flutter/material.dart';
import 'package:travel_budget/widgets/money_text_field.dart';
import 'package:travel_budget/models/Trip.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalculatorWidget extends StatefulWidget {
  final Trip trip;

  CalculatorWidget({
    @required this.trip,
  });

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  TextEditingController _moneyController = TextEditingController();
  int _saved;
  int _needed;

  @override
  void initState() {
    super.initState();
    _saved = (widget.trip.saved ?? 0.0).floor();
    _needed = (widget.trip.budget.floor() * widget.trip.getTotalTripDays()) - _saved;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.cyan,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("\$$_saved", style: TextStyle(fontSize: 60)),
                      Text("Saved", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Container(
                    height: 80,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 5,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text("\$$_needed", style: TextStyle(fontSize: 60)),
                      Text("Needed", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 40.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MoneyTextField(
                      controller: _moneyController,
                      helperText: "Save Additional",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.green,
                    iconSize: 50,
                    onPressed: () async {
                      setState(() {
                        _saved = _saved + int.parse(_moneyController.text);
                        _needed = _needed - int.parse(_moneyController.text);
                      });
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      await FirebaseFirestore.instance.collection('userData')
                          .doc(uid)
                          .collection('trips')
                          .doc(widget.trip.documentId)
                          .update({'saved': _saved.toDouble()});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    iconSize: 50,
                    onPressed: () async {
                      setState(() {
                        _saved = _saved - int.parse(_moneyController.text);
                        _needed = _needed + int.parse(_moneyController.text);
                      });
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      await FirebaseFirestore.instance.collection('userData')
                          .doc(uid)
                          .collection('trips')
                          .doc(widget.trip.documentId)
                          .update({'saved': _saved.toDouble()});
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  generateAddMoneyBtn(25),
                  generateAddMoneyBtn(50),
                  generateAddMoneyBtn(100),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  RaisedButton generateAddMoneyBtn(int amount) {
    return RaisedButton(
      child: Text("\$$amount"),
      color: Colors.white,
      textColor: Colors.deepOrange,
      onPressed: () async {
        setState(() {
          _saved = _saved + amount;
          _needed = _needed - amount;
        });
        final uid = await Provider.of(context).auth.getCurrentUID();
        await FirebaseFirestore.instance.collection('userData')
            .doc(uid)
            .collection('trips')
            .doc(widget.trip.documentId)
            .update({'saved': _saved.toDouble()});
      },
    );
  }
}
