import 'package:flutter/material.dart';
import 'package:yayy/screens/home_screen.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),
    (){
      Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen()));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_screen.jpg"),
            fit: BoxFit.cover 
          )
        ),
      ),
    );
  }
}
