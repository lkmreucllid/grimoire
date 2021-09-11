import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

final double _clipValue = 25;

class MyCustomClipperUpper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path() // Start from (0,0)

      ..lineTo(0, size.height - _clipValue)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyCustomClipperLower extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path() // Start from (0,0)

      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, _clipValue)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyCustomClipperMiddle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path() // Start from (0,0)

      ..lineTo(0, size.height - _clipValue)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, _clipValue)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
