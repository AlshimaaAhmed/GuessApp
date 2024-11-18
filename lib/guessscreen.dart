import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guessapp/gameoverscreen.dart';

import 'congratescreen.dart';

class GuessScreen extends StatefulWidget {
  final List<List<String>> levels = [
    ['apple', 'house', 'chair', 'table', 'plant', 'river', 'piano'],
    ['banana', 'planet', 'guitar', 'castle', 'island', 'engine', 'puzzle'],
    ['meteor', 'museum', 'oxygen', 'thunder', 'stereo', 'mountain', 'jungle'],
    ['calendar', 'rooster', 'season', 'sunrise', 'clock', 'festival', 'yearly']
  ];
  final List<List<String>> hints = [
    [
      'A fruit',
      'A place to live',
      'You sit on it',
      'A piece of furniture',
      'A green organism',
      'Water flows here',
      'A musical instrument'
    ],
    [
      'Yellow fruit',
      'Celestial body',
      'Musical instrument',
      'Big building',
      'Surrounded by water',
      'Drives machines',
      'A game with pieces'
    ],
    [
      'Space rock',
      'Place with artifacts',
      'Essential for breathing',
      'Loud weather event',
      'Sound system',
      'Tall geographical feature',
      'Dense forest'
    ],
    [
      'Tracks days',
      'Farm animal',
      'Quarterly change',
      'Morning light',
      'Tells time',
      'Joyous gathering',
      'Annual event'
    ]
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
  bool ishintshowen = false;

  late List<String> words;
  late List<String> hints;
  late List<List<TextEditingController>> letterControllers;
  late List<List<FocusNode>> focusNodes;
  late List<List<Color>> boxColors;

  int remainingSeconds = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    hints = widget.hints[widget.index];

    List<int> indices =
        List.generate(widget.levels[widget.index].length, (i) => i)..shuffle();
    words = List.generate(
      5,
      (i) => widget.levels[widget.index]
          [indices[i % widget.levels[widget.index].length]],
    );
    hints = List.generate(
      5,
      (i) => widget.hints[widget.index]
          [indices[i % widget.hints[widget.index].length]],
    );

    score = widget.initialscore;
    initializeGame();

    if (widget.names[widget.index] == "TimeBased") {
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      remainingSeconds = 60;
    });
    startTimer();
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
    if (widget.names[widget.index] == "TimeBased") {
      resetTimer();
    }
    ishintshowen = false;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        endGameDueToTimeout();
      }
    });
  }

  void endGameDueToTimeout() {
    setState(() {
      isGameOver = true;
    });
    showSnackBar(
        "Time's up! The correct word was '${words[currentWordIndex]}'.");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => gameoverscreen(index: widget.index)));
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
        score += 10;
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

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => gameoverscreen(index: widget.index)));
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

  void showHintScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (ishintshowen) {
          Future.microtask(() => showActualHintDialog());
          return Container();
        } else if (score >= 10) {
          return AlertDialog(
            backgroundColor: const Color(0xFF4B572B),
            title: Text(
              "Are you sure?",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Using a hint will cost 10 points. Do you want to proceed?",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    score -= 10;
                    ishintshowen = true;
                  });
                  Navigator.of(context).pop();
                  showActualHintDialog();
                },
                child: Text("Proceed", style: TextStyle(color: Colors.green)),
              ),
            ],
          );
        } else {
          return AlertDialog(
            backgroundColor: const Color(0xFF4B572B),
            content: Text(
              "Sorry, your score is not enough 😞",
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        }
      },
    );
  }

  void showActualHintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF4B572B),
          title: Text("💡Hint", style: TextStyle(color: Colors.white)),
          content: Text(
            hints[currentWordIndex],
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                if (widget.names[widget.index] == "TimeBased")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              "00:$remainingSeconds",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: showHintScreen,
                      child: Text("💡Hint", style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9AC308),
                        foregroundColor: Colors.black,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF9AC308),
                      ),
                      padding: EdgeInsets.all(8),
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
