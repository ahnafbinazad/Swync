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
    username: 'example_user',
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
                    // SizedBox(height: 20),
                    //TODO: add the hi username thing
                    Center(
                      child: Text(
                        'Hi, ${testUser.username}',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Display user data using StatCard
                    StatCard(
                      description: 'Current Streak',
                      iconData: Icons.person,
                      value: testUser.streak,
                    ),
                    StatCard(
                      description: 'Workout League Rank',
                      iconData: Icons.person,
                      value: testUser.workoutRank,
                    ),
                    StatCard(
                      description: 'Streak League Rank',
                      iconData: Icons.person,
                      value: testUser.streakRank,
                    ),
                    StatCard(
                      description: 'Time Worked Out',
                      iconData: Icons.person,
                      value: formatTotalWorkoutTime(testUser.totalWorkoutTime),
                    ),
                    StatCard(
                      description: 'Days Worked Out',
                      iconData: Icons.person,
                      value: testUser.totalWorkoutDays,
                    ),

                    bestRecordCard(context, testUser.bestStreak, testUser.bestRank),

                    // TODO: make a different card called best record with the best values in it

                    // TODO: add cards according to the UI 
                    SizedBox(height: 20), // Adjust spacing before the logout button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LogInScreen()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('Logout'),
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
