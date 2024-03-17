// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/firebase_options.dart';
import 'package:test_drive/providers/user_provider.dart';
import 'package:test_drive/screens/home.dart';
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/screens/profile.dart';
import 'package:test_drive/screens/ranks.dart';
import 'package:test_drive/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(), // Create an instance of UserProvider
      child: MyApp(), // Wrap MyApp with the UserProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool userDetailsFetched = false; // Track if user details have been fetched

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while authentication state is being determined
          return const CircularProgressIndicator();
        } else {
          final userProvider = Provider.of<UserProvider>(context);
          if (snapshot.data == null) {
            // If user is not authenticated, show the login screen
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
                useMaterial3: true,
              ),
              home: LogInScreen(),
              // home: SignUpScreen(),
            );
          } else {
            // If user is authenticated and user details haven't been fetched yet, fetch user details
            if (!userDetailsFetched) {
              userProvider.fetchUserDetails();
              userDetailsFetched = true; // Mark user details as fetched
            }

            // Print user details only if user details have been fetched
            if (userDetailsFetched) {
              final user = userProvider.user;
              if (user != null) {
                print('User Details:');
                print('User ID: ${user.userId}');
                print('Email: ${user.email}');
                print('Username: ${user.username}');
                print('Total Workout Time: ${user.totalWorkoutTime}');
                print('Total Workout Days: ${user.totalWorkoutDays}');
                print('Best Streak: ${user.bestStreak}');
                print('Best Rank: ${user.bestRank}');
                print('Friends: ${user.friends}');
                print('Streak: ${user.streak}');
                print('Streaked Today: ${user.streakedToday}');
                print('Last Streak Time: ${user.lastStreakTime}');
                print('Monthly Workout Time: ${user.monthlyWorkoutTime}');
                print('Streak Rank: ${user.streakRank}');
                print('Workout Rank: ${user.workoutRank}');
                print('League: ${user.league}');
                print('\n');
              } else {
                print('User details not available.');
              }
            }

            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
                useMaterial3: true,
              ),
              home: HomeScreen(),
              // home: ProfileScreen(),
              // home: RanksScreen(),
            );
          }
        }
      },
    );
  }
}
