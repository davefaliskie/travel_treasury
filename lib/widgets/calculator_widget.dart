import 'package:flutter/material.dart';
import 'package:travel_budget/widgets/money_text_field.dart';

class CalculatorWidget extends StatelessWidget {
  TextEditingController _moneyController = TextEditingController();

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
                      Text("\$800", style: TextStyle(fontSize: 60)),
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
                      Text("\$200", style: TextStyle(fontSize: 60)),
                      Text("Needed", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 50.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MoneyTextField(
                      controller: _moneyController,
                      helperText: "Save Additional",
                    ),
                  ),
                  RaisedButton(
                    child: Text("Saved"),
                    color: Colors.white,
                    textColor: Colors.cyan,
                    onPressed: () {
                      print("Saved pressed");
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("\$25"),
                    color: Colors.white,
                    textColor: Colors.cyan,
                    onPressed: () {
                      print("25 pressed");
                    },
                  ),
                  RaisedButton(
                    child: Text("\$50"),
                    color: Colors.white,
                    textColor: Colors.cyan,
                    onPressed: () {
                      print("25 pressed");
                    },
                  ),
                  RaisedButton(
                    child: Text("\$100"),
                    color: Colors.white,
                    textColor: Colors.cyan,
                    onPressed: () {
                      print("25 pressed");
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
