import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/database/db_service.dart';
import 'package:test_drive/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Method to fetch user details and listen for changes
  void fetchUserDetails() async {
    final dbService = DbService(FirebaseFirestore.instance, FirebaseAuth.instance);
    
    // Fetch initial user details
    _user = await dbService.getUserDetails();
    notifyListeners(); // Notify listeners that the user data has been updated

    // Listen for changes to user data in Firestore
    final userDoc = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    userDoc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        _user = UserModel.fromSnapshot(snapshot); // Update user data
        notifyListeners(); // Notify listeners that the user data has been updated
      }
    });
  }
}
