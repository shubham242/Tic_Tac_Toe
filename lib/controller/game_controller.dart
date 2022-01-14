import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tic_tac_toe/screens/home.dart';
import 'package:tic_tac_toe/utilities/custom_colors.dart';
import 'package:tic_tac_toe/widgets/text.dart';
import 'package:tic_tac_toe/widgets/alert_sheet.dart';

class GameController extends GetxController {
  var exit = false;
  var result = 0.obs;
  var mode = true.obs; //1=easy 2=hard
  var cpuPlaying = false.obs;
  List<List> board = [
    ['_', '_', '_'].obs,
    ['_', '_', '_'].obs,
    ['_', '_', '_'].obs,
  ].obs;

  playgame(int i, BuildContext context) async {
    var res = await play(i);
    if (res != 0) {
      checkLine();
      await Get.dialog(CustomAlert(res));
      // await Get.bottomSheet(CustomBottomSheet(res));
      if (!exit) tossPopUp(context);
    }
  }

  init(int rand) async {
    cpuPlaying.value = false;
    result.value = 0;
    for (int i = 0; i < 3; i++) for (int j = 0; j < 3; j++) board[i][j] = '_';
    if (rand == 1) {
      var move = await findBestMove();
      board[move[0]][move[1]] = 'x';
    }
  }

  Future<int> play(int i) async {
    int x = (i / 3).floor();
    int y = i % 3;
    if (board[x][y] == '_') {
      board[x][y] = 'o';
      cpuPlaying.value = true;
      await Future.delayed(Duration(milliseconds: 300));
      if (isMovesLeft() && evaluate() == 0) {
        var move = await findBestMove();
        board[move[0]][move[1]] = 'x';
        if (evaluate() == 10) return 2;
        if (!isMovesLeft()) return 3;
      } else if (evaluate() == -10)
        return 1;
      else if (!isMovesLeft())
        return 3;
      else
        return 0;
    }
    return 0;
  }

  bool isMovesLeft() {
    for (var i = 0; i < 3; i++)
      for (var j = 0; j < 3; j++) if (board[i][j] == '_') return true;
    return false;
  }

  evaluate() {
    for (var row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
        if (board[row][0] == 'x')
          return 10;
        else if (board[row][0] == 'o') return -10;
      }
    }

    for (var col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] && board[1][col] == board[2][col]) {
        if (board[0][col] == 'x')
          return 10;
        else if (board[0][col] == 'o') return -10;
      }
    }

    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      if (board[0][0] == 'x')
        return 10;
      else if (board[0][0] == 'o') return -10;
    }

    if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
      if (board[0][2] == 'x')
        return 10;
      else if (board[0][2] == 'o') return -10;
    }

    return 0;
  }

  minimax(var depth, bool isMax) {
    var score = evaluate();

    if (score == 10) return score;

    if (score == -10) return score;

    if (isMovesLeft() == false) return 0;

    if (isMax) {
      var best = -1000;

      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (board[i][j] == '_') {
            board[i][j] = 'x';

            best = max(best, minimax(depth + 1, !isMax));

            board[i][j] = '_';
          }
        }
      }
      return best;
    } else {
      var best = 1000;

      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (board[i][j] == '_') {
            board[i][j] = 'o';

            best = min(best, minimax(depth + 1, !isMax));

            board[i][j] = '_';
          }
        }
      }
      return best;
    }
  }

  findBestMove() async {
    cpuPlaying.value = true;
    var bestVal = -1000;
    List bestMove = [-1, -1];

    if (mode.value) {
      int x = Random().nextInt(3);
      int y = Random().nextInt(3);
      while (board[x][y] != '_') {
        x = Random().nextInt(3);
        y = Random().nextInt(3);
      }
      bestMove[0] = x;
      bestMove[1] = y;
    } else {
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (board[i][j] == '_') {
            board[i][j] = 'x';

            var moveVal = minimax(0, false);
            board[i][j] = '_';
            if (moveVal > bestVal) {
              bestMove[0] = i;
              bestMove[1] = j;
              bestVal = moveVal;
            }
          }
        }
      }
    }
    Future.delayed(
      Duration(milliseconds: 300),
    ).then((value) => cpuPlaying.value = false);
    return bestMove;
  }

  tossPopUp(BuildContext context) async {
    int rand = Random().nextInt(2);

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: ALERT_COLOR,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                rand == 0
                    ? 'assets/Images/toss.png'
                    : 'assets/Images/tossloss.png',
                height: 80,
              ),
              SizedBox(height: 20),
              Txt(
                rand == 0 ? 'Toss Won' : 'Toss Lost',
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
    await Future.delayed(Duration(milliseconds: 600));
    Navigator.pop(context);
    init(rand);
  }

  checkLine() {
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[2][2] != '_') result.value = 1;
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[1][1] != '_') result.value = 2;
    if (board[0][0] == board[0][1] &&
        board[0][1] == board[0][2] &&
        board[0][1] != '_') result.value = 3;
    if (board[1][0] == board[1][1] &&
        board[1][1] == board[1][2] &&
        board[1][1] != '_') result.value = 4;
    if (board[2][0] == board[2][1] &&
        board[2][1] == board[2][2] &&
        board[2][1] != '_') result.value = 5;
    if (board[0][0] == board[1][0] &&
        board[1][0] == board[2][0] &&
        board[1][0] != '_') result.value = 6;
    if (board[0][1] == board[1][1] &&
        board[1][1] == board[2][1] &&
        board[1][1] != '_') result.value = 7;
    if (board[0][2] == board[1][2] &&
        board[1][2] == board[2][2] &&
        board[1][2] != '_') result.value = 8;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Home(),
        ),
      );
    }
  }
}
