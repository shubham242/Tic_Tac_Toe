import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/utilities/text.dart';

class CustomAlert extends StatelessWidget {
  final int result;
  CustomAlert(this.result);

  final _contoller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              result == 1
                  ? 'YOU WON 😁'
                  : result == 2
                      ? 'YOU LOST 😔'
                      : 'DRAW 👍',
              size: 30,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedButton(
                  width: 100,
                  onPressed: () {
                    _contoller.exit = false;
                    Navigator.of(context).pop();
                  },
                  child: Txt('Play Again'),
                ),
                SizedBox(width: 20),
                AnimatedButton(
                  width: 100,
                  onPressed: () {
                    _contoller.exit = true;
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Txt('Exit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
