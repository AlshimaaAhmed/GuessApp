import 'package:flutter/material.dart';
import 'package:guessapp/guessscreen.dart';

import 'modesscreen.dart';

class gameoverscreen extends StatefulWidget {
  int index;
  gameoverscreen({required this.index}) : super();

  @override
  _CongratescreenState createState() => _CongratescreenState();
}

class _CongratescreenState extends State<gameoverscreen> {
  @override
  void initState() {
    super.initState();
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
                        Text(
                          "x",
                          style: TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(height: 10),
                        Text("Game Over!",
                            style:
                                TextStyle(fontSize: 40, color: Colors.white)),
                        SizedBox(height: 120),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GuessScreen(
                                            index: widget.index,
                                            initialscore: 0,
                                          )),
                                );
                              },
                              child:
                                  Text("Retry", style: TextStyle(fontSize: 16)),
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
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
