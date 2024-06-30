import 'package:flutter/material.dart';
import 'CameraPage.dart';

class BeforeCamera extends StatelessWidget {
  final String camera;
  final String firstName;
  final String seconedName;
  final String date;
  const BeforeCamera({Key? key, required this.camera, required this.firstName, required this.seconedName, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(

      body:
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/cameraPage.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child:Column(children: [
            SizedBox(height: screenSize.height * 0.38,),
            Container(height: screenSize.height * 0.3,child: Column(children: [
              Container(width: screenSize.width, child: Row(children: [
                SizedBox(width: screenSize.width * 0.18,),
              Container(child: Text(firstName,
                        style: TextStyle(
                          fontFamily: 'DancingScript-VariableFont_wght',

                          fontSize: screenSize.width * 0.1, // Change this value to your desired text size
              ),),),
              SizedBox(width: screenSize.width * 0.2,),
              Container(child: Text(seconedName,
                       style: TextStyle(
                         fontFamily: 'DancingScript-VariableFont_wght',

                         fontSize: screenSize.width * 0.1, // Change this value to your desired text size
            ),),),
            SizedBox(width: screenSize.width * 0.1,),
            ]),),
            Container(width: screenSize.width, child: Row(children: [
            SizedBox(width: screenSize.width * 0.3,),
            // Container(child: Text("The Wedding",
            // style: TextStyle(
            //   fontFamily: 'DancingScript-VariableFont_wght',
            //
            //   fontSize: screenSize.width * 0.08, // Change this value to your desired text size
            // ),),),
            SizedBox(width: screenSize.width * 0.1,),
            ]),),
            Container(width: screenSize.width, child: Row(children: [
            SizedBox(width: screenSize.width * 0.38,),
            Container(child: Text(date,
            style: TextStyle(
              fontFamily: 'DancingScript-VariableFont_wght',

              fontSize: screenSize.width * 0.06, // Change this value to your desired text size
            ),),),
            SizedBox(width: screenSize.width * 0.1,),
            ]),),
            ],)),
            SizedBox(height: screenSize.height * 0.07,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: screenSize.width * 0.385,),
                  Opacity(
                    opacity: 0,
                    child:
                    SizedBox(
                      width: screenSize.width * 0.25, // 80% of screen width
                      height: screenSize.height * 0.18,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                              MaterialPageRoute(builder: (context) => CameraPage(camera: camera,firstName: firstName,seconedName: seconedName,date: date),)
                          );
                        },
                        child: Text('Go to Page 2'),                        ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.365,),
                ],
              ),
            ),
          ],)
      ),
    );
  }
}
