import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'BeforeCamera.dart';
import 'CameraPage.dart';
import 'DecideOption.dart';
import 'package:image/image.dart' as img;

class Strip extends StatefulWidget {
  final String imagePath;
  final String imagePath2;
  final String imagePath3;
  final String firstName;
  final String seconedName;
  final String date;
  final String camera;
  final Uint8List? imageDisplay1;
  final Uint8List? imageDisplay2;
  final Uint8List? imageDisplay3;
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
    this.imageDisplay1,
    this.imageDisplay2,
    this.imageDisplay3,
  }) : super(key: key);

  @override
  _Page8State createState() => _Page8State();
}

class _Page8State extends State<Strip> {
  File? _image;
  File? _image2;
  File? _image3;
  int? selectedNumber = 1;

  @override
  void initState() {
    super.initState();
    _loadImageFromPath();
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
                      // print('object');
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
                      _uploadImages();
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

  Future<void> _uploadImages() async {
    if (_image == null || _image2 == null || _image3 == null) return;
    try {
      final fileName1 = '${DateTime.now().millisecondsSinceEpoch}a${selectedNumber}a31.png';
      final fileName2 = '${DateTime.now().millisecondsSinceEpoch}a${selectedNumber}a32.png';
      final fileName3 = '${DateTime.now().millisecondsSinceEpoch}a${selectedNumber}a33.png';
      await _uploadImage(fileName1, widget.imageDisplay1!);
      await _uploadImage(fileName2, widget.imageDisplay2!);
      await _uploadImage(fileName3, widget.imageDisplay3!);
    } catch (e) {
      print('Error uploading image: $e');
    }
    selectedNumber = 1;
  }

  Future<void> _uploadImage(String fileName, Uint8List file) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putData(file);
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
                SizedBox(height: screenSize.height * 0.181),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.403),
                    Center(
                        child: Container(
                          width: screenSize.width * 0.193,
                          height: screenSize.height * 0.145,
                          child: widget.imageDisplay1 != null
                              ? Image.memory(
                            widget.imageDisplay1!,
                            fit: BoxFit.cover,
                          )
                              : Image.file(
                            File(widget.imagePath),
                            fit: BoxFit.cover,
                          ),
                        )

                    ),
                    SizedBox(width: screenSize.width * 0.404),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.008),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.403),
                    Center(
                      child: Container(
                        width: screenSize.width * 0.193,
                        height: screenSize.height * 0.145,
                        child: widget.imageDisplay2 != null
                            ? Image.memory(
                          widget.imageDisplay2!,
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          File(widget.imagePath2),
                          fit: BoxFit.cover,
                        ),
                      ),),
                    SizedBox(width: screenSize.width * 0.404),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.01),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.403),
                    Center(
                      child: Container(
                        width: screenSize.width * 0.193,
                        height: screenSize.height * 0.145,
                        child: widget.imageDisplay3 != null
                            ? Image.memory(
                          widget.imageDisplay3!,
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          File(widget.imagePath3),
                          fit: BoxFit.cover,
                        ),
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
            top: screenSize.height * 0.025,
            right: screenSize.width * 0.38, //
            child: Image.asset(
              'assets/papiyon.jpeg',
              width: screenSize.width * 0.225,
              height: screenSize.height * 0.3,
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
                  onPressed: showNumberPickerDialog,
                  child: Text('Upload'),
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
                  onPressed: showNumberPickerDialog,
                  child: Text('Upload'),
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
                            BeforeCamera(camera: "stripMisgert",firstName: widget.firstName,
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
