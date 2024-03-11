// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColour("#f89302"),
              hexStringToColour("#eeee02"),
              hexStringToColour("#fef2e0")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(
            'Ranks Screen',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        isSelectedIndex: 2, // Set the selected index to 2 for the RanksScreen
      ),
    );
  }
}
