import 'dart:math';
import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  int diceNumber = 1;

  void rollDice() {
    setState(() {
      diceNumber = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice/dice-$diceNumber.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 28, letterSpacing: 2),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
