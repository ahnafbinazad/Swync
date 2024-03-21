import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:test_drive/database/db_service.dart';
import 'package:test_drive/screens/home.dart';

class RecordWorkoutScreen extends StatefulWidget {
  @override
  _RecordWorkoutScreenState createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  late Future<CameraController> _cameraControllerFuture;
  late CameraController _cameraController;
  bool _isRecording = false;
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  int _elapsedMinutes = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }
      final firstCamera = cameras.first;
      _cameraController = CameraController(firstCamera, ResolutionPreset.high);
      await _cameraController.initialize();
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
      _timer = Timer.periodic(Duration(seconds: 60), (timer) {
        setState(() {
          _elapsedMinutes = _stopwatch.elapsed.inMinutes;
        });
      });
    });
    _cameraController.startVideoRecording();
  }

  void _stopRecording() async {
    setState(() {
      _isRecording = false;
      _stopwatch.stop();
      _timer.cancel();
      _elapsedMinutes = _stopwatch.elapsed.inMinutes;
    });

    // Show a dialog with the recorded workout time
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Workout Duration'),
          content: Text('You recorded a workout for $_elapsedMinutes minutes.'),
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
      },
    );

    await _cameraController.stopVideoRecording();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
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
        children: [
          Expanded(
            child: Stack(
              children: [
                CameraPreview(_cameraController),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Recording Time: $_elapsedMinutes minutes',
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
