// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tic_tac_toe/screens/home.dart';
// import 'package:tic_tac_toe/widgets/google_button.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(30),
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width - 100,
//               child: Image.asset(
//                 'assets/Images/tictactoe.png',
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: GoogleButton(_signInWithGoogle),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
