import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tic_tac_toe/screens/login.dart';
import 'package:tic_tac_toe/screens/playboard.dart';
import 'package:tic_tac_toe/utilities/text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              'WELCOME',
              size: 30,
            ),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser!.photoURL!,
              ),
            ),
            SizedBox(height: 10),
            Txt(
              FirebaseAuth.instance.currentUser!.displayName!,
              size: 20,
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlayBoard(),
                ),
              ),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Txt('Play Game'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
