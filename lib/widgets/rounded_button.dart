import 'package:flutter/material.dart';

// ignore: deprecated_member_use
class RoundedButton extends RaisedButton {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  const RoundedButton({@required this.onPressed, this.child, this.color}) : super(onPressed: onPressed, child: child);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
          buttonColor: color,
        )
      ),
      child: Builder(builder: super.build),
    );
  }
}