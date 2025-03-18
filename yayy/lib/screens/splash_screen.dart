import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
           gradient: LinearGradient(
            colors:[ Colors.black87,Colors.deepPurpleAccent],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
           )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text("yayy!",style: TextStyle(color: Colors.black87,fontSize: 50),)
             
          ],
        ),
      ),
      
    );
  }
}