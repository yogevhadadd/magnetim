import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'CameraPage.dart';

class Gloya extends StatefulWidget {
  final String imagePath;
  final String firstName;
  final String seconedName;
  final String date;
  final String camera;

  const Gloya({
    Key? key,
    required this.imagePath,
    required this.firstName,
    required this.seconedName,
    required this.date,
    required this.camera,
  }) : super(key: key);

  @override
  _GloyaState createState() => _GloyaState();
}

class _GloyaState extends State<Gloya> {
  File? _image;

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

  Future<void> _uploadImage() async {
    if (_image == null) return;
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}-21.png';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_image!);
      final url = await ref.getDownloadURL();
      print('Uploaded image URL: $url');
    } catch (e) {
      print('Error uploading image: $e');
    }
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
                      child: _image != null
                          ? Image.file(
                        _image!,
                        height: screenSize.height * 0.226,
                        width: screenSize.width * 0.3,
                        fit: BoxFit.cover,
                      )
                          : CircularProgressIndicator(),
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
                // Positioned(
                //   top: screenSize.height * 0.135, // Adjust this value to your needs
                //   right: screenSize.width * 0.385, // Adjust this value to your needs
                //   child: ElevatedButton(
                //     onPressed: _uploadImage,
                //     child: Text('Upload Image'),
                //   ),
                // ),
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
            right: screenSize.width * 0.15,
            child: Opacity(
              opacity: 1,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed:  _uploadImage,
                  child: Text('Back'),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.77,
            right: screenSize.width * 0.7,
            child: Opacity(
              opacity: 1,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed:  ()  {},
                  child: Text('Back'),
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
