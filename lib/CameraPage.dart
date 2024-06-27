import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:test2/Gloya.dart';
import 'package:test2/MisgertAz.dart';
import 'package:test2/Strip.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  final String
      camera; // 'final' instead of 'late' here, as it will be set via constructor
  final String firstName;
  final String seconedName;
  final String date;

  const CameraPage(
      {Key? key,
      required this.camera,
      required this.firstName,
      required this.seconedName,
      required this.date})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState(
      camera: camera,
      date: date,
      seconedName: seconedName,
      firstName: firstName);
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  late String _imagePath;
  late String _imagePath2;
  late String _imagePath3;
  final String
      camera; // 'final' instead of 'late' here, as it is set via constructor
  final String firstName;
  final String seconedName;
  final String date;

  _CameraPageState(
      {Key? key,
      required this.camera,
      required this.firstName,
      required this.seconedName,
      required this.date});

  @override
  void initState() {
    super.initState();
    requestCameraPermission();
    _initCamera();
  }

  @override
  void didUpdateWidget(CameraPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.camera != widget.camera) {
      _initCamera();
    }
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      if (await Permission.camera.request().isGranted) {
        log('Camera permission granted');
      } else {
        log('Camera permission denied');
      }
    } else {
      log('Camera permission already granted');
    }
  }

  Future<void> _initCamera() async {
    if (await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _cameraController?.initialize();
      setState(() {});

      // Wait for the camera to initialize, then take a picture after 3 seconds
      _initializeControllerFuture?.then((_) {
        Future.delayed(Duration(seconds: 1), () {
          _takePicture();
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission not granted')),
      );
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) {
      return;
    }

    if (_cameraController!.value.isTakingPicture) {
      return;
    }

    try {
      final image = await _cameraController!.takePicture();
      setState(() {
        _imagePath = image.path;
      });
      if (camera == "simpleMisgert") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Gloya(
                camera: camera,
                imagePath: _imagePath,
                firstName: firstName,
                seconedName: seconedName,
                date: date),
          ),
        );
      }
      if (camera == "azMisgert") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MisgertAz(
                camera: camera,
                imagePath: _imagePath,
                firstName: firstName,
                seconedName: seconedName,
                date: date),
          ),
        );
      }
      if (camera == "stripMisgert") {
        Future.delayed(Duration(seconds: 1));
        final image2 = await _cameraController!.takePicture();
        setState(() {
          _imagePath2 = image2.path;
        });
        Future.delayed(Duration(seconds: 1));
        final image3 = await _cameraController!.takePicture();
        setState(() {
          _imagePath3 = image3.path;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Strip(
                camera: camera,
                imagePath2: _imagePath2,
                imagePath3: _imagePath3,
                imagePath: _imagePath,
                firstName: firstName,
                seconedName: seconedName,
                date: date),
          ),
        );
      }
      // Navigate to Page5 after taking the picture
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: screenSize.width * 1,
              child: CameraPreview(_cameraController!),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}




// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:insta_moment/Gloya.dart';
// import 'package:insta_moment/MisgertAz.dart';
// import 'package:insta_moment/Strip.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class CameraPage extends StatefulWidget {
//   final String camera; // 'final' instead of 'late' here, as it will be set via constructor
//
//   final String firstName;
//   final String seconedName;
//   final String date;
//   const CameraPage({Key? key, required this.camera, required this.firstName, required this.seconedName, required this.date}) : super(key: key);
//
//   @override
//   _CameraPageState createState() => _CameraPageState(camera: camera,date: date,seconedName: seconedName,firstName: firstName);
// }
//
// class _CameraPageState extends State<CameraPage> {
//   CameraController? _cameraController;
//   Future<void>? _initializeControllerFuture;
//   late String _imagePath;
//   late String _imagePath2;
//   late String _imagePath3;
//   final String camera; // 'final' instead of 'late' here, as it is set via constructor
//
//   final String firstName;
//   final String seconedName;
//   final String date;
//   _CameraPageState({Key? key, required this.camera, required this.firstName, required this.seconedName, required this.date});
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//   }
//
//   Future<void> _initCamera() async {
//     if (await Permission.camera.request().isGranted) {
//       final cameras = await availableCameras();
//       final frontCamera = cameras.firstWhere(
//               (camera) => camera.lensDirection == CameraLensDirection.front);
//
//       _cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.high,
//       );
//
//       _initializeControllerFuture = _cameraController?.initialize();
//       setState(() {});
//
//       // Wait for the camera to initialize, then take a picture after 3 seconds
//       _initializeControllerFuture?.then((_) {
//         Future.delayed(Duration(seconds: 1), () {
//           _takePicture();
//         });
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Camera permission not granted')),
//       );
//     }
//   }
//
//   Future<void> _takePicture() async {
//     if (!_cameraController!.value.isInitialized) {
//       return;
//     }
//
//     if (_cameraController!.value.isTakingPicture) {
//       return;
//     }
//
//     try {
//       final image = await _cameraController!.takePicture();
//       setState(() {
//         _imagePath = image.path;
//       });
//       if (camera == "simpleMisgert")
//         {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Page6(imagePath: _imagePath,firstName: firstName,seconedName: seconedName,date: date),
//             ),
//           );
//         }
//         if (camera == "azMisgert"){
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Page7(imagePath: _imagePath,firstName: firstName,seconedName: seconedName,date: date),
//
//             ),
//           );
//         }
//           if (camera == "stripMisgert"){
//             Future.delayed(Duration(seconds: 1));
//             final image2 = await _cameraController!.takePicture();
//             setState(() {
//               _imagePath2 = image2.path;
//             });
//             Future.delayed(Duration(seconds: 1));
//             final image3 = await _cameraController!.takePicture();
//             setState(() {
//               _imagePath3 = image3.path;
//             });
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Page8(imagePath2: _imagePath2 , imagePath3 : _imagePath3 ,imagePath: _imagePath,firstName: firstName,seconedName: seconedName,date: date),
//               ),
//             );
//           }
//       // Navigate to Page5 after taking the picture
//
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Container(width: screenSize.width * 1,
//                child:  CameraPreview(_cameraController!),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
