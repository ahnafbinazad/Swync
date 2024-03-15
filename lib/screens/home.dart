// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/reuseable_widgets/reuseable_widgets.dart';
import 'package:test_drive/utils/colour_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.01,
              20,
              0,
            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 50,),

                    Center(
                      child: Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black, 
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),

                    Center(
                      child: Text(
                        // set to username from db
                        'ahnafazad',
                        style: TextStyle(
                          fontSize: 30, 
                          color: Colors.black, 
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),

                    Divider(
                      thickness: 1, 
                      color: Colors.black87.withOpacity(0.4),
                    ),

                    SizedBox(height: 10,),

                    // set time accordingly
                    Center(
                      child: Text(
                        'You Have\nTIME\nTo Maintain Your Streak',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26, 
                          color: Colors.black, 
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),
                    
                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20), // Adjust the horizontal padding as needed
                      child: GestureDetector(
                        onTap: () {
                          print("record workout button pressed");
                          // This is where you would add the functionality to record workouts
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5, // Adjust the width of the button as needed
                          height: 50, // Adjust the height of the button as needed
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Record Workout',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),



                    SizedBox(height: 10),

                    // Display user data using StatCard
                    StatCard(
                      description: 'Current Streak',
                      imagePath: 'assets/images/streak.png',
                      value: 30,
                    ),
                    StatCard(
                      description: 'Workout League Rank',
                      imagePath: 'assets/images/trophy1.png',
                      value: 30,
                    ),
                    StatCard(
                      description: 'Streak League Rank',
                      imagePath: 'assets/images/trophy1.png',
                      value: 30,
                    ),
                  ],
                ),
                SizedBox(height: 80), 
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(isSelectedIndex: 1)
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Card ${DateTime.now().millisecondsSinceEpoch}',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
