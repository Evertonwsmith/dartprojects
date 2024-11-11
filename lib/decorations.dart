import 'package:flutter/material.dart';

class AppDecorations {
  static BoxDecoration colorDecoration(_targetColor) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: _targetColor,
    );
  }

  static InputDecoration inputDecoration() {
    return InputDecoration(
        labelText: 'Enter RGB values (1-255) (Format: \"R,G,B\")');
  }

  static ButtonStyle buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      minimumSize: MaterialStateProperty.all(Size(200, 50)), // set minimum size
      padding: MaterialStateProperty.all(EdgeInsets.all(16)), // add padding
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 24)), // increase font size
    );
  }
}
