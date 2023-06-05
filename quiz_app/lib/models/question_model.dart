import 'dart:math';

class OpenDb {
  int? responseCode;
  List<Quiz>? results;
  OpenDb({
    this.responseCode,
    this.results,
  });

  factory OpenDb.fromMap(map) {
    var data = <Quiz>[];
    if (map['results'] != null) {
      map['results'].forEach((v) {
        data!.add(Quiz.fromMap(v));
      });
    }
    return OpenDb(
        responseCode: map['response_code'],
        results: data
    );
  }
}

class Quiz {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;
  List<String>? allAnswer;

  Quiz({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
    this.allAnswer,
  });

  factory Quiz.fromMap(map) {
    List<String> listAnswer = [];
    if (map['incorrect_answers'] != null) {
      map['incorrect_answers'].forEach((v) {
        listAnswer!.add(v as String);
      });
    }
    String correctAnswer = map['correct_answer'] ?? '';
    int index = randomIndex(listAnswer.length);
    var allAnswer = [...listAnswer];
    allAnswer.insert(index, correctAnswer);
    return Quiz(
      category: map['category'] ?? '',
      type: map['type'] ?? '',
      difficulty: map['difficulty'] ?? '',
      correctAnswer: correctAnswer,
      incorrectAnswers: listAnswer,
      question: map['question'],
      allAnswer: allAnswer,
    );
  }
}

int randomIndex(int length){
  Random random = Random();
  int randomIndex = random.nextInt(length);
  return randomIndex;
}