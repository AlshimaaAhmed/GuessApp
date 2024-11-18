import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:guessapp/guessscreen.dart';

import 'modesscreen.dart';

class Congratescreen extends StatefulWidget {
  int index;
  int score;
  Congratescreen({required this.index, required this.score}) : super();

  @override
  _CongratescreenState createState() => _CongratescreenState();
}

class _CongratescreenState extends State<Congratescreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Spacer(),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("🌟", style: TextStyle(fontSize: 40)),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("🌟", style: TextStyle(fontSize: 40)),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("🌟", style: TextStyle(fontSize: 40)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Awesome!",
                            style:
                                TextStyle(fontSize: 40, color: Colors.white)),
                        SizedBox(height: 120),
                        Text("You've conquered this level",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20),
                            if (widget.index < 3)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GuessScreen(
                                        index: widget.index +
                                            1, // Increment index safely here
                                        initialscore: widget.score,
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Next Level",
                                    style: TextStyle(fontSize: 13)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9AC308),
                                  foregroundColor: Colors.black,
                                  elevation: 5,
                                ),
                              ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ModeScreen()),
                                );
                              },
                              child:
                                  Text("Home", style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF9AC308),
                                foregroundColor: Colors.black,
                                elevation: 5,
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Spacer(),
                ],
              ),
            ),
            ConfettiWidget(
              blastDirection: 3.14 / 2,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow
              ],
              confettiController: _confettiController,
            ),
          ],
        ),
      ),
    );
  }
}
