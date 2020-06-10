import 'package:flutter/material.dart';

class CustomColors {
  Brightness brightness;
  Color text1, primary;

  CustomColors(Brightness brightness) {
    this.brightness = brightness;

    if(brightness == Brightness.dark) {
      this.text1 = Color(0xff252223);
      this.primary = Color(0xff3c7778);

    } else {
      this.text1 = Colors.white;
      this.primary = Color(0xff57AEAF);
    }
  }

}