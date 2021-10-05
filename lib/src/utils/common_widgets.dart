import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget txtViewMediumBold(String text, Color color, double size,
      {FontWeight weight}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins'),
    );
  }
}
