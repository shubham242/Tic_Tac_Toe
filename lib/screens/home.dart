import 'package:animated_button/animated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/screens/playboard.dart';
import 'package:tic_tac_toe/utilities/text.dart';
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
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL!,
                ),
              ),
              SizedBox(height: 10),
              Txt(
                FirebaseAuth.instance.currentUser!.displayName!.toUpperCase(),
                size: 20,
              ),
              SizedBox(height: 50),
              AnimatedButton(
                shape: BoxShape.rectangle,
                shadowDegree: ShadowDegree.dark,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PlayBoard(),
                    ),
                  );
                  _controller.tossPopUp(context);
                },
                child: Txt(
                  'Play Game',
                  size: 30,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt('Mode :', size: 20),
                  SizedBox(width: 30),
                  Obx(
                    () => AnimatedButton(
                      color:
                          _controller.mode.value ? Colors.blue : Colors.white,
                      height: 50,
                      width: 80,
                      onPressed: () => _controller.mode.value = true,
                      child: Container(
                        child: Center(child: Txt('Easy', size: 20)),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Obx(
                    () => AnimatedButton(
                      color:
                          !_controller.mode.value ? Colors.blue : Colors.white,
                      height: 50,
                      width: 80,
                      onPressed: () => _controller.mode.value = false,
                      child: Container(
                        child: Center(child: Txt('Hard', size: 20)),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              GoogleButton(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
