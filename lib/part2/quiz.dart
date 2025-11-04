
import 'package:first_app/part2/question_screen.dart';
import 'package:first_app/part2/result_screen.dart';
import 'package:first_app/part2/start_screen.dart';
import 'package:flutter/material.dart';

import 'data/questions.dart';


class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  String activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void respondToAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void switchScreen() {
    setState(() {
      if (activeScreen == 'start-screen') {
        activeScreen = 'question-screen';
      } else {
        selectedAnswers=[];
        activeScreen = 'start-screen';
      }
    });
  }

  Widget selectedScreen() {
    return activeScreen == 'start-screen'
        ? StartScreen(onPressed: switchScreen)
        : activeScreen == 'question-screen'
        ? QuestionScreen(onSelectAnswer: respondToAnswer)
        : ResultScreen(selectedAnswers: selectedAnswers,onRestart: switchScreen,);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = selectedScreen();
    // if(activeScreen == 'start-screen'){
    //   screenWidget = StartScreen(onPressed: switchScreen);
    // }
    // if(activeScreen == 'question-screen'){
    //   screenWidget = QuestionScreen(onSelectAnswer: respondToAnswer);
    // }
    // if(activeScreen == 'result-screen'){
    //   screenWidget = ResultScreen();
    // }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.deepOrangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
