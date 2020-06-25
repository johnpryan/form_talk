import 'package:flutter/material.dart';

void main() {
  runApp(ClimbingApp());
}

class ClimbingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Scaffold(body: Center(child: Text('Hello, World!'),)),
    );
  }
}
