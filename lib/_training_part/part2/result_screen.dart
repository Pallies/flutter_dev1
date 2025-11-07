import 'package:flutter/material.dart';

import 'components/questions_summary.dart';
import 'data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.selectedAnswers, required this.onRestart});

  final List<String> selectedAnswers;
  final void Function() onRestart;


  List<Map<String, Object>> get summaryData {
    List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'index': i,
        'question': questions[i].text,
        'correctAnswer': questions[i].answers[0],
        'userAnswer': selectedAnswers[i],
        'isCorrect': questions[i].answers[0] == selectedAnswers[i],
      });
    }
    questions.map((q) {
      return q.answers[0];
    });
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    int successfulAnswers() {
      return summaryData
          .where((data) => data['isCorrect'] as bool)
          .length;
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Text(
              'You answered ${successfulAnswers()} out of ${summaryData.length} questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          QuestionsSummary(summaryData: summaryData),
          const SizedBox(height: 30),
          TextButton.icon(
            onPressed: onRestart,
            label: Text('Restart Quiz'),
            icon: Icon(Icons.refresh),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
