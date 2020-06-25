import 'package:flutter/material.dart';

import 'pages/all_climbs_page.dart';

void main() {
  runApp(ClimbingApp());
}

class ClimbingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: AllClimbsPage(),
    );
  }
}
