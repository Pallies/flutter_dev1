class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(this.text, this.answers);

  List<String> get shuffleList {
    List<String> listSuffle = List.of(answers);
    listSuffle.shuffle();
    return listSuffle;
  }
}
