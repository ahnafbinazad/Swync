import 'dart:async';
import 'package:flutter/material.dart';

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
    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    String timeText =
        '${_remainingTime.inHours}:${_remainingTime.inMinutes.remainder(60)}:${_remainingTime.inSeconds.remainder(60)}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Center(
        child: widget.streakedToday
            ? const Text(
              // TO-DO: make this look nicer or be more dynamic
                'You have completed your streak for today! \n\nWant to rise up the leaderboards?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
              // TO-DO: make this look nicer or be more dynamic
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
