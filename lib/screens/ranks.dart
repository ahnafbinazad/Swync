import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RanksScreen extends StatefulWidget {
  @override
  _RanksScreenState createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  String _selectedTable = 'Workouts'; // Default table
  double _glowPosition = 0; // Position of the glow indicator

  // Test data
  List<Map<String, dynamic>> _monthlyWorkoutData = [
    {'username': 'User1', 'monthlyWorkoutTime': 120},
    {'username': 'User2', 'monthlyWorkoutTime': 90},
    {'username': 'User3', 'monthlyWorkoutTime': 150},
  ];

  List<Map<String, dynamic>> _streakData = [
    {'username': 'User1', 'streak': 5},
    {'username': 'User2', 'streak': 3},
    {'username': 'User3', 'streak': 7},
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
                children: [
                  SizedBox(height: 100),
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
                  Expanded(
                    child: _selectedTable == 'Workouts'
                        ? _buildDataTable(_monthlyWorkoutData)
                        : _buildDataTable(_streakData),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> data) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Username')),
        DataColumn(
          label: Text(_selectedTable == 'Workouts' ? 'Minutes' : 'Streak'),
        ),
      ],
      rows: data
          .map(
            (item) => DataRow(cells: [
              DataCell(Text(item['username'])),
              DataCell(Text(
                '${item[_selectedTable == 'Workouts' ? 'monthlyWorkoutTime' : 'streak']}',
              )),
            ]),
          )
          .toList(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RanksScreen(),
  ));
}
