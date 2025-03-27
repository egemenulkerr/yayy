import 'package:flutter/material.dart';

import 'package:yayy/screens/home_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Homepage",
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurpleAccent
          ),
        ),
      ),
    );
  }
}