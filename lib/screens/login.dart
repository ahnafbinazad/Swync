// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/reuseable_widgets.dart';
import 'package:test_drive/screens/home.dart';
import 'package:test_drive/screens/register.dart';
import 'package:test_drive/utils/colour_utils.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: LinearGradient(colors: [
          hexStringToColour("#f89302"),
          hexStringToColour("#eeee02"),
          hexStringToColour("#fef2e0")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20, 
              MediaQuery.of(context).size.height * 0.1, 
              20, 
              0),
          child: Column(
            children: <Widget>[
              logoWidget("/Users/ahnafazad/Downloads/logo.png"),

              const SizedBox(
                height: 20
                ),

              reusableTextField("Enter User Name", Icons.person_outline, false,
                  _emailTextController),

              const SizedBox(
                height: 20,
              ),

              reusableTextField("Enter Password", Icons.lock_outline_rounded, true,
                  _passwordTextController),

              const SizedBox(
                height: 20,
              ),

              signInSignUpButton(context, true, () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } catch (error) {
                  print("Error: ${error.toString()}");
                  // Show error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      duration: Duration(seconds: 3), // Adjust duration as needed
                    ),
                  );
                }
              }),

              signUpOption()

            ],
           ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

}