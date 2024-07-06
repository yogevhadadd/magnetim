import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'BeforeCamera.dart';
import 'CameraPage.dart';
import 'DecideOption.dart';

class Gloya extends StatefulWidget {
  final String imagePath;
  final String firstName;
  final String seconedName;
  final String date;
  final String camera;
  final Uint8List? imageDisplay;


  const Gloya({
    Key? key,
    required this.imagePath,
    required this.firstName,
    required this.seconedName,
    required this.date,
    required this.camera, this.imageDisplay,
  }) : super(key: key);
  @override
  _GloyaState createState() => _GloyaState();
}

class _GloyaState extends State<Gloya> {
  File? _image;
  int? selectedNumber = 1;

  @override
  void initState() {
    super.initState();
    _loadImageFromPath();
  }

  Future<void> _loadImageFromPath() async {
    try {
      final file = File(widget.imagePath);
      if (await file.exists()) {
        setState(() {
          _image = file;
        });
      } else {
        print('File does not exist: ${widget.imagePath}');
      }
    } catch (e) {
      print('Error loading image: $e');
    }
  }

  void showNumberPickerDialog() {
    final screenSize = MediaQuery.of(context).size;
    final FixedExtentScrollController _controller = FixedExtentScrollController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0), // Adjust the radius as needed
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: screenSize.height * 0.5,
            width: screenSize.width * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/amount.png'), // Path to the background image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0), // Same radius as in AlertDialog
            ),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.06),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      _controller.jumpTo(_controller.offset - details.delta.dy);
                    });
                  },
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: screenSize.height * 0.3,
                    color: Colors.transparent,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 100,
                      perspective: 0.005,
                      physics: FixedExtentScrollPhysics(),
                      controller: _controller,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedNumber = (index % 4) + 1;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          var number = (index % 4) + 1;
                          return Center(
                            child: Text(
                              '$number',
                              style: TextStyle(
                                fontFamily: 'DancingScript-VariableFont_wght',
                                fontSize: 100,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                        childCount: 1000, // Arbitrarily large number to simulate infinite scrolling
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.08),
                Opacity(
                  opacity: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      _uploadImage();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: screenSize.width * 0.2,
                      height: screenSize.height * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}a${selectedNumber}a21.png';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putData(widget.imageDisplay!);
      final url = await ref.getDownloadURL();
      print('Uploaded image URL: $url');
    } catch (e) {
      print('Error uploading image: $e');
    }
    selectedNumber = 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/simpleMisgert.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.303),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.35),
                    Center(
                         child:  Container(
                          width: screenSize.width * 0.3,
                          height: screenSize.height * 0.226,
                          child: widget.imageDisplay != null
                              ? Image.memory(
                            widget.imageDisplay!,
                            fit: BoxFit.cover,
                          )
                              : Image.file(
                            File(widget.imagePath),
                            fit: BoxFit.cover,
                          ),
                        )
                      // child: _image != null
                      //     ? Image.file(
                      //   _image!,
                      //   height: screenSize.height * 0.226,
                      //   width: screenSize.width * 0.3,
                      //   fit: BoxFit.cover,
                      // )
                      //     : CircularProgressIndicator(),
                    ),
                    SizedBox(width: screenSize.width * 0.338),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.1),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.03),
                    Text(
                      widget.firstName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.05,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05),
                    Text(
                      widget.seconedName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.05,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.38),
                    Text(
                      widget.date,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.05,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02),
              ],
            ),
          ),
          Positioned(
            top: screenSize.height * 0.161,
            right: screenSize.width * 0.385,
            child: Image.asset(
              'assets/papiyon.jpeg',
              width: screenSize.width * 0.225,
              height: screenSize.height * 0.233,
            ),
          ),
          Positioned(
            top: screenSize.height * 0.77,
            right: screenSize.width * 0.4,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(
                          camera: widget.camera,
                          firstName: widget.firstName,
                          seconedName: widget.seconedName,
                          date: widget.date,
                        ),
                      ),
                    );
                  },
                  child: Text('Back'),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.77,
            right: screenSize.width * 0.1,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed:  showNumberPickerDialog,
                  child: Text('Back'),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.77,
            right: screenSize.width * 0.7,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed:  ()  {},
                  child: Text('Back'),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0,
            right: screenSize.width * 0.4,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            BeforeCamera(camera: "simpleMisgert",firstName: widget.firstName,
                                seconedName : widget.seconedName ,date:widget.date),)
                    );
                  },
                  child: Text('Back'),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0,
            right: screenSize.width * 0.1,
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DecideOption(
                          firstName: widget.firstName,
                          seconedName : widget.seconedName ,date:widget.date,
                        ),
                      ),
                    );
                  }, child: Text('Back'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}




// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// // import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:test2/CameraPage.dart';
//
// class Gloya extends StatefulWidget {
//   final String imagePath;
//   final String firstName;
//   final String seconedName;
//   final String date;
//   final String camera;
//
//   const Gloya({
//     Key? key,
//     required this.imagePath,
//     required this.firstName,
//     required this.seconedName,
//     required this.date,
//     required this.camera,
//   }) : super(key: key);
//
//   @override
//   _Page6State createState() => _Page6State();
// }
//
// class _Page6State extends State<Gloya> {
//   File? _image;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImageFromPath();
//   }
//
//   Future<void> _loadImageFromPath() async {
//     try {
//       final file = File(widget.imagePath);
//       if (await file.exists()) {
//         setState(() {
//           _image = file;
//         });
//       } else {
//         print('File does not exist: ${widget.imagePath}');
//       }
//     } catch (e) {
//       print('Error loading image: $e');
//     }
//   }
//
//   Future<void> _uploadImage() async {
//     if (_image == null) return;
//     try {
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
//       final ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(_image!);
//       final url = await ref.getDownloadURL();
//       print('Uploaded image URL: $url');
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/simpleMisgert.jpeg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: screenSize.height * 0.233),
//                 Row(
//                   children: [
//                     SizedBox(width: screenSize.width * 0.338),
//                     Center(
//                       child: _image != null
//                           ? Image.file(
//                         _image!,
//                         height: screenSize.height * 0.32,
//                         width: screenSize.width * 0.324,
//                         fit: BoxFit.cover,
//                       )
//                           : CircularProgressIndicator(),
//                     ),
//                     SizedBox(width: screenSize.width * 0.338),
//                   ],
//                 ),
//                 SizedBox(height: screenSize.height * 0.2),
//                 Row(
//                   children: [
//                     SizedBox(width: screenSize.width * 0.1),
//                     Opacity(
//                       opacity: 1,
//                       child:
//                       SizedBox(
//                         width: screenSize.width * 0.2, // 80% of screen width
//                         height: screenSize.height * 0.15,
//                         child: ElevatedButton(
//                           onPressed: () {
//
//                           },
//                           child: Text('Go to Page 2'),                        ),
//                       ),),
//                     SizedBox(width: screenSize.width * 0.11),
//                     Opacity(
//                       opacity: 0,
//                       child:
//                       SizedBox(
//                         width: screenSize.width * 0.2, // 80% of screen width
//                         height: screenSize.height * 0.15,
//                         child: ElevatedButton(
//                           onPressed: _uploadImage,
//                           child: Text('Go to Page 2'),                        ),
//                       ),),
//                     SizedBox(width: screenSize.width * 0.11),
//                     Opacity(
//                       opacity: 1,
//                       child:
//                       SizedBox(
//                         width: screenSize.width * 0.2, // 80% of screen width
//                         height: screenSize.height * 0.15,
//                         child: ElevatedButton(
//                           onPressed: () {
//
//                           },
//                           child: Text('Go to Page 2'),                        ),
//                       ),),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(width: screenSize.width * 0.03),
//                     Text(
//                       widget.firstName,
//                       style: TextStyle(
//                         fontFamily: 'DancingScript-VariableFont_wght',
//                         fontSize: screenSize.width * 0.05,
//                       ),
//                     ),
//                     SizedBox(width: screenSize.width * 0.05),
//                     Text(
//                       widget.seconedName,
//                       style: TextStyle(
//                         fontFamily: 'DancingScript-VariableFont_wght',
//                         fontSize: screenSize.width * 0.05,
//                       ),
//                     ),
//                     SizedBox(width: screenSize.width * 0.38),
//                     Text(
//                       widget.date,
//                       style: TextStyle(
//                         fontFamily: 'DancingScript-VariableFont_wght',
//                         fontSize: screenSize.width * 0.05,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 // Positioned(
//                 //   top: screenSize.height * 0.135, // Adjust this value to your needs
//                 //   right: screenSize.width * 0.385, // Adjust this value to your needs
//                 //   child: ElevatedButton(
//                 //     onPressed: _uploadImage,
//                 //     child: Text('Upload Image'),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: screenSize.height * 0.1165,
//             right: screenSize.width * 0.385,
//             child: Image.asset(
//               'assets/papiyon.jpeg',
//               width: screenSize.width * 0.225,
//               height: screenSize.height * 0.233,
//             ),
//           ),
//           Positioned(
//             top: screenSize.height * 0.77,
//             right: screenSize.width * 0.4,
//             child: Opacity(
//               opacity: 0,
//               child: SizedBox(
//                 width: screenSize.width * 0.2,
//                 height: screenSize.height * 0.13,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CameraPage(
//                           camera: widget.camera,
//                           firstName: widget.firstName,
//                           seconedName: widget.seconedName,
//                           date: widget.date,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text('Back'),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
