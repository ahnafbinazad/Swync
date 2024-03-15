import 'package:flutter/material.dart';

IconData convertPngToIcon(String imagePath) {
  final imageWidget = Image.asset(imagePath, width: 24, height: 24); // Load the image
  final iconData = IconData(0xe000, fontFamily: 'CustomIcons', fontPackage: null);
  return iconData;
}
