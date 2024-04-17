import 'dart:async';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/database/db_service.dart';
import 'package:test_drive/screens/home.dart';

class RecordWorkoutScreen extends StatefulWidget {
  @override
  _RecordWorkoutScreenState createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  final DbService _dbService = DbService(FirebaseFirestore.instance, FirebaseAuth.instance);
  CameraController? _cameraController;
  bool _isRecording = false;
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _workoutDuration = '00:00:00';

  @override
  void initState() {
    super.initState();
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
      print('Error initializing camera: $e');
    }
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
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
      _updateDuration();
    });

    // Show "analysing workout" popup
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Analysing Workout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 3));

    Navigator.pop(context);

    final duration = _stopwatch.elapsed;
    final totalSeconds = duration.inSeconds;
    final minutes = totalSeconds ~/ 60;

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
                  Navigator.pop(context);
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
          _dbService.addStreak();
          _dbService.updateWorkoutTime(minutes);
          return AlertDialog(
            title: Text('Workout Duration'),
            content: Text('You recorded a workout for $minutes minutes'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Record Workout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: CameraPreview(_cameraController!),
                ),
                Positioned(
                  bottom: 20.0,
                  child: Text(
                    'Workout Duration: $_workoutDuration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton.icon(
              onPressed: _toggleRecording,
              icon: Icon(_isRecording ? Icons.stop : Icons.video_call),
              label: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
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
