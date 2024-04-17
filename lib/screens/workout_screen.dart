import 'dart:async'; // Import statement for Timer
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:test_drive/database/db_service.dart';
import 'package:test_drive/screens/home.dart';
 
class RecordWorkoutScreen extends StatefulWidget {
  @override
  _RecordWorkoutScreenState createState() => _RecordWorkoutScreenState();
}
 
class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  final DbService _dbService = DbService(FirebaseFirestore.instance,
      FirebaseAuth.instance); // Declare and initialize DbService instance
  CameraController? _cameraController; // Initialize as null
  bool _isRecording = false;
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _workoutDuration = '00:00:00';
 
  @override
  void initState() {
    super.initState();
    // Initialize the camera controller
    _initializeCamera();
    _dbService.syncAppUser();
  }
 
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }
      final firstCamera = cameras.first;
      _cameraController = CameraController(firstCamera, ResolutionPreset.high);
      await _cameraController!.initialize();
      setState(() {});
    } catch (e) {
      // Handle error appropriately
      print('Error initializing camera: $e');
    }
  }
 
  void _startRecording() {
    setState(() {
      _isRecording = true;
      _stopwatch.reset();
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          _updateDuration();
        });
      });
    });
    _cameraController!.startVideoRecording();
  }
 
  void _stopRecording() async {
    setState(() {
      _isRecording = false;
      _stopwatch.stop();
      _timer.cancel();
      _updateDuration(); // Update UI with precise duration
    });
 
    // Show "analysing workout" popup
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the popup
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Analysing Workout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // Circular motion indicator
              SizedBox(height: 10),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
 
    // Delay for 3 seconds
    await Future.delayed(Duration(seconds: 3));
 
    // Close the "analysing workout" popup
    Navigator.pop(context);
 
    final duration = _stopwatch.elapsed;
    final totalSeconds = duration.inSeconds;
    final minutes = totalSeconds ~/
        60; // Use integer division to round down to lower minute
 
    // Show a dialog with the recorded workout time
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (minutes < 2) {
          return AlertDialog(
            title: Text('Workout Duration'),
            content: Text(
                'To add to streaks, you are required to workout for 2 minutes.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  // Navigate to HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Okay'),
              ),
            ],
          );
        } else {
          // Call addStreak function if workout duration is over 2 minutes
          _dbService.addStreak();
          // Update workout time if workout duration is over 2 minutes
          _dbService.updateWorkoutTime(minutes);
          return AlertDialog(
            title: Text('Workout Duration'),
            content: Text('You recorded a workout for $minutes minutes'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Navigate to HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Okay'),
              ),
            ],
          );
        }
      },
    );
 
    await _cameraController!.stopVideoRecording();
  }
 
  void _updateDuration() {
    final duration = _stopwatch.elapsed;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    setState(() {
      _workoutDuration = '$minutes:$seconds:$milliseconds';
    });
  }
 
  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // Once _cameraController is initialized, build the UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Workout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CameraPreview(_cameraController!),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Workout Duration: $_workoutDuration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRecording ? null : _startRecording,
                child: Icon(Icons.video_call),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : null,
                child: Icon(Icons.stop),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 
void main() {
  runApp(MaterialApp(
    home: RecordWorkoutScreen(),
  ));
}