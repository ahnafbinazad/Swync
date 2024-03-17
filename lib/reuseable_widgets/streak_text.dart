// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StreakWidgetCreator {
  Widget createTextWidget(bool streakedToday, DateTime? lastStreakTime) {
    if (streakedToday) {
      String timeText = lastStreakTime != null ? 'Last streak time: ${lastStreakTime.toString()}' : '';

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'You have\n$timeText\nto keep streaking',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      // Calculate countdown to 11:59 PM
      DateTime now = DateTime.now();
      DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      Duration remainingTime = endOfDay.difference(now);

      String timeText =
          '${remainingTime.inHours}:${remainingTime.inMinutes.remainder(60)}:${remainingTime.inSeconds.remainder(60)}';

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'You have\n$timeText\nto keep streaking',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}
