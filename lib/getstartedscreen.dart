import 'package:flutter/material.dart';
import 'package:guessapp/modesscreen.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Spacer(),
              Center(
                child: Image.asset(
                  'assets/images/download.png',
                  height: 280.0,
                  width: 280.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Brain',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    TextSpan(
                      text: 'Buzz',
                      style: TextStyle(color: Color(0xFF9AC308), fontSize: 35),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Text(
                "Guess the words and boost your\n                 brainpower",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModeScreen()),
                    );
                  },
                  child: Text("✨  Get Started", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9AC308),
                    foregroundColor: Colors.black,
                    elevation: 5,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
