import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String helperText;

  const MoneyTextField({Key key, @required this.controller, this.helperText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: TextField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.attach_money),
          helperText: helperText,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        autofocus: false,
      ),
    );
  }
}




