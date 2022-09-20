import 'package:flutter/material.dart';
import 'package:todo_application/home/home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routename,
      routes: {
        HomeScreen.routename: (_)=> HomeScreen()
      },
    );
  }
}

