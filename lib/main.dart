import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/database/db_service.dart';
import 'package:test_drive/firebase_options.dart';
import 'package:test_drive/model/user_model.dart';
import 'package:test_drive/screens/home.dart';
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(MyApp());

  // Call getUserDetails and print its result
  final user = await getUserDetails();
  printUserDetails(user);
}

Future<UserModel> getUserDetails() async {
  // Instantiate DbService
  final dbService = DbService(FirebaseFirestore.instance, FirebaseAuth.instance);
  
  // Get user details
  final user = await dbService.getUserDetails();
  
  return user;
}

void printUserDetails(UserModel user) {
  print('User Details:');
  print('------------');
  print('User ID: ${user.userId}');
  print('Email: ${user.email}');
  print('Username: ${user.username}');
  print('Total Workout Time: ${user.totalWorkoutTime}');
  print('Total Workout Days: ${user.totalWorkoutDays}');
  print('Best Streak: ${user.bestStreak}');
  print('Best Rank: ${user.bestRank}');
  print('Friends: ${user.friends}');
  print('Streak: ${user.streak}');
  print('Monthly Workout Time: ${user.monthlyWorkoutTime}');
  print('Streak Rank: ${user.streakRank}');
  print('Workout Rank: ${user.workoutRank}');
  print('League: ${user.league}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator if the authentication state is still loading
          return CircularProgressIndicator();
        } else {
          // If the user is signed in, navigate to the HomeScreen, otherwise, navigate to the LogInScreen
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
            ),
            // set the second screen to whatever is being tested cause otherwise on every hot reload it goes to the homescreen.
            //for testing, second screen can be set to HomeScreen(), ProfileScreen(), or RanksScreen()
            home: snapshot.data == null ? LogInScreen() : HomeScreen(),
          );
        }
      },
    );
  }
}
