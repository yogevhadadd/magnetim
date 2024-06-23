
import 'package:flutter/material.dart';
import 'DecideOption.dart';

class PropertyCustomer extends StatelessWidget {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cover.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child:Row(children: [
          Container(width: screenSize.width * 0.66,
            height: screenSize.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.4),
                    Container(
                      width: screenSize.width * 0.58, // 80% of screen width
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          style: TextStyle(fontSize: 40), // Set font size here
                          controller: firstController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    Row(children: [
                      Container(
                        width: screenSize.width * 0.58, // 80% of screen width
                        height: screenSize.height * 0.05,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            style: const TextStyle(fontSize: 40,
                            ), // Set font size here
                            controller: secondController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],),
                    SizedBox(height: screenSize.height * 0.025),
                    Row(children: [
                      Container(
                        width: screenSize.width * 0.58, // 80% of screen width
                        height: screenSize.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            style: TextStyle(fontSize: 40), // Set font size here
                            controller: dateController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],),
                    SizedBox(height: screenSize.height * 0.303),
                    Row(children: [
                      SizedBox(width: screenSize.width * 0.34,),
                      Opacity(
                        opacity: 0,
                        child:
                        SizedBox(
                          width: screenSize.width * 0.28, // Adjust width as needed
                          height: screenSize.height * 0.07, // Adjust height as needed
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DecideOption(firstName: firstController.text,seconedName: secondController.text, date: dateController.text)),
                              );
                            },
                            child: Text('Go to Page 2'),),
                        ),

                      ),
                    ],)
                  ],
                ),
              ),
            ),

          ),
          Container(width: screenSize.width * 0.34),

        ],)

      ),
    );
  }
}




// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
//
// class UploadImageScreen extends StatefulWidget {
//   @override
//   _UploadImageScreenState createState() => _UploadImageScreenState();
// }
//
// class _UploadImageScreenState extends State<UploadImageScreen> {
//   File? _image;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImageFromAssets();
//   }
//
//   Future<void> _loadImageFromAssets() async {
//     try {
//       final byteData = await rootBundle.load('assets/papiyon.jpeg');
//       final file = File('${(await getTemporaryDirectory()).path}/papiyon.jpeg');
//       await file.writeAsBytes(byteData.buffer.asUint8List());
//       setState(() {
//         _image = file;
//       });
//     } catch (e) {
//       print('Error loading image: $e');
//     }
//   }
//
//   Future<void> _uploadImage() async {
//     if (_image == null) return;
//
//     try {
//       // Create a unique file name
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
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _image == null ? Text('No image selected.') : Image.file(_image!),
//           ElevatedButton(
//             onPressed: _uploadImage,
//             child: Text('Upload Image'),
//           ),
//         ],
//       ),
//     );
//   }
// }
