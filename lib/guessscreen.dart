import 'package:flutter/material.dart';

import 'congratescreen.dart';

class GuessScreen extends StatefulWidget {
  final List<List<String>> levels = [
    ['apple', 'grape', 'peach', 'berry', 'lemon'],
    ['orange', 'banana', 'melon', 'papaya', 'cherry'],
    ['mango', 'coconut', 'guava', 'kiwifruit', 'passion'],
    ['plum', 'apricot', 'nectarine', 'fig', 'lychee']
  ];
  final List<String> names = ["Easy", "Intermediate", "Hard", "TimeBased"];
  final int index;
  int initialscore;

  GuessScreen({required this.index, required this.initialscore}) : super();

  @override
  _GuessScreenState createState() => _GuessScreenState();
}

class _GuessScreenState extends State<GuessScreen> {
  final int maxTries = 5;
  int currentTry = 0;
  int currentWordIndex = 0;
  bool isGameOver = false;
  int score = 0;

  late List<String> words;
  late List<List<TextEditingController>> letterControllers;
  late List<List<FocusNode>> focusNodes;
  late List<List<Color>> boxColors;

  @override
  void initState() {
    super.initState();
    words = widget.levels[widget.index];
    score = widget.initialscore;
    initializeGame();
  }

  void initializeGame() {
    letterControllers = List.generate(
      maxTries,
      (_) => List.generate(
          words[currentWordIndex].length, (_) => TextEditingController()),
    );
    focusNodes = List.generate(
      maxTries,
      (_) => List.generate(words[currentWordIndex].length, (_) => FocusNode()),
    );
    boxColors = List.generate(
      maxTries,
      (_) => List.filled(words[currentWordIndex].length, Colors.white),
    );
    currentTry = 0;
    isGameOver = false;
  }

  void checkGuess(int row) {
    if (isGameOver) return;

    String guess = letterControllers[row]
        .map((controller) => controller.text)
        .join()
        .toLowerCase();

    if (guess.length != words[currentWordIndex].length) return;

    setState(() {
      if (guess == words[currentWordIndex]) {
        score += 10; // Add 10 points for correct answer
        isGameOver = true;
        boxColors[row] =
            List.filled(words[currentWordIndex].length, Colors.green);
        showSnackBar("Good job! Starting next word.");

        if (currentWordIndex < words.length - 1) {
          currentWordIndex++;
          initializeGame();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Congratescreen(index: widget.index, score: score)),
          );
        }
      } else {
        updateBoxColors(row, guess);
        currentTry++;
        if (currentTry < maxTries) {
          focusNodes[currentTry][0].requestFocus();
        } else {
          isGameOver = true;
          showSnackBar(
              "Game Over! The correct word was '${words[currentWordIndex]}'.");
        }
      }
    });
  }

  void updateBoxColors(int row, String guess) {
    for (int i = 0; i < words[currentWordIndex].length; i++) {
      if (guess[i] == words[currentWordIndex][i]) {
        boxColors[row][i] = Colors.green;
      } else if (words[currentWordIndex].contains(guess[i])) {
        boxColors[row][i] = Colors.orange;
      } else {
        boxColors[row][i] = Colors.grey;
      }
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text('Level: ${widget.names[widget.index]}',
                        style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Text("Score: $score",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("💡Hint", style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9AC308),
                        foregroundColor: Colors.black,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF9AC308),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < maxTries; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                  words[currentWordIndex].length, (j) {
                                return Container(
                                  width: 40,
                                  height: 50,
                                  margin: EdgeInsets.all(4),
                                  child: TextField(
                                    controller: letterControllers[i][j],
                                    focusNode: focusNodes[i][j],
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    enabled: !isGameOver && i == currentTry,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      filled: true,
                                      fillColor: boxColors[i][j],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty &&
                                          j <
                                              words[currentWordIndex].length -
                                                  1) {
                                        focusNodes[i][j + 1].requestFocus();
                                      } else if (value.isNotEmpty &&
                                          j ==
                                              words[currentWordIndex].length -
                                                  1) {
                                        checkGuess(i);
                                      }
                                    },
                                  ),
                                );
                              }),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
