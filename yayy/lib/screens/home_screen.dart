import 'package:flutter/material.dart';

import 'package:yayy/screens/home_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: const Center(
        child: Text("Welcome!",style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 80),
      ),
     ),
    );
  }
}