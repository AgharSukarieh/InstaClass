// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syriaapp/view_models/auth_viewmodel.dart';

// class testnum extends StatefulWidget {
//   const testnum({super.key});
//   @override
//   State<testnum> createState() => _testnumState();
// }

// class _testnumState extends State<testnum> {
//   TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewmodel>(context);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Hello World')),
//         body: Column(
//           children: [
//             Center(
//               child: TextField(
//                 controller: _textEditingController,
//                 decoration: InputDecoration(labelText: "Enter you num"),
//               ),
//             ),
//             MaterialButton(
//               onPressed: () async {
//                 final errornum = await authViewModel.verificationNum(
//                   _textEditingController.text,
//                 );
//                 if (errornum != null) {
//                   AwesomeDialog(
//                     context: context,
//                     dialogType: DialogType.warning,
//                     borderSide: const BorderSide(color: Colors.green, width: 2),
//                     buttonsBorderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                     dismissOnTouchOutside: true,
//                     dismissOnBackKeyPress: false,
//                     headerAnimationLoop: false,
//                     animType: AnimType.bottomSlide,
//                     title: 'Warning',
//                     desc: 'cant vervication youe email',
//                     showCloseIcon: true,
//                     btnCancelOnPress: () {},
//                     btnOkOnPress: () {},
//                   ).show();
//                 }
//               },
//               child: Text("sent"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
