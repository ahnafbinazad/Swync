// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(
              isSelectedIndex: 2, // Set the selected index to 2 for the RanksScreen
            ),
          ),
        ],
      ),
    );
  }
}
