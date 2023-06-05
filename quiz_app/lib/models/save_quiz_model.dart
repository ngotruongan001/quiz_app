import 'package:quiz_app/models/your_quiz_model.dart';

class SaveQuiz {
  int countCorrect = 0;
  List<YourQuiz> listYourQuiz;

  SaveQuiz({required this.countCorrect, required this.listYourQuiz});
  void addCount() {
    countCorrect = countCorrect + 1;
  }

  void remove() {
    countCorrect = 0;
    listYourQuiz = [];
  }

  void addListQuiz(YourQuiz quiz) {
    listYourQuiz.add(quiz);
  }

  @override
  String toString() {
    return '{countCorrect: $countCorrect - listYourQuizz: $listYourQuiz}';
  }
}
