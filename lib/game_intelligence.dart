import 'dart:math';

class GameIntelligence {
  static bool isMovesLeft(var board) {
    for (var i = 0; i < 3; i++)
      for (var j = 0; j < 3; j++) if (board[i][j] == '_') return true;
    return false;
  }

  static evaluate(var b) {
    for (var row = 0; row < 3; row++) {
      if (b[row][0] == b[row][1] && b[row][1] == b[row][2]) {
        if (b[row][0] == 'x')
          return 10;
        else if (b[row][0] == 'o') return -10;
      }
    }

    for (var col = 0; col < 3; col++) {
      if (b[0][col] == b[1][col] && b[1][col] == b[2][col]) {
        if (b[0][col] == 'x')
          return 10;
        else if (b[0][col] == 'o') return -10;
      }
    }

    if (b[0][0] == b[1][1] && b[1][1] == b[2][2]) {
      if (b[0][0] == 'x')
        return 10;
      else if (b[0][0] == 'o') return -10;
    }

    if (b[0][2] == b[1][1] && b[1][1] == b[2][0]) {
      if (b[0][2] == 'x')
        return 10;
      else if (b[0][2] == 'o') return -10;
    }

    return 0;
  }

  static minimax(var board, var depth, bool isMax) {
    var score = evaluate(board);

    if (score == 10) return score;

    if (score == -10) return score;

    if (isMovesLeft(board) == false) return 0;

    if (isMax) {
      var best = -1000;

      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          if (board[i][j] == '_') {
            board[i][j] = 'x';

            best = max(best, minimax(board, depth + 1, !isMax));

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

            best = min(best, minimax(board, depth + 1, !isMax));

            board[i][j] = '_';
          }
        }
      }
      return best;
    }
  }

  static findBestMove(List<List> board) {
    var bestVal = -1000;
    List bestMove = [-1, -1];

    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (board[i][j] == '_') {
          board[i][j] = 'x';

          var moveVal = minimax(board, 0, false);
          board[i][j] = '_';
          if (moveVal > bestVal) {
            bestMove[0] = i;
            bestMove[1] = j;
            bestVal = moveVal;
          }
        }
      }
    }

    return bestMove;
  }
}
