import 'package:flutter/material.dart';
 import 'posts.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' API',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: posts(),
      //calling class posts
    );
  }
}

