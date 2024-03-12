import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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

  Future<void> updateUserMetrics(
      int height, int weight, DateTime dob, String gender) async {
    var fUser = _fbAuth.currentUser;
    if (fUser == null) {
      return;
    }

    await _db.collection("users").doc(fUser.uid).update({
      "height": height,
      "weight": weight,
      "dob": dob,
      "gender": gender,
      "onboarded": true,
    });

    syncAppUser();
  }

  Future<void> saveUser() async {
    var fUser = _fbAuth.currentUser;

    if (fUser == null) {
      return;
    }

    await _db.collection("activities").doc().set({
      "userId": fUser.uid,
    });

  }
}