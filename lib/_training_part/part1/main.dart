import 'package:flutter/material.dart';
import 'package:first_app/part1/gradient_container.dart';

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


