import 'package:flutter/material.dart';
import 'package:guessapp/guessscreen.dart';

class ModeScreen extends StatelessWidget {
  ModeScreen({super.key});
  List<String> words = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Brain',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Buzz',
                        style: TextStyle(color: Color(0xFF779508)),
                      ),
                    ], style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose Your\nMode",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      // Easy
                      Container(
                        width: 300,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuessScreen(
                                        index: 0,
                                        initialscore: 0,
                                      )),
                            );
                          },
                          child: Text("Easy", style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF779508),
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(25), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Intermediate
                      Container(
                        width: 300,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuessScreen(
                                        index: 1,
                                        initialscore: 0,
                                      )),
                            );
                          },
                          child: Text("Intermediate",
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF779508),
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(25), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Hard
                      Container(
                        width: 300,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuessScreen(
                                        index: 2,
                                        initialscore: 0,
                                      )),
                            );
                          },
                          child: Text("Hard", style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF779508),
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // Time Based
                      Container(
                        width: 300,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuessScreen(
                                        index: 3,
                                        initialscore: 0,
                                      )),
                            );
                          },
                          child: Text("Time challenge",
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF779508),
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Spacer(), // Spacer now works correctly
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Navigate back
                            },
                            child: Text('Back'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              elevation: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
