import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/firebase_options.dart';
import 'package:test_drive/screens/home.dart'; // Import your HomeScreen widget
import 'package:test_drive/screens/login.dart';
import 'package:test_drive/screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(MyApp());
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
            //once testing is done, set to LogInScreen() : HomeScreen()
            home: snapshot.data == null ? LogInScreen() : ProfileScreen(),
          );
        }
      },
    );
  }
}
