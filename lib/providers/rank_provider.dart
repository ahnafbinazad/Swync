import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore
import 'package:test_drive/database/db_service.dart';
import 'package:test_drive/model/leaderboard_model.dart';

class RankProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instantiate FirebaseFirestore

  List<LeaderBoardModel> _leaderBoard = [];
  List<LeaderBoardModel> get leaderBoard => _leaderBoard;

  // Method to fetch leaderboard data and listen for changes
  Future<void> fetchLeaderBoard() async {
    final DbService _dbService = DbService(_firestore, FirebaseAuth.instance); // Create instance of DbService
    // Fetch initial leaderboard data
    try {
      _leaderBoard = await _dbService.getLeaderBoard();
      notifyListeners(); // Notify listeners that the leaderboard data has been updated
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }

    // Listen for changes to leaderboard data in Firestore
    _firestore.collection('leaderBoard').snapshots().listen((snapshot) {
      _leaderBoard.clear(); // Clear existing leaderboard data
      for (final doc in snapshot.docs) {
        final leaderBoardData = LeaderBoardModel.fromSnapshot(doc); // Convert document to LeaderBoardModel
        _leaderBoard.add(leaderBoardData); // Add data to leaderboard list
      }
      notifyListeners(); // Notify listeners that the leaderboard data has been updated
    });
  }
}
