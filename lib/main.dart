import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 9 squares
  bool ohTrun = true; // the first player is  u;
  List<String> board = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
        itemCount: 9,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _tapped(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]!, width: 1),
              ),
              child: Center(
                child: Text(
                  board[index],
                  // index.toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      // If the square is empty — make a move
      if (board[index] == '') {
        if (ohTrun) {
          board[index] = 'O'; // O's turn
        } else {
          board[index] = 'X'; // X's turn
        }

        ohTrun = !ohTrun; // switch turn
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    if (board[0] == board[1] && board[0] == board[2] && board[0] != '') {
      _showWinDialog(board[0]);
    }
    if (board[3] == board[4] && board[3] == board[5] && board[3] != '') {
      _showWinDialog(board[3]);
    }
    if (board[6] == board[7] && board[6] == board[8] && board[6] != '') {
      _showWinDialog(board[6]);
    }
    if (board[0] == board[3] && board[0] == board[6] && board[0] != '') {
      _showWinDialog(board[0]);
    }
    if (board[1] == board[4] && board[1] == board[7] && board[1] != '') {
      _showWinDialog(board[1]);
    }
    if (board[2] == board[5] && board[2] == board[8] && board[2] != '') {
      _showWinDialog(board[2]);
    }
    if (board[0] == board[4] && board[0] == board[8] && board[0] != '') {
      _showWinDialog(board[0]);
    }
    if (board[2] == board[4] && board[2] == board[6] && board[2] != '') {
      _showWinDialog(board[2]);
    }

    // Check rows, columns, and diagonals for a winner
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Winner!'),
          content: Text('$winner has won the game.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
