import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/data/repository.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/save_quiz_model.dart';
import 'package:quiz_app/models/your_answer_model.dart';
part 'question_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  var chooseAnswerValueNotifier = ValueNotifier("");
  var indexQuizValueNotifier = ValueNotifier(0);
  List<Quiz> listQuiz = [];
  int seconds = 0;
  Timer? _timer;
  var resultYourQuiz = SaveQuiz(countCorrect: 0, listYourQuiz: [], seconds: 0);

  var repo = Repository();

  Future<void> initData() async{
    try{
      getData();
    }catch(e){
      emit(QuizGetDataFailed("Get data failed!!"));
    }
  }

  void getData() async {
    emit(QuizLoading());
    var list = await repo.getData();
    print("list ${list}");
    listQuiz = list;
    emit(QuizGetDataSuccess(listQuiz));
  }

  void handleSaveAnswer() {
    bool isCorrect = listQuiz[indexQuizValueNotifier.value].correctAnswer ==
        chooseAnswerValueNotifier.value;
    var yourAnswer = YourAnswer(
      correctAnswer:
      listQuiz[indexQuizValueNotifier.value].correctAnswer ?? '',
      allAnswer: listQuiz[indexQuizValueNotifier.value].allAnswer ?? [],
      yourChoose: chooseAnswerValueNotifier.value,
      isCorrect: isCorrect,
      question: listQuiz[indexQuizValueNotifier.value].question ?? '',
    );

    if (isCorrect) {
      resultYourQuiz.addCount();
    }
    resultYourQuiz.seconds = seconds;
    resultYourQuiz.addListQuiz(yourAnswer);

  }

  void onPressedCheckedAnswer(String value) {
    chooseAnswerValueNotifier.value = value;
  }


  void onPressedNext() {
    indexQuizValueNotifier.value = indexQuizValueNotifier.value + 1;
    chooseAnswerValueNotifier.value = "";
  }

  void onPressedSubmit() {
    chooseAnswerValueNotifier.value = "";
    indexQuizValueNotifier.value = 0;
    cancelTime();
    emit(QuizSubmit(listQuiz, ""));
  }

  void onPressedPlayAgain() {
    try{
      resultYourQuiz = SaveQuiz(countCorrect: 0, listYourQuiz: [], seconds: 0);
      getData();
      startTimer();
    }catch(e){
      emit(QuizGetDataFailed("Get data failed!!"));
    }
  }

  void startTimer() {
    seconds = 0;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      seconds++;
    });
  }

  void cancelTime() {
    _timer?.cancel();
  }

  String formatSeconds(int seconds) {
    int minutes = (seconds ~/ 60); // Calculate the minutes
    int remainingSeconds = seconds % 60; // Calculate the remaining seconds

    String minutesStr =
    minutes.toString().padLeft(2, '0'); // Ensure two-digit format
    String secondsStr =
    remainingSeconds.toString().padLeft(2, '0'); // Ensure two-digit format

    return '$minutesStr:$secondsStr';
  }

}