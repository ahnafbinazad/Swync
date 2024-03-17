import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class WorkoutTracker extends StatefulWidget {
  final String videoPath;

  WorkoutTracker({required this.videoPath});

  @override
  _WorkoutTrackerState createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  bool _isPlaying = false;
  int _workoutDuration = 0;

  @override
  void initState() {
    super.initState();

    _initializeModel().then((_) {
      _trackWorkoutDuration();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeModel() async {
    try {
      var interpreter = await Interpreter.fromAsset('posenet.tflite');
      // Perform any initialization tasks with the interpreter here
    } catch (e) {
      print('Error initializing model: $e');
    }
  }

  Future<void> _trackWorkoutDuration() async {
    // Fetch the pose estimation model
    var interpreter = await Interpreter.fromAsset('posenet.tflite');
    var input = List.generate(
        interpreter.getInputTensor(0).shape.reduce((a, b) => a * b),
        (index) => 0.0);

    // Start tracking workout duration
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();

    // Read video file
    final file = File(widget.videoPath);
    final List<int> bytes = await file.readAsBytes();
    final List<List<int>> chunkedBytes = chunkBytes(bytes);

    // Iterate through video frames
    for (var byteChunk in chunkedBytes) {
      // Convert frame to input image
      var imgData = img.decodeImage(Uint8List.fromList(byteChunk));
      img.Image convertedImage = img.copyRotate(imgData!, 90); // Adjust rotation if needed

      // Perform pose estimation
      var input = _preprocessImage(convertedImage);
      var output = List.filled(
          interpreter.getOutputTensor(0).shape.reduce((a, b) => a * b), 0.0);
      interpreter.run(input, output);

      // Process the output to determine workout duration
      // Example: Detect workout poses and calculate workout duration based on poses
    }

    // Stop the stopwatch and calculate workout duration in minutes
    stopwatch.stop();
    setState(() {
      _workoutDuration = stopwatch.elapsedMilliseconds ~/ 60000; // Convert to minutes
    });
  }

  List<dynamic> _preprocessImage(img.Image image) {
    // Preprocess image for pose estimation
    // Example: Resize image, normalize pixel values, etc.
    return []; // Placeholder
  }

  List<List<int>> chunkBytes(List<int> bytes, {int chunkSize = 8192}) {
    // Chunk bytes into smaller pieces for processing
    var chunks = <List<int>>[];
    for (var i = 0; i < bytes.length; i += chunkSize) {
      chunks.add(bytes.sublist(i, i + chunkSize > bytes.length ? bytes.length : i + chunkSize));
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tracker'),
      ),
      body: Center(
        child: CircularProgressIndicator(), // Placeholder widget
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Workout Duration: $_workoutDuration minutes',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
