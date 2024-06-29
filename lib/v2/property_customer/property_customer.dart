// import 'package:flutter/material.dart'; מהwindows
//
// import '../../CameraPage.dart';
//
// class PropertyCustomer extends StatelessWidget {
//   final String camra = "";
//   final String firstName;
//   final String seconedName;
//   final String date;
//   const PropertyCustomer({Key? key, required this.firstName, required this.seconedName, required this.date}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//
//     return Scaffold(
//
//       body:
//         Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//         image: DecorationImage(
//         image: AssetImage('assets/mainPage.jpeg'),
//     fit: BoxFit.cover,
//     ),
//     ),
//     child:Column(children: [
//
//       SizedBox(height: screenSize.height * 0.35,),
//       Container(height: screenSize.height * 0.3,child: Column(children: [
//         Container(width: screenSize.width, child: Row(children: [
//           SizedBox(width: screenSize.width * 0.18,),
//           Container(child: Text(firstName,
//             style: TextStyle(
//               fontFamily: 'DancingScript-VariableFont_wght',
//               fontSize: screenSize.width * 0.1, // Change this value to your desired text size
//             ),),),
//           SizedBox(width: screenSize.width * 0.2,),
//           Container(child: Text(seconedName,
//             style: TextStyle(
//               fontFamily: 'DancingScript-VariableFont_wght',
//               fontSize: screenSize.width * 0.1, // Change this value to your desired text size
//             ),),),
//           SizedBox(width: screenSize.width * 0.1,),
//         ]),),
//         Container(width: screenSize.width, child: Row(children: [
//           SizedBox(width: screenSize.width * 0.25,),
//           Container(child: Text(date,
//             style: TextStyle(
//               fontFamily: 'DancingScript-VariableFont_wght',
//               fontSize: screenSize.width * 0.1, // Change this value to your desired text size
//             ),),),
//           SizedBox(width: screenSize.width * 0.1,),
//         ]),),
//       ],)),
//       SizedBox(height: screenSize.height * 0.2,),
//       Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(width: screenSize.width * 0.05,),
//             Opacity(
//               opacity: 0,
//               child:
//               SizedBox(
//                 width: screenSize.width * 0.2, // 80% of screen width
//                 height: screenSize.height * 0.15,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CameraPage(camera: "simpleMisgert",firstName: firstName,seconedName :seconedName ,date:date),)
//                       //MaterialPageRoute(builder: (context) => Page4()),
//                     );
//                   },
//                   child: Text('Go to Page 2'),                        ),
//               ),
//             ),
//             SizedBox(width: screenSize.width * 0.1,),
//             Opacity(
//               opacity: 0,
//               child:
//               SizedBox(
//                 width: screenSize.width * 0.2, // 80% of screen width
//                 height: screenSize.height * 0.15,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                         MaterialPageRoute(builder: (context) => CameraPage(camera: "azMisgert",firstName: firstName,seconedName :seconedName ,date:date),)
//                     );
//                   },
//                   child: Text('Go to Page 2'),                        ),
//               ),
//             ),
//             SizedBox(width: screenSize.width * 0.1,),
//             Opacity(
//               opacity: 0,
//               child:
//               SizedBox(
//                 width: screenSize.width * 0.2, // 80% of screen width
//                 height: screenSize.height * 0.15,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                         MaterialPageRoute(builder: (context) => CameraPage(camera: "stripMisgert",firstName: firstName,seconedName :seconedName ,date:date),)
//                     );
//                   },
//                   child: Text('Go to Page 2'),                        ),
//               ),
//             ),
//             SizedBox(width: screenSize.width * 0.1,),
//           ],
//         ),
//       ),
//     ],)
//         ),
//     );
//   }
// }
//
//


// import 'package:flutter/material.dart';
// import 'package:test2/DecideOption.dart';
// import 'package:test2/v2/property_customer/bloc/property_customer_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class PropertyCustomerV2 extends StatefulWidget {
//   const PropertyCustomerV2({super.key});
//
//   @override
//   State<PropertyCustomerV2> createState() => _PropertyCustomerV2State();
// }
//
// class _PropertyCustomerV2State extends State<PropertyCustomerV2> {
//   late TextEditingController groomController;
//   late TextEditingController brideController;
//   late TextEditingController dateController;
//
//   @override
//   void initState() {
//     super.initState();
//     groomController = TextEditingController();
//     brideController = TextEditingController();
//     dateController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     groomController.dispose();
//     brideController.dispose();
//     dateController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return BlocProvider(
//       create: (context) => PropertyCustomerBloc(),
//       child: BlocConsumer<PropertyCustomerBloc, PropertyCustomerState>(
//         listenWhen: (previous, current) =>
//             current is PropertyCustomerNavigationState,
//         buildWhen: (previous, current) =>
//             current is! PropertyCustomerNavigationState,
//         listener: (context, state) {
//           if (state is PropertyCustomerNavToNextPage) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => DecideOption(
//                         firstName: groomController.text,
//                         seconedName: brideController.text,
//                         date: dateController.text)));
//           }
//         },
//         builder: (context, state) {
//           final bloc = context.read<PropertyCustomerBloc>();
//           return Scaffold(
//             body: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       imageDisplay(screenWidth),
//                       allTextFields(),
//                       loginButton(bloc, screenWidth)
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   SizedBox imageDisplay(double screenWidth) {
//     return SizedBox(
//       width: screenWidth * 0.8,
//       child: Image.asset('assets/logo.png', fit: BoxFit.cover),
//     );
//   }
//
//   SizedBox loginButton(PropertyCustomerBloc bloc, double screenWidth) {
//     return SizedBox(
//       width: screenWidth * 0.3,
//       height: 60,
//       child: ElevatedButton(
//         onPressed: () => bloc.add(PropertyCustomerOnButtonClick()),
//         style: const ButtonStyle(
//             backgroundColor: WidgetStatePropertyAll(Colors.black)),
//         child: const Text(
//           "היכנס",
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//     );
//   }
//
//   Widget rowTextField(
//       {required String text, required TextEditingController controller}) {
//     return Row(
//       children: [
//         Text(text, style: const TextStyle(fontSize: 28)),
//         Expanded(
//           child: TextField(
//             decoration: const InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(width: 2.0),
//               ),
//             ),
//             style: const TextStyle(fontSize: 20),
//             controller: controller,
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget allTextFields() {
//     return Column(
//       children: [
//         rowTextField(text: "שם החתן:", controller: groomController),
//         rowTextField(text: "שם הכלה:", controller: brideController),
//         rowTextField(text: "הזן תאריך:", controller: dateController),
//       ],
//     );
//   }
// }
