class UserModel {
  final String userId;
  final String email;
  final String username;
  final int totalWorkoutTime;
  final int totalWorkoutDays;
  final int bestStreak;
  final Map<String, dynamic> bestRank;
  final List<dynamic> friends;
  final int streak;
  final int monthlyWorkoutTime;
  final int streakRank;
  final int workoutRank;
  final int league;

  UserModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.totalWorkoutTime,
    required this.totalWorkoutDays,
    required this.bestStreak,
    required this.bestRank,
    required this.friends,
    required this.streak,
    required this.monthlyWorkoutTime,
    required this.streakRank,
    required this.workoutRank,
    required this.league,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      email: data['email'],
      username: data['username'],
      totalWorkoutTime: data['totalWorkoutTime'],
      totalWorkoutDays: data['totalWorkoutDays'],
      bestStreak: data['bestStreak'],
      bestRank: data['bestRank'],
      friends: List<dynamic>.from(data['friends']),
      streak: data['streak'],
      monthlyWorkoutTime: data['monthlyWorkoutTime'],
      streakRank: data['streakRank'],
      workoutRank: data['workoutRank'],
      league: data['league'],
    );
  }
}
