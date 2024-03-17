import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/model/leaderboard_model.dart';
import 'package:test_drive/model/user_model.dart';

class DbService extends ChangeNotifier {
  final FirebaseFirestore _db;
  final FirebaseAuth _fbAuth;

  DbService(this._db, this._fbAuth);

  Map<String, dynamic> appUser = {};

  Future<Map<String, dynamic>?> syncAppUser() async {
    var fUser = _fbAuth.currentUser;
    if (fUser == null) {
      return {};
    }
    var user = await _db.collection("users").doc(fUser.uid).get();
    if (user.data() == null) {
      var userData = {
        "email": fUser.email,
        "name": fUser.displayName,
        // add more user data
      };
      _db.collection("users").doc(fUser.uid).set(userData);
      appUser = userData;
    } else {
      appUser = user.data()!;
    }
    notifyListeners();
    return appUser;
  }

  Future<void> addNewUser({email, username}) async {
    var fUser = _fbAuth.currentUser;

    if (fUser == null) {
      print('returning cause fUser is null');
      return;
    }
    print('uid' + fUser.uid);

    await _db.collection("users").doc(fUser.uid).set({
      "userId" : fUser.uid,
      "email" : email,
      "username" : username,
      "totalWorkoutTime" : 500,
      "totalWorkoutDays" : 60,
      "bestStreak" : 234,
      "bestRank" : {},
      "streak" : 23,
      "streakedToday" : false,
      "lastStreakTime" : "2024-03-17T12:00:00",
      "monthlyWorkoutTime" : 24543,
      "streakRank" : 3,
      "workoutRank" : 1,
    });

  await _db.collection("leaderBoard").doc(fUser.uid).set({
      "userId" : fUser.uid,
      "username" : username,
      "streak" : 50,
      "monthlyWorkoutTime" : 69,
      "streakRank" : 0,
      "workoutRank" : 0,
    });
  }

  Future<bool> isUsernameAvailable(String username) async {
    final querySnapshot = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  Future<UserModel> getUserDetails() async {
    var fUser = _fbAuth.currentUser;

    final snapshot = await _db.collection("users").doc(fUser?.uid).get();
    final userData = UserModel.fromSnapshot(snapshot); // Directly using the snapshot


    return userData;
  }

  void onUserDataChanged() {
    var fUser = _fbAuth.currentUser;
    if (fUser != null) {
      _db.collection("users").doc(fUser.uid).snapshots().listen((snapshot) {
        if (snapshot.exists) {
          final userData = UserModel.fromSnapshot(snapshot);
          // You can do something with userData here, like update the local state or notify listeners
          print('User data changed: $userData');
          getUserDetails(); // Call getUserDetails when user data changes
        }
      });
    }
  }

  Future<List<LeaderBoardModel>> getLeaderBoard() async {
    List<LeaderBoardModel> leaderBoardList = [];

    try {
      final QuerySnapshot querySnapshot =
          await _db.collection("leaderBoard").get();

      for (final doc in querySnapshot.docs) {
        final leaderBoardData = LeaderBoardModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        leaderBoardList.add(leaderBoardData);
      }
    } catch (e) {
      print("Error retrieving leader board: $e");
    }

    return leaderBoardList;
  }
}
