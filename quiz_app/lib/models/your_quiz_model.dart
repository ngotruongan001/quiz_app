class YourQuiz {
  String yourChoose;
  String correctAnswer;
  bool isCorrect;
  List<String> allQuestion;

  YourQuiz(
      {required this.yourChoose,
        required this.correctAnswer,
        required this.allQuestion,
        required this.isCorrect});
  @override
  String toString() {
    return '{yourChoose: $yourChoose - correctAnswer: $correctAnswer - isCorrect: $isCorrect }';
  }
}