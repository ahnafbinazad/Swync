// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_drive/screens/home.dart';
import 'package:test_drive/screens/profile.dart';
import 'package:test_drive/screens/ranks.dart';

List<String> navIcons = [
  "assets/images/woman.png",
  "assets/images/home.png",
  "assets/images/ranking.png"
];

List<String> navTitles = [
  "Profile",
  "Home",
  "Ranks"
];

class CustomNavBar extends StatelessWidget {
  final int isSelectedIndex; // Selected index received from the calling screen

  CustomNavBar({required this.isSelectedIndex}); // Constructor to receive isSelectedIndex

  final int transitionDuration = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(navIcons.length, (index) {
          bool isSelected = isSelectedIndex == index; // Check if the current index is selected
          return GestureDetector(
            onTap: () {
              // Navigate to the corresponding screen based on the selected index
              switch(index) {
                case 0:
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(),
                      transitionDuration: Duration(milliseconds: transitionDuration), // Adjust the duration here
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                      transitionDuration: Duration(milliseconds: transitionDuration), // Adjust the duration here
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => RanksScreen(),
                      transitionDuration: Duration(milliseconds: transitionDuration), // Adjust the duration here
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: isSelected ? 10 : 0), // Add padding at the bottom when selected
                  decoration: BoxDecoration(
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 15, // Adjust the blur radius to change the height of the shadow
                              spreadRadius: 1, // Adjust the spread radius to change the width of the shadow
                              offset: Offset(0, 5), // Adjust the offset to place the shadow under the icon
                            ),
                          ]
                        : null,
                  ),
                  child: Image.asset(
                    navIcons[index],
                    width: 40, // Adjust the width as needed
                    height: 40, // Adjust the height as needed
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
