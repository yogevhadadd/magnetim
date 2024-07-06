import 'dart:async';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:test2/Gloya.dart';
import 'package:test2/MisgertAz.dart';
import 'package:test2/Strip.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:io';

class CameraPage extends StatefulWidget {
  final String camera; // 'final' instead of 'late' here, as it will be set via constructor
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
  late String _imagePath = ' ';
  late String _imagePath2 = ' ';
  late String _imagePath3 = ' ';
  Uint8List? _imageDisplay1;
  Uint8List? _imageDisplay2;
  Uint8List? _imageDisplay3;
  final String camera;
  final String firstName;
  final String seconedName;
  final String date;
  Timer? _countdownTimer;
  int countdown = 5000;
  int countdownShow = 5000;
  int stripCount = 0;
  int displayTime = 0;
  bool _isFlashing = false; // משתנה מצב להבהוב

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
    startCountdown();
  }

  Uint8List flipImageHorizontally(Uint8List input) {
    // Load the image
    img.Image? image = img.decodeImage(input);
    if (image == null) {
      throw Exception("Failed to decode image");
    }
    // Flip the image horizontally
    img.Image flipped = img.flipHorizontal(image);
    // Convert back to Uint8List
    return Uint8List.fromList(img.encodeJpg(flipped));
  }

  Future<Uint8List> flipImageHorizontally1(Uint8List input) async {
    final completer = Completer<Uint8List>();
    Future(() {
      final img.Image? image = img.decodeImage(input);
      if (image == null) {
        completer.completeError("Failed to decode image");
      } else {
        final img.Image flipped = img.flipHorizontal(image);
        completer.complete(Uint8List.fromList(img.encodeJpg(flipped)));
      }
    });
    return completer.future;
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
      displayTime = (countdown ~/ 1000);
      if (countdown > 0 ) {
          if (stripCount == 3){
            timer.cancel();
          }
          if (stripCount == 0
              || stripCount == 1 && _imagePath != ' '
              || stripCount == 2 && _imagePath2 != ' ' ) {
            countdown = countdown - 10;
          }
      } else
      {
        if (camera == "simpleMisgert" || camera == "azMisgert" || stripCount == 3) {
          // print("simpleMisgert");
        }
      }
      if (countdown == 0 ) {
        countdown = -1;
        _takePicture();
      }
    }
    );
    });
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
              (camera) => camera.lensDirection == CameraLensDirection.front);

      _cameraController = CameraController(
        frontCamera,
        // ResolutionPreset.high,
        // ResolutionPreset.max, // או כל ערך אחר שמתאים לרזולוציה גבוהה
        ResolutionPreset.max, // או כל ערך אחר שמתאים לרזולוציה גבוהה
        enableAudio: true,
      );
      _initializeControllerFuture = _cameraController?.initialize();
      setState(() {});
      // Wait for the camera to initialize, then take a picture after 3 seconds
      _initializeControllerFuture?.then((_) {
        });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission not granted')),
      );
    }
  }

  // Future<void> _takePicture() async {
  //   if (!_cameraController!.value.isInitialized) {
  //     return;
  //   }
  //   if (_cameraController!.value.isTakingPicture) {
  //     return;
  //   }
  //   try {
  //     _flashScreen(); // הפעלת ההבהוב
  //     // if (stripCount == 0) {
  //     //   final image = await _cameraController!.takePicture();
  //     //   // Uint8List imageBytes = await File(image.path).readAsBytes();
  //     //   // Uint8List flippedImageBytes = flipImageHorizontally(imageBytes);
  //     //   setState(() async {
  //     //     _imagePath = image.path;
  //     //     // _imageDisplay1 = flippedImageBytes;
  //     //
  //     //     while (_imageDisplay1 == null && camera == "simpleMisgert"){
  //     //     }
  //     //
  //     //   });
  //     // }
  //     if (stripCount == 0) {
  //       final image = await _cameraController!.takePicture();
  //       Uint8List imageBytes = await File(image.path).readAsBytes();
  //       flipImageHorizontally1(imageBytes).then((flippedImageBytes) {
  //         setState(() {
  //           _imagePath = image.path;
  //           _imageDisplay1 = flippedImageBytes;
  //         });
  //       });
  //     }
  //     if (camera == "simpleMisgert") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => Gloya(camera: camera,
  //             imagePath: _imagePath,
  //             firstName: firstName,
  //             seconedName: seconedName,
  //             date: date,
  //             imageDisplay: _imageDisplay1,
  //           ),
  //         ),
  //       );
  //     } else if (camera == "azMisgert") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MisgertAz(camera: camera, imagePath: _imagePath, firstName: firstName, seconedName: seconedName, date: date),
  //         ),
  //       );
  //     } else if (camera == "stripMisgert") {
  //       // final image2 = await _cameraController!.takePicture();
  //       // Uint8List imageBytes = await File(image2.path).readAsBytes();
  //       // Uint8List flippedImageBytes = flipImageHorizontally(imageBytes);
  //       final image2 = await _cameraController!.takePicture();
  //       Uint8List imageBytes = await File(image2.path).readAsBytes();
  //       flipImageHorizontally1(imageBytes).then((flippedImageBytes) {
  //         setState(() {
  //           _imagePath2 = image2.path;
  //           _imageDisplay2 = flippedImageBytes;
  //         });
  //       });
  //       // if (stripCount == 1) {
  //       //   setState(() async {
  //       //     _imagePath2 = image2.path;
  //       //     // _imageDisplay2 = flippedImageBytes;
  //       //   });
  //       // }
  //       final image3 = await _cameraController!.takePicture();
  //       Uint8List imageBytes3 = await File(image3.path).readAsBytes();
  //       flipImageHorizontally1(imageBytes3).then((flippedImageBytes) {
  //         setState(() {
  //           _imagePath3 = image3.path;
  //           _imageDisplay3 = flippedImageBytes;
  //           while (_imageDisplay3 == null){
  //                   // print(_imageDisplay3);
  //                 }
  //         });
  //       });
  //       // if (stripCount == 2) {
  //       //   final image3 = await _cameraController!.takePicture();
  //       //   setState(() async {
  //       //     _imagePath3 = image3.path;
  //       //     // final file = File(_imagePath3);
  //       //     // Uint8List imageBytes = await file.readAsBytes();
  //       //     // Uint8List flippedImageBytes = flipImageHorizontally(imageBytes);
  //       //     // _imageDisplay3 = flippedImageBytes;
  //       //     // while (_imageDisplay3 == null){
  //       //     //   print(_imageDisplay3);
  //       //     // }
  //       //   });
  //       // }
  //       if (stripCount < 3) {
  //         stripCount ++;
  //         countdown = 4980;
  //       }
  //       if (stripCount == 3) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) =>
  //                 Strip(camera: camera,
  //                   imagePath2: _imagePath2,
  //                   imagePath3: _imagePath3,
  //                   imagePath: _imagePath,
  //                   firstName: firstName,
  //                   seconedName: seconedName,
  //                   date: date,
  //                   imageDisplay1: _imageDisplay1,
  //                   imageDisplay2: _imageDisplay2,
  //                   imageDisplay3: _imageDisplay3,
  //                 ),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) {
      return;
    }
    if (_cameraController!.value.isTakingPicture) {
      return;
    }
    try {
      _flashScreen(); // הפעלת ההבהוב

      if (stripCount == 0) {
        final image;
        if (_cameraController != null && _cameraController!.value.isInitialized) {
          image = await _cameraController!.takePicture();
        } else {
          await Future.delayed(Duration(milliseconds: 3000));
          image = await _cameraController!.takePicture();
          print("Camera is not ready");
        }
        Uint8List imageBytes = await File(image.path).readAsBytes();
        flipImageHorizontally1(imageBytes).then((flippedImageBytes) {
          setState(() {
            _imagePath = image.path;
            _imageDisplay1 = flippedImageBytes;
          });
          while (_imageDisplay1 == null && camera == "simpleMisgert"){}
              if (camera == "simpleMisgert") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Gloya(camera: camera,
                      imagePath: _imagePath,
                      firstName: firstName,
                      seconedName: seconedName,
                      date: date,
                      imageDisplay: _imageDisplay1,
                    ),
                  ),
                );}
        });
      }

      if (camera == "stripMisgert" && stripCount > 0) {

        if (stripCount == 1) {
          final image2;

          if (_cameraController != null && _cameraController!.value.isInitialized) {
            image2 = await _cameraController!.takePicture();
          } else {
            await Future.delayed(Duration(milliseconds: 3000));
            image2 = await _cameraController!.takePicture();
            print("Camera is not ready");
          }
          Uint8List imageBytes2 = await File(image2.path).readAsBytes();
          flipImageHorizontally1(imageBytes2).then((flippedImageBytes2) {
            setState(() {
              _imagePath2 = image2.path;
              _imageDisplay2 = flippedImageBytes2;
            });
          });
        }

        if (stripCount == 2) {
          final image3;
          if (_cameraController != null && _cameraController!.value.isInitialized) {
            image3 = await _cameraController!.takePicture();
          } else {
            await Future.delayed(Duration(milliseconds: 3000));
            image3 = await _cameraController!.takePicture();
            print("Camera is not ready");
          }
          Uint8List imageBytes3 = await File(image3.path).readAsBytes();
          flipImageHorizontally1(imageBytes3).then((flippedImageBytes3) {
            setState(() {
              _imagePath3 = image3.path;
              _imageDisplay3 = flippedImageBytes3;
              while (_imageDisplay3 == null){
                      // print(_imageDisplay3);
                    }

            });
          });
        }
      }

      stripCount++;
      countdown = 4980;
      if (stripCount == 3){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Strip(camera: camera,
                          imagePath2: _imagePath2,
                          imagePath3: _imagePath3,
                          imagePath: _imagePath,
                          firstName: firstName,
                          seconedName: seconedName,
                          date: date,
                          imageDisplay1: _imageDisplay1,
                          imageDisplay2: _imageDisplay2,
                          imageDisplay3: _imageDisplay3,
                        ),
                  ),
                );

      }

    } catch (e) {
      print(e);
    }
  }

  void _flashScreen() {
    setState(() {
      _isFlashing = true;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isFlashing = false;
      });
    });
  }

  // @override
  // void dispose() {
  //   _cameraController?.dispose();
  //   super.dispose();
  // }
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(width: screenSize.width,height: screenSize.height, child: _buildCameraPreview(),),
          Center(
            child: countdown > 100
                ? Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
              child:
              Center(
                child: Text(
                  (displayTime + 1).toString(),
                  style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
              ),)
                : Container(),

          ), // TIME
          if (_isFlashing) // FLESH
            Container(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
            ),


          Positioned.fill(
            child:
            camera == "stripMisgert" ?
            Image.asset(
              'assets/coverCamera.png', // שינוי התמונה לתמונה שלך
              fit: BoxFit.cover,
            )
                :
            Image.asset(
              'assets/coverCamera.png', // שינוי התמונה לתמונה שלך
              fit: BoxFit.cover,
            )
            ,
          ),
          // הוספת תמונת רקע כפי שתימצא בשילוב עם פונקציה קיימת

          // Positioned(
          //       top: screenSize.height * 0.785,
          //       right: screenSize.width * 0.05,
          //       child:
          //       _imageDisplay1 != null ?
          //       Container(
          //         width: screenSize.width * 0.05,
          //         height: screenSize.height * 0.05,
          //         child: Image.memory(
          //           _imageDisplay1!,
          //           fit: BoxFit.cover,
          //         ),
          //       )
          //           :
          //       Container()
          //   ),
          // Positioned(
          //   top: screenSize.height * 0.835,
          //   right: screenSize.width * 0.05,
          //   child:
          //     _imageDisplay2 != null ?
          //     Container(
          //         width: screenSize.width * 0.05,
          //         height: screenSize.height * 0.05,
          //         child: Image.memory(
          //           _imageDisplay2!,
          //           fit: BoxFit.cover,
          //           ),
          //         )
          //       :
          //           Container()
          // ),


        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      width: screenSize.width,
      child: CameraPreview(_cameraController!),
    );
  }


}