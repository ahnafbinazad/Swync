// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_super_parameters
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/model/user_model.dart';
import 'package:test_drive/providers/user_provider.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/reuseable_widgets/reuseable_widgets.dart';
import 'package:test_drive/reuseable_widgets/streak_text.dart';
import 'package:test_drive/screens/workout_screen.dart';
import 'package:test_drive/utils/colour_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Retrieve user data using the provider
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.user;

    // Create an instance of StreakWidgetCreator
    final streakWidgetCreator = StreakWidgetCreator();

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
              MediaQuery.of(context).size.height * 0.00,
              20,
              0,
            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20,),

                    Center(
                      child: Text(
                        // Display username from user data
                        "Hello ${user?.username}",
                        style: TextStyle(
                          fontSize: 24, 
                          color: Colors.black, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Divider(
                        thickness: 1, 
                        color: Colors.black,
                      ),
                    ),

                    // Display user data if available
                    if (user != null) ...[
                      streakWidgetCreator.createTextWidget(user.streakedToday, user.lastStreakTime),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 55), 
                        child: GestureDetector(
                          onTap: () {
                            print("record workout button pressed");
                            // Navigate to the RecordWorkoutScreen




                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5, 
                            height: 70, 
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Record Workout',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Display user data using StatCard
                      StatCard(
                        description: 'Current Streak',
                        imagePath: 'assets/images/streak.png',
                        value: user.streak,
                      ),
                      StatCard(
                        description: 'Workout League Rank',
                        imagePath: 'assets/images/trophy-icon.png',
                        value: user.workoutRank,
                      ),
                      StatCard(
                        description: 'Streak League Rank',
                        imagePath: 'assets/images/award.png',
                        value: user.streakRank,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 100), 
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
