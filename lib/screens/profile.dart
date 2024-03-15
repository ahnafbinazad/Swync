import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_drive/model/user_model.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/reuseable_widgets/reuseable_widgets.dart';
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/utils/colour_utils.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel testUser = UserModel(
    userId: 'user123',
    email: 'example@example.com',
    username: 'example_user',
    totalWorkoutTime: 100,
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(height: 20),
                    //TODO: add the hi username thing
                    // Display user data using StatCard
                    StatCard(
                      description: 'Current Streak',
                      iconData: Icons.person,
                      value: testUser.streak,
                    ),
                    StatCard(
                      description: 'Workout League Rank',
                      iconData: Icons.person,
                      value: testUser.username,
                    ),
                    StatCard(
                      description: 'Streak Rank',
                      iconData: Icons.person,
                      value: testUser.streakRank,
                    ),
                    StatCard(
                      description: 'League Rank',
                      iconData: Icons.person,
                      value: testUser.username,
                    ),
                    StatCard(
                      description: 'Total time worked out',
                      iconData: Icons.person,
                      value: testUser.username,
                    ),
                    StatCard(
                      description: 'Days worked out',
                      iconData: Icons.person,
                      value: testUser.username,
                    ),
                    //TODO: make a different card called best record with the best values in it

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
