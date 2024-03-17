import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/firebase_options.dart';
import 'package:test_drive/providers/rank_provider.dart';
import 'package:test_drive/providers/user_provider.dart';
import 'package:test_drive/screens/home.dart';
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/screens/ranks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => RankProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool userDetailsFetched = false;
    bool dataPrinted = false; // Add a boolean flag to track printing

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
            );
          } else {
            if (!userDetailsFetched) {
              userProvider.fetchUserDetails();
              userDetailsFetched = true;
            }

            final rankProvider = Provider.of<RankProvider>(context);
            rankProvider.fetchLeaderBoard(); // Call fetchLeaderBoard method

            // Print data if it hasn't been printed already
            if (!dataPrinted) {
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
                print('Streak: ${user.streak}');
                print('Streaked Today: ${user.streakedToday}');
                print('Last Streak Time: ${user.lastStreakTime}');
                print('Monthly Workout Time: ${user.monthlyWorkoutTime}');
                print('Streak Rank: ${user.streakRank}');
                print('Workout Rank: ${user.workoutRank}');
                print('\n');
              } else {
                print('User details not available.');
              }

              // Print rank details
              final leaderBoard = rankProvider.leaderBoard;
              print('Leaderboard Items:');
              leaderBoard.forEach((item) {
                print('User ID: ${item.userId}');
                print('Username: ${item.username}');
                print('Streak: ${item.streak}');
                print('Monthly Workout Time: ${item.monthlyWorkoutTime}');
                print('Streak Rank: ${item.streakRank}');
                print('Workout Rank: ${item.workoutRank}');
                print('\n');
              });

              dataPrinted = true; // Update the flag to indicate that printing is done
            }

            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
                useMaterial3: true,
              ),
              home: HomeScreen(),
            );
          }
        }
      },
    );
  }
}
