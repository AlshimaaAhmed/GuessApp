import 'package:flutter/material.dart';

import 'getstartedscreen.dart';

void main() {
  return runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
    );
  }
}
