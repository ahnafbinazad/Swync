// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_drive/model/user_model.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/reuseable_widgets/reuseable_widgets.dart';
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/utils/colour_utils.dart';
import 'package:test_drive/utils/time_formatter.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel testUser = UserModel(
    userId: 'user123',
    email: 'example@example.com',
    username: 'ahnafazad',
    totalWorkoutTime: 10000,
    totalWorkoutDays: 20,
    bestStreak: 10,
    bestRank: {'silver': '1st'},
    friends: [],
    streak: 5,
    monthlyWorkoutTime: 50,
    streakRank: 2,
    workoutRank: 3,
    league: 1,
  );

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    SizedBox(height: 20),

                    Center(
                      child: Text(
                        testUser.username,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black, 
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),

                    Center(
                      child: Text(
                        'Performance Metrics',
                        style: TextStyle(
                          fontSize: 26, 
                          color: Colors.black, 
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Display user data using StatCard
                    StatCard(
                      description: 'Current Streak',
                      imagePath: 'assets/images/streak.png',
                      value: testUser.streak,
                    ),
                    StatCard(
                      description: 'Workout League Rank',
                      imagePath: 'assets/images/trophy1.png',
                      value: testUser.workoutRank,
                    ),
                    StatCard(
                      description: 'Streak League Rank',
                      imagePath: 'assets/images/trophy1.png',
                      value: testUser.streakRank,
                    ),
                    StatCard(
                      description: 'Time Worked Out',
                      imagePath: 'assets/images/stopwatch.png',
                      value: formatTotalWorkoutTime(testUser.totalWorkoutTime),
                    ),
                    StatCard(
                      description: 'Days Worked Out',
                      imagePath: 'assets/images/calendar.png',
                      value: testUser.totalWorkoutDays,
                    ),

                    bestRecordCard(context, testUser.bestStreak, testUser.bestRank),

                    SizedBox(height: 10), // Adjust spacing before the logout button

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust the horizontal padding as needed
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LogInScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    ),



                    SizedBox( height: 100,)
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(isSelectedIndex: 0),
          ),
        ],
      ),
    );
  }
}
