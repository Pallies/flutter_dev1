import 'package:flutter/material.dart';

import 'dice_roller.dart';

class GradientContainer extends StatelessWidget {
   const GradientContainer(this.colors, {super.key});

  final List<Color> colors;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
      ),
      child: Center(
        child:  DiceRoller()
      ),
    );
  }
}
