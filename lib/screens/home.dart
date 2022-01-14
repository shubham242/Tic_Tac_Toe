import 'package:animated_button/animated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/screens/playboard.dart';
import 'package:tic_tac_toe/utilities/custom_colors.dart';
import 'package:tic_tac_toe/widgets/text.dart';
import 'package:tic_tac_toe/widgets/google_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GameController _controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BODY_COLOR,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/Images/tictactoe.png'),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser == null
                      ? 'https://raw.githubusercontent.com/shubham242/Tic_Tac_Toe/main/assets/Images/bot.png?token=GHSAT0AAAAAABQOD7OLTLZDPGI7UVXS2ZT4YPKWBIA'
                      : FirebaseAuth.instance.currentUser!.photoURL!,
                ),
              ),
              SizedBox(height: 10),
              Txt(
                FirebaseAuth.instance.currentUser == null
                    ? 'NOT LOGGED IN'
                    : FirebaseAuth.instance.currentUser!.displayName!
                        .toUpperCase(),
                size: 20,
              ),
              SizedBox(height: 50),
              AnimatedButton(
                color: PLAY_COLOR,
                width: 220,
                shape: BoxShape.rectangle,
                shadowDegree: ShadowDegree.dark,
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser == null)
                    await _controller.signInWithGoogle(context);
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => PlayBoard(),
                      ),
                    );
                    _controller.tossPopUp(context);
                  }
                },
                child: Txt(
                  'Play Game',
                  size: 20,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Txt('Level:', size: 20),
                  Obx(
                    () => AnimatedButton(
                      color: _controller.mode.value
                          ? LEVELON_COLOR
                          : LEVELOFF_COLOR,
                      height: 50,
                      width: 80,
                      onPressed: () => _controller.mode.value = true,
                      child: Container(
                        child: Center(child: Txt('Easy', size: 14)),
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedButton(
                      color: !_controller.mode.value
                          ? LEVELON_COLOR
                          : LEVELOFF_COLOR,
                      height: 50,
                      width: 80,
                      onPressed: () => _controller.mode.value = false,
                      child: Container(
                        child: Center(child: Txt('Hard', size: 14)),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              FirebaseAuth.instance.currentUser == null
                  ? GoogleButton()
                  : AnimatedButton(
                      color: LOGOUT_COLOR,
                      height: 50,
                      width: 150,
                      onPressed: () async {
                        await GoogleSignIn().signOut();
                        await FirebaseAuth.instance.signOut();
                        setState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Txt(
                            'Logout  ',
                            size: 12,
                          ),
                          Icon(Icons.exit_to_app),
                        ],
                      ),
                    ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
