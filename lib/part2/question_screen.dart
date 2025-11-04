import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/answer_button.dart';
import 'data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void nextQuestion(String answer) {
    setState(() {
      widget.onSelectAnswer(answer);
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Text(
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ...currentQuestion.shuffleList.map(
            (el) => Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 2),
              child: AnswerButton(
                text: el,
                onPressed: () {
                  nextQuestion(el);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
