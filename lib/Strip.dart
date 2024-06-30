import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'CameraPage.dart';


class Strip extends StatefulWidget {
  final String imagePath;
  final String imagePath2;
  final String imagePath3;
  final String firstName;
  final String seconedName;
  final String date;
  final String camera;
  final number = 1;

  const Strip({
    Key? key,
    required this.imagePath,
    required this.imagePath2,
    required this.imagePath3,
    required this.firstName,
    required this.seconedName,
    required this.date,
    required this.camera,
  }) : super(key: key);

  @override
  _Page8State createState() => _Page8State();
}

class _Page8State extends State<Strip> {
  File? _image;
  File? _image2;
  File? _image3;
  int? selectedNumber;

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
    try {
      final file = File(widget.imagePath2);
      if (await file.exists()) {
        setState(() {
          _image2 = file;
        });
      } else {
        print('File does not exist: ${widget.imagePath2}');
      }
    } catch (e) {
      print('Error loading image: $e');
    }
    try {
      final file = File(widget.imagePath3);
      if (await file.exists()) {
        setState(() {
          _image3 = file;
        });
      } else {
        print('File does not exist: ${widget.imagePath3}');
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
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: screenSize.height * 0.5,
            width: screenSize.width * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/amount.png'), // Path to the background image
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                              style: TextStyle(fontSize: 50, color: Colors.black),
                            ),
                          );
                        },
                        childCount: 1000, // Arbitrarily large number to simulate infinite scrolling
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.11),
                Opacity(
                  opacity: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      _uploadImages(selectedNumber);
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

  Future<void> _uploadImages(int? selectedNumber) async {
    if (_image == null || _image2 == null || _image3 == null) return;
    try {
      final fileName1 = '${DateTime.now().millisecondsSinceEpoch}-$selectedNumber-31.png';
      final fileName2 = '${DateTime.now().millisecondsSinceEpoch}-$selectedNumber-32.png';
      final fileName3 = '${DateTime.now().millisecondsSinceEpoch}-$selectedNumber-33.png';
      await _uploadImage(fileName1, _image!);
      await _uploadImage(fileName2, _image2!);
      await _uploadImage(fileName3, _image3!);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _uploadImage(String fileName, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(file);
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
                image: AssetImage('assets/stripMisgert.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.1895),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.4053),
                    Center(
                      child: Image.file(
                        File(widget.imagePath),
                        height: screenSize.height * 0.1435,
                        width: screenSize.width * 0.193,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.404),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.019),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.4053),
                    Center(
                      child: Image.file(
                        File(widget.imagePath2),
                        height: screenSize.height * 0.143,
                        width: screenSize.width * 0.193,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.404),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.0195),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.4053),
                    Center(
                      child: Image.file(
                        File(widget.imagePath3),
                        height: screenSize.height * 0.143,
                        width: screenSize.width * 0.193,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.404),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.11),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.03),
                    Text(
                      widget.firstName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.1,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05),
                    Text(
                      widget.seconedName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.15,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.38),
                    Text(
                      widget.date,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: screenSize.height * 0.044,
            right: screenSize.width * 0.2, //
            child: Image.asset(
              'assets/papiyon.jpeg',
              width: screenSize.width * 0.6,
              height: screenSize.height * 0.24,
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
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.13,
                child: ElevatedButton(
                  onPressed: showNumberPickerDialog,
                  child: Text('Upload'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
