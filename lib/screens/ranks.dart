import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/reuseable_widgets/rank_table.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RanksScreen extends StatefulWidget {
  @override
  _RanksScreenState createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  String _selectedTable = 'Workouts'; // Default table
  double _glowPosition = 0; // Position of the glow indicator

  // Test data
    final List<Map<String, dynamic>> _monthlyWorkoutData = [
    {'rank': 1, 'username': 'User1', 'monthlyWorkoutTime': 120},
    {'rank': 2, 'username': 'User2', 'monthlyWorkoutTime': 90},
    {'rank': 3, 'username': 'User3', 'monthlyWorkoutTime': 150},
    {'rank': 4, 'username': 'User4', 'monthlyWorkoutTime': 110},
    {'rank': 5, 'username': 'User5', 'monthlyWorkoutTime': 140},
    {'rank': 6, 'username': 'User6', 'monthlyWorkoutTime': 80},
    {'rank': 7, 'username': 'User7', 'monthlyWorkoutTime': 130},
    {'rank': 8, 'username': 'User8', 'monthlyWorkoutTime': 100},
    {'rank': 9, 'username': 'User9', 'monthlyWorkoutTime': 160},
    {'rank': 10, 'username': 'User10', 'monthlyWorkoutTime': 170},
    {'rank': 11, 'username': 'User11', 'monthlyWorkoutTime': 75},
    {'rank': 12, 'username': 'User12', 'monthlyWorkoutTime': 145},
    {'rank': 13, 'username': 'User13', 'monthlyWorkoutTime': 115},
    {'rank': 14, 'username': 'User14', 'monthlyWorkoutTime': 125},
    {'rank': 15, 'username': 'User15', 'monthlyWorkoutTime': 105},
    {'rank': 16, 'username': 'User16', 'monthlyWorkoutTime': 135},
    {'rank': 17, 'username': 'User17', 'monthlyWorkoutTime': 155},
    {'rank': 18, 'username': 'User18', 'monthlyWorkoutTime': 165},
    {'rank': 19, 'username': 'User19', 'monthlyWorkoutTime': 95},
    {'rank': 20, 'username': 'User20', 'monthlyWorkoutTime': 180},
  ];

  final List<Map<String, dynamic>> _streakData = [
    {'rank': 1, 'username': 'User1', 'streak': 5},
    {'rank': 2, 'username': 'User2', 'streak': 3},
    {'rank': 3, 'username': 'User3', 'streak': 7},
    {'rank': 4, 'username': 'User4', 'streak': 4},
    {'rank': 5, 'username': 'User5', 'streak': 6},
    {'rank': 6, 'username': 'User6', 'streak': 2},
    {'rank': 7, 'username': 'User7', 'streak': 8},
    {'rank': 8, 'username': 'User8', 'streak': 5},
    {'rank': 9, 'username': 'User9', 'streak': 9},
    {'rank': 10, 'username': 'User10', 'streak': 10},
    {'rank': 11, 'username': 'User11', 'streak': 3},
    {'rank': 12, 'username': 'User12', 'streak': 7},
    {'rank': 13, 'username': 'User13', 'streak': 6},
    {'rank': 14, 'username': 'User14', 'streak': 5},
    {'rank': 15, 'username': 'User15', 'streak': 4},
    {'rank': 16, 'username': 'User16', 'streak': 8},
    {'rank': 17, 'username': 'User17', 'streak': 9},
    {'rank': 18, 'username': 'User18', 'streak': 11},
    {'rank': 19, 'username': 'User19', 'streak': 2},
    {'rank': 20, 'username': 'User20', 'streak': 12},
  ];


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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80), // Top Padding

                  const Center(
                    child: Text(
                      "Leaderboards",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Top Padding

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildTableSelection('Workouts', 'assets/images/trophy-icon.png'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTableSelection('Streaks', 'assets/images/award.png'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Spacing between table selection and table
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RankTable(
                      userItems: _selectedTable == 'Workouts'
                          ? _monthlyWorkoutData.map((item) {
                              return UserItem(
                                rank: item['rank'],
                                image: 'assets/images/woman.png', // Provide an appropriate image path
                                name: item['username'],
                                point: item['monthlyWorkoutTime'],
                              );
                            }).toList()
                          : _streakData.map((item) {
                              return UserItem(
                                rank: item['rank'],
                                image: 'assets/images/woman.png', // Provide an appropriate image path
                                name: item['username'],
                                point: item['streak'],
                              );
                            }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            left: _glowPosition,
            bottom: 70,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0), // Adjust the opacity here
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.0),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(
              isSelectedIndex: 2, // Set the selected index to 2 for the RanksScreen
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableSelection(String table, String iconPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTable = table;
          _glowPosition = table == 'Workouts' ? 0 : MediaQuery.of(context).size.width * 0.5;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _selectedTable == table ? Colors.white.withOpacity(0.7) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            Text(
              table,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: RanksScreen(),
  ));
}
