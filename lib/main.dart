//
//
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test2/PropertyCustomer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'key',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'myapp',
    storageBucket: 'myapp-b9yt18.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: UploadImageScreen(),
      home: PropertyCustomer(),
    );
  }
}
//