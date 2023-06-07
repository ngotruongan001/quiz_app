import 'package:quiz_app/models/save_quiz_model.dart';

class SaveHistory{
  String time;
  SaveQuiz resultYourQuiz;

  SaveHistory({required this.time,required this.resultYourQuiz});

  @override
  String toString(){
    return "{time: $time - resultYourQuiz: $resultYourQuiz";
  }
}