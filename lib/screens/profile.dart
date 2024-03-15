import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_drive/model/user_model.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
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
    bestRank: {'rank': '1st'},
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Profile Screen',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Display user data if needed
                  Text('UserID: ${testUser.userId}'),
                  Text('Username: ${testUser.username}'),
                  // Add more Text widgets to display other user data as needed
                  ElevatedButton(
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
                ],
              ),
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
