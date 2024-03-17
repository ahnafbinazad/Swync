// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_drive/reuseable_widgets/navbar.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RanksScreen extends StatefulWidget {
  @override
  _RanksScreenState createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  String _selectedTable = 'Monthly Minutes Worked Out'; // Default table

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: _selectedTable,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTable = newValue!;
                      });
                    },
                    items: <String>[
                      'Monthly Minutes Worked Out',
                      'Streaks',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: _selectedTable == 'Monthly Minutes Worked Out'
                      ? _buildDataTable(_monthlyWorkoutData)
                      : _buildDataTable(_streakData),
                ),
              ],
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

  Widget _buildDataTable(List<Map<String, dynamic>> data) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Username')),
        DataColumn(
            label: Text(_selectedTable == 'Monthly Minutes Worked Out'
                ? 'Minutes'
                : 'Streak')),
      ],
      rows: data
          .map((item) => DataRow(cells: [
                DataCell(Text(item['username'])),
                DataCell(Text(
                    '${item[_selectedTable == 'Monthly Minutes Worked Out' ? 'monthlyWorkoutTime' : 'streak']}')),
              ]))
          .toList(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RanksScreen(),
  ));
}
