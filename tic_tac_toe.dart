import 'dart:io';

List<String> board = List.filled(9, ' ');

void printBoard() {
  print('');
  print('${board[0]} | ${board[1]} | ${board[2]}');
  print('--+---+--');
  print('${board[3]} | ${board[4]} | ${board[5]}');
  print('--+---+--');
  print('${board[6]} | ${board[7]} | ${board[8]}');
  print('');
}

bool checkWinner(String player) {
  List<List<int>> winPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  for (var pos in winPositions) {
    if (board[pos[0]] == player &&
        board[pos[1]] == player &&
        board[pos[2]] == player) {
      return true;
    }
  }
  return false;
}

bool isDraw() {
  return !board.contains(' ');
}

void resetBoard() {
  board = List.filled(9, ' ');
}

void main() {
  String currentPlayer = 'X';

  while (true) {
    printBoard();
    print("Player $currentPlayer, enter a position (1-9):");
    String? input = stdin.readLineSync();

    if (input == null || int.tryParse(input) == null) {
      print("Invalid input! Please enter a number from 1 to 9.");
      continue;
    }

    int pos = int.parse(input) - 1;

    if (pos < 0 || pos >= 9 || board[pos] != ' ') {
      print("Invalid move! Position already taken or out of range.");
      continue;
    }

    board[pos] = currentPlayer;

    if (checkWinner(currentPlayer)) {
      printBoard();
      print("Player $currentPlayer wins!");
      print("Do you want to play again? (y/n)");
      String? again = stdin.readLineSync();
      if (again?.toLowerCase() != 'y') break;
      resetBoard();
      currentPlayer = 'X';
      continue;
    }

    if (isDraw()) {
      printBoard();
      print("It's a draw!");
      print("Do you want to play again? (y/n)");
      String? again = stdin.readLineSync();
      if (again?.toLowerCase() != 'y') break;
      resetBoard();
      currentPlayer = 'X';
      continue;
    }

    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }

  print("Thanks for playing!");
}
