import 'package:quiz_app/models/your_answer_model.dart';

class SaveQuiz {
  int countCorrect;
  int seconds;
  List<YourAnswer> listYourQuiz;

  SaveQuiz({required this.countCorrect, required this.listYourQuiz, required this.seconds});
  void addCount() {
    countCorrect = countCorrect + 1;
  }


  void addListQuiz(YourAnswer quiz) {
    listYourQuiz.add(quiz);
  }

  @override
  String toString() {
    return '{countCorrect: $countCorrect - listYourQuizz: $listYourQuiz}';
  }
}