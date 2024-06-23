import 'package:flutter/material.dart';
import 'dart:io';

import 'package:test2/CameraPage.dart';

class Strip extends StatelessWidget {
  final String imagePath;
  final String imagePath2;
  final String imagePath3;
  final String imagePath4 = 'assets/papiyon.jpeg';

  const Strip({Key? key, required this.imagePath3, required this.imagePath2, required this.imagePath, required this.firstName, required this.seconedName, required this.date, required this.camera}) : super(key: key);
  final String firstName;
  final String seconedName;
  final String date;
  final String camera; // 'final' instead of 'late' here, as it is set via constructor

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
                SizedBox(height: screenSize.height * 0.192),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.40,),
                    Center(
                      child: Image.file(
                        File(imagePath),
                        height: screenSize.height * 0.14,
                        width: screenSize.width * 0.19,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.41,),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.40,),
                    Center(
                      child: Image.file(
                        File(imagePath2),
                        height: screenSize.height * 0.14,
                        width: screenSize.width * 0.19,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.41,),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.024),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.40,),
                    Center(
                      child: Image.file(
                        File(imagePath3),
                        height: screenSize.height * 0.14,
                        width: screenSize.width * 0.19,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.41,),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.12),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.03,),
                    Text(
                      firstName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.1,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05,),
                    Text(
                      seconedName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',
                        fontSize: screenSize.width * 0.15,
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.38,),
                    Text(
                      date,
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
            top: screenSize.height * 0.045, // Adjust this value to your needs
            right: screenSize.width * 0.241, // Adjust this value to your needs
            child: Image.asset(
              'assets/papiyon.jpeg', // Replace with your overlay image path
              width: screenSize.width * 0.518, // Adjust the size as needed
              height: screenSize.height * 0.233, // Adjust the size as needed
            ),
          ),
          Positioned(
            top: screenSize.height * 0.77, // Adjust this value to your needs
            right: screenSize.width * 0.4, // Adjust this value to your needs
            child: Opacity(
              opacity: 0,
              child: SizedBox(
                width: screenSize.width * 0.2, // Adjust width as needed
                height: screenSize.height * 0.13, // Adjust height as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraPage(camera : camera,firstName: firstName ,seconedName: seconedName , date: date)),
                    );
                  },
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
