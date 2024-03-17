import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String username;
  final int totalWorkoutTime;
  final int totalWorkoutDays;
  final int bestStreak;
  final Map<String, dynamic> bestRank;
  final int streak;
  final bool streakedToday;
  final DateTime? lastStreakTime;
  final int monthlyWorkoutTime;
  final int streakRank;
  final int workoutRank;

  UserModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.totalWorkoutTime,
    required this.totalWorkoutDays,
    required this.bestStreak,
    required this.bestRank,
    required this.streak,
    required this.streakedToday,
    required this.lastStreakTime,
    required this.monthlyWorkoutTime,
    required this.streakRank,
    required this.workoutRank,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
      userId: document.id,
      email: data['email'],
      username: data['username'],
      totalWorkoutTime: data['totalWorkoutTime'],
      totalWorkoutDays: data['totalWorkoutDays'],
      bestStreak: data['bestStreak'],
      bestRank: data['bestRank'],
      streak: data['streak'],
      streakedToday: data['streakedToday'],
      lastStreakTime: data['lastStreakTime'] != null ? DateTime.parse(data['lastStreakTime']) : null,
      monthlyWorkoutTime: data['monthlyWorkoutTime'],
      streakRank: data['streakRank'],
      workoutRank: data['workoutRank'],
    );
  }
}
