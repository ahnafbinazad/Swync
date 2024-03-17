import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/providers/rank_provider.dart';
import 'package:test_drive/providers/user_provider.dart';
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
                    child: Consumer<UserProvider>(
                      builder: (context, userProvider, _) {
                        return RankTable(
                          userItems: _selectedTable == 'Workouts'
                              ? _buildMonthlyWorkoutData(context)
                              : _buildStreakData(context),
                          currentUserName: userProvider.user?.username ?? '',
                        );
                      },
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

  List<UserItem> _buildMonthlyWorkoutData(BuildContext context) {
    final rankProvider = Provider.of<RankProvider>(context);
    return rankProvider.leaderBoard.map((item) {
      return UserItem(
        image: 'assets/images/user.png', // Provide an appropriate image path
        name: item.username,
        point: item.monthlyWorkoutTime,
      );
    }).toList();
  }

  List<UserItem> _buildStreakData(BuildContext context) {
    final rankProvider = Provider.of<RankProvider>(context);
    return rankProvider.leaderBoard.map((item) {
      return UserItem(
        image: 'assets/images/user.png', // Provide an appropriate image path
        name: item.username,
        point: item.streak,
      );
    }).toList();
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
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RankProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: RanksScreen(),
    ),
  ));
}
