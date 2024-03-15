import 'package:flutter/material.dart';
import 'package:test_drive/screens/home.dart';
import 'package:test_drive/screens/profile.dart';
import 'package:test_drive/screens/ranks.dart';


List<IconData> navIcons = [
  Icons.person,
  Icons.home,
  Icons.leaderboard
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
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
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
                Icon(
                  navIcons[index],
                  color: isSelected ? Colors.black : Colors.grey,
                ),
                SizedBox(height: 4),
                Text(
                  navTitles[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
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
