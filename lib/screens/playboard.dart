import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_intelligence.dart';

class PlayBoard extends StatefulWidget {
  @override
  _PlayBoardState createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
  List<List> board = [
    ['_', '_', '_'],
    ['_', '_', '_'],
    ['_', '_', '_']
  ];
  @override
  void initState() {
    super.initState();
  }

  List states = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: GridView.builder(
              padding: EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (ctx, i) => InkWell(
                onTap: () {
                  setState(() {
                    if (states[i] == 0) {
                      states[i] = 1;
                      if (i < 3) {
                        board[0][i % 3] = 'o';
                      } else if (i < 6) {
                        board[1][i % 3] = 'o';
                      } else {
                        board[2][i % 3] = 'o';
                      }
                    }
                    var x = GameIntelligence.findBestMove(board);
                    states[x[0] * 3 + x[1]] = 2;
                    board[x[0]][x[1]] = 'x';
                    print(board);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.7, color: Colors.black),
                  ),
                  child: states[i] == 1
                      ? Icon(Icons.circle_outlined)
                      : states[i] == 2
                          ? Icon(Icons.close)
                          : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
