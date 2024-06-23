import 'package:flutter/material.dart';
import 'dart:io';

import 'package:test2/CameraPage.dart';

class MisgertAz extends StatelessWidget {
  final String imagePath;

  const MisgertAz({Key? key, required this.imagePath, required this.firstName, required this.seconedName, required this.date, required this.camera}) : super(key: key);
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
                image: AssetImage('assets/azMisgert.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.253),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.338,),
                    Center(
                      child: Image.file(
                        File(imagePath),
                        height: screenSize.height * 0.32,
                        width: screenSize.width * 0.324,
                        fit: BoxFit.cover, // Ensuring the image fits the given dimensions
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.338,),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.38),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.03,),
                    Text(
                      firstName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',

                        fontSize: screenSize.width * 0.05, // Change this value to your desired text size
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05,),
                    Text(
                      seconedName,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',

                        fontSize: screenSize.width * 0.05, // Change this value to your desired text size
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.38,),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: 'DancingScript-VariableFont_wght',

                        fontSize: screenSize.width * 0.05, // Change this value to your desired text size
                      ),
                    ),
                  ],
                ),
               // SizedBox(height: screenSize.height * 0.02),
              ],
            ),
          ),
          Positioned(
            top: screenSize.height * 0.135, // Adjust this value to your needs
            right: screenSize.width * 0.385, // Adjust this value to your needs
            child: Image.asset(
              'assets/papiyon.jpeg', // Replace with your overlay image path
              width: screenSize.width * 0.225, // Adjust the size as needed
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
