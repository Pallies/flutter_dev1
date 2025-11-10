import 'package:flutter/material.dart';

import 'gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: GradientContainer([Colors.blue, Colors.deepOrangeAccent]),
      ),
    ),
  );
}


