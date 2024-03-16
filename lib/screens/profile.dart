// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:test_drive/main.dart';
import 'package:test_drive/model/user_model.dart';
import 'package:test_drive/providers/user_provider.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/reuseable_widgets/reuseable_widgets.dart';
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/utils/colour_utils.dart';
import 'package:test_drive/utils/time_formatter.dart';
import 'package:test_drive/database/db_service.dart'; // Import DbService

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the UserProvider instance using Provider.of
    final userProvider = Provider.of<UserProvider>(context);

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
                    // Display user data using StreamBuilder and conditional rendering
                    Center(
                      child: Text(
                        userProvider.user?.username ?? '', // Use user data from the provider
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Performance Metrics',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Display user data using StatCard
                    StatCard(
                      description: 'Current Streak',
                      imagePath: 'assets/images/streak.png',
                      value: userProvider.user?.streak ?? 0, // Use user data from the provider
                    ),
                    StatCard(
                      description: 'Workout League Rank',
                      imagePath: 'assets/images/trophy-icon.png',
                      value: userProvider.user?.workoutRank ?? 0, // Use user data from the provider
                    ),
                    StatCard(
                      description: 'Streak League Rank',
                      imagePath: 'assets/images/award.png',
                      value: userProvider.user?.streakRank ?? 0, // Use user data from the provider
                    ),
                    StatCard(
                      description: 'Time Worked Out',
                      imagePath: 'assets/images/coming-soon.png',
                      value: formatTotalWorkoutTime(userProvider.user?.totalWorkoutTime ?? 0), // Use user data from the provider
                    ),
                    StatCard(
                      description: 'Days Worked Out',
                      imagePath: 'assets/images/event.png',
                      value: userProvider.user?.totalWorkoutDays ?? 0, // Use user data from the provider
                    ),
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
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 75),
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
