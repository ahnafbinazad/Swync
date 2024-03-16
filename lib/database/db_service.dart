import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      "totalWorkoutTime" : 0,
      "totalWorkoutDays" : 0,
      "bestStreak" : 0,
      "bestRank" : {},
      "friends" : [],
      "streak" : 0,
      "monthlyWorkoutTime" : 0,
      "streakRank" : 0,
      "workoutRank" : 0,
      "league" : 0,
    });

  await _db.collection("leaderBoard").doc(fUser.uid).set({
      "userId" : fUser.uid,
      "username" : username,
      "streak" : 0,
      "monthlyWorkoutTime" : 0,
      "streakRank" : 0,
      "workoutRank" : 0,
      "league" : 0,
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
    // final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    final userData = UserModel.fromSnapshot(snapshot); // Directly using the snapshot


    return userData;
  }
}
