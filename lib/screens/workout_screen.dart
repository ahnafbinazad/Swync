import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// import 'package:permission_handler/permission_handler.dart';

// // Check and request camera permissions
// Future<void> _requestCameraPermission() async {
//   if (await Permission.camera.request().isGranted) {
//     // Permission is granted, proceed with camera usage
//   } else {
//     // Permission denied, handle accordingly (e.g., show a message to the user)
//   }
// }


class RecordWorkoutScreen extends StatefulWidget {
  @override
  _RecordWorkoutScreenState createState() => _RecordWorkoutScreenState();
}

class _RecordWorkoutScreenState extends State<RecordWorkoutScreen> {
  late Future<CameraController> _cameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraControllerFuture = _initializeCamera();
  }

  Future<CameraController> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    final controller = CameraController(firstCamera, ResolutionPreset.high);
    await controller.initialize();
    return controller;
  }

  @override
  void dispose() {
    _cameraControllerFuture.then((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Workout'),
      ),
      body: FutureBuilder<CameraController>(
        future: _cameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.data != null) {
              final controller = snapshot.data!;
              return CameraPreview(controller);
            } else {
              return Center(
                child: Text('Unable to initialize camera.'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RecordWorkoutScreen(),
  ));
}
