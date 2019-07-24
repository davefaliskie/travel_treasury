import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'package:travel_budget/views/first_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Travel Budget App",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
//      home: Home(),
      home: FirstView(),
      routes: <String, WidgetBuilder> {
        '/signUp': (BuildContext context) => Home(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
