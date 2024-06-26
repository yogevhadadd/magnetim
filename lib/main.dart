import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test2/v2/property_customer/property_customer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCCqiURm_L8sG1djmtXdzylPa-wQf9KqBI',
      appId: '1:580646667465:ios:df2aa35ba72e744c6df918',
      messagingSenderId: '580646667465',
      projectId: 'insta-moment',
      storageBucket: 'insta-moment.appspot.com',
    ),
  );
  //   File imageFile = File('/Users/djzarka/AndroidStudioProjects/test2/assets/cover.jpeg');
  //   final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
  //   final ref = FirebaseStorage.instance.ref().child(fileName);
  //   await ref.putFile(imageFile!);
  //   final url = await ref.getDownloadURL();
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
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 248, 232),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("he", "IR"), // Hebrew
      ],
      // home: UploadImageScreen(),
      home: const PropertyCustomerV2(),
    );
  }
}












// //
// //
// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:test2/PropertyCustomer.dart';
// import 'package:test2/v2/property_customer/property_customer.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//     apiKey: 'key',
//     appId: 'id',
//     messagingSenderId: 'sendid',
//     projectId: 'myapp',
//     storageBucket: 'myapp-b9yt18.appspot.com',
//   ));
//
//   // File imageFile = File('/Users/djzarka/AndroidStudioProjects/test2/assets/cover.jpeg');
//   // final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
//   // final ref = FirebaseStorage.instance.ref().child(fileName);
//   // await ref.putFile(imageFile!);
//   // final url = await ref.getDownloadURL();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Firebase Camera App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: const Color.fromARGB(255, 255, 248, 232),
//       ),
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: const [
//         GlobalCupertinoLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: const [
//         Locale("he", "IR"), // Hebrew
//       ],
//       // home: UploadImageScreen(),
//       home: const PropertyCustomerV2(),
//     );
//   }
// }
// //