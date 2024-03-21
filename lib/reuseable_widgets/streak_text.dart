import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/database/db_service.dart';

class StreakWidgetCreator {
  Widget createTextWidget(bool streakedToday, DateTime? lastStreakTime) {
    return StreakWidget(
      streakedToday: streakedToday,
      lastStreakTime: lastStreakTime,
    );
  }
}

class StreakWidget extends StatefulWidget {
  final bool streakedToday;
  final DateTime? lastStreakTime;

  StreakWidget({
    required this.streakedToday,
    this.lastStreakTime,
  });

  @override
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  late Timer _timer;
  late Duration _remainingTime;
  static final DbService _dbService = DbService(FirebaseFirestore.instance, FirebaseAuth.instance);

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateRemainingTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateRemainingTime() {
    DateTime now = DateTime.now();
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    _remainingTime = endOfDay.difference(now);
    setState(() {
      if (!widget.streakedToday && _remainingTime <= Duration.zero) {
        _resetStreak();
      }
    });
  }

  Future<void> _resetStreak() async {
    // Call resetStreak method from DbService
    await _dbService.resetStreak();
  }

  @override
  Widget build(BuildContext context) {
    String hours = _remainingTime.inHours.toString().padLeft(2, '0');
    String minutes = _remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = _remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    String timeText = '$hours:$minutes:$seconds';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Center(
        child: widget.streakedToday
            ? const Text(
                'You have completed your streak for today! \n\nWant to rise up the leaderboards?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                'You have\n$timeText\nto keep streaking',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
