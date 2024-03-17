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
    {'username': 'User1', 'monthlyWorkoutTime': 120},
    {'username': 'User2', 'monthlyWorkoutTime': 90},
    {'username': 'User3', 'monthlyWorkoutTime': 150},
    // Add more data as needed
  ];

  final List<Map<String, dynamic>> _streakData = [
    {'username': 'User1', 'streak': 5},
    {'username': 'User2', 'streak': 3},
    {'username': 'User3', 'streak': 7},
    // Add more data as needed
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
                  SizedBox(height: 60), // Top Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildTableSelection('Workouts', 'assets/images/trophy-icon.png'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildTableSelection('Streaks', 'assets/images/award.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Spacing between table selection and table
                  ProfilePageTable(
                    userItems: _selectedTable == 'Workouts'
                        ? _monthlyWorkoutData.map((item) {
                            return UserItem(
                              rank: item['username'],
                              image: 'assets/images/woman.png', // Provide an appropriate image path
                              name: item['username'],
                              point: item['monthlyWorkoutTime'],
                            );
                          }).toList()
                        : _streakData.map((item) {
                            return UserItem(
                              rank: item['username'],
                              image: 'assets/images/woman.png', // Provide an appropriate image path
                              name: item['username'],
                              point: item['streak'],
                            );
                          }).toList(),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 800),
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
                    offset: Offset(0, 3),
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
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

  Widget _buildDataColumnLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18, // Increase font size
        fontWeight: FontWeight.bold,
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
