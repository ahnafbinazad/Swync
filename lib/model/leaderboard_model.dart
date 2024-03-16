import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardModel {
  final String userId;
  final String username;
  final int streak;
  final int monthlyWorkoutTime;
  final int streakRank;
  final int workoutRank;
  final int league;

  LeaderBoardModel({
    required this.userId,
    required this.username,
    required this.streak,
    required this.monthlyWorkoutTime,
    required this.streakRank,
    required this.workoutRank,
    required this.league,
  });

factory LeaderBoardModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data();
  
  if (data == null) {
    throw Exception('Document data is null');
  }

  return LeaderBoardModel(
    userId: document.id,
    username: data['username'],
    streak: data['streak'] ?? 0,
    monthlyWorkoutTime: data['monthlyWorkoutTime'] ?? 0,
    streakRank: data['streakRank'] ?? 0,
    workoutRank: data['workoutRank'] ?? 0,
    league: data['league'] ?? 0,
  );
}

}
