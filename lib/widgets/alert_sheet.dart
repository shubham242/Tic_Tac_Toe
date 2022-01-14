import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/utilities/custom_colors.dart';
import 'package:tic_tac_toe/widgets/text.dart';

class CustomAlert extends StatelessWidget {
  final int result;
  CustomAlert(this.result);

  final _contoller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: ALERT_COLOR,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              result == 1
                  ? 'YOU WON\n😁'
                  : result == 2
                      ? 'YOU LOST\n😔'
                      : 'DRAW\n👍',
              size: 25,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedButton(
                  color: AGAIN_COLOR,
                  height: 50,
                  width: 100,
                  onPressed: () {
                    _contoller.exit = false;
                    Navigator.of(context).pop();
                  },
                  child: Txt('Play\nAgain'),
                ),
                SizedBox(width: 10),
                AnimatedButton(
                  color: EXIT_COLOR,
                  height: 50,
                  width: 80,
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
