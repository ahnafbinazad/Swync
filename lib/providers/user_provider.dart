import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_drive/database/db_service.dart'; // Import your DbService
import 'package:test_drive/model/user_model.dart'; // Import your UserModel

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> fetchUserDetails() async {
    final dbService = DbService(FirebaseFirestore.instance, FirebaseAuth.instance);
    _user = await dbService.getUserDetails(); // Fetch user details
    notifyListeners(); // Notify listeners that the user data has been updated
  }
}
