import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class GoogleButton extends StatelessWidget {
  final _controller = Get.put(GameController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      child: RaisedButton(
        padding: EdgeInsets.all(1.0),
        color: const Color(0xff4285F4),
        onPressed: () async {
          await _controller.signInWithGoogle(context);
        },
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/Images/google.png',
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: new Text(
                "Sign in with Google",
                style: TextStyle(
                  fontFamily: 'Sans',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
