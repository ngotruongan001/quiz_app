import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/common/widgets/answer_widget.dart';
import 'package:quiz_app/common/widgets/button_widget.dart';
import 'package:quiz_app/common/widgets/result_box_widget.dart';
import 'package:quiz_app/data/repository.dart';
import 'package:quiz_app/models/save_quiz_model.dart';
import 'package:quiz_app/models/your_quiz_model.dart';
import 'package:quiz_app/themes/app_colors.dart';
import 'package:quiz_app/themes/styles_text.dart';
import 'package:quiz_app/utils/app_images.dart';
import '../../common/widgets/question_widget.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var chooseAnswerValueNotifier = ValueNotifier("");
  var indexQuizValueNotifier = ValueNotifier(0);
  var listQuiz = [];
  var isLoading = true;
  var resultYourQuiz = SaveQuiz(countCorrect: 0, listYourQuiz: []);
  int _seconds = 0;
  Timer? _timer;

  var repo = Repository();

  void getData() async {
    var list = await repo.getData();
    setState(() {
      listQuiz = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print("init State");
    startTimer();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexQuizValueNotifier,
        builder: (context, index, child) {
          return SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? Center(
                        child: Text(
                          "Loading...",
                          style: StylesText.header1
                              .copyWith(color: AppColors.white),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _exitQuestion(),
                          _question(
                              index, listQuiz, listQuiz[index].question ?? ""),
                          _widgetListAnswer(listQuiz[index].allAnswer ?? []),
                          _buttonNextQuestion(handleSaveAnswer, index, () {
                            onPressedSubmit(showSubmit);
                          }, onPressedNext),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _exitQuestion() {
    return SizedBox(
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              onPressedNavigatePop();
            },
            child: Text(
              "x",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _question(index, listQuiz, question) {
    return QuestionWidget(
      indexAction: index,
      question: question,
      totalQuestions: listQuiz.length,
    );
  }

  Widget _widgetListAnswer(List<String> allQuestion) {
    return ValueListenableBuilder(
      valueListenable: chooseAnswerValueNotifier,
      builder: (context, value, child) {
        return Column(
          children: [
            for (String i in allQuestion)
              _widgetAnswer(
                answer: i,
                isChecked: i == value,
              ),
          ],
        );
      },
    );
  }

  Widget _widgetAnswer({
    required String answer,
    required bool isChecked,
  }) {
    return AnswerWidget(
      isCheck: isChecked,
      answer: answer,
      onPressed: () => onPessedCheckedAnswer(answer),
    );
  }

  Widget _buttonNextQuestion(
      handleSaveAnswer, index, Function onPressedSubmit, onPressedNext) {
    return ValueListenableBuilder(
      valueListenable: chooseAnswerValueNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: MainButton(
            onPressed: () {
              handleSaveAnswer();
              value.isEmpty
                  ? null
                  : index == (listQuiz.length - 1)
                      ? onPressedSubmit()
                      : onPressedNext();
            },
            height: 60.h,
            radius: 60.r,
            minWidth: 0.7.sw,
            title: index == (listQuiz.length - 1) ? "Submit" : "Next",
            backgroundColor: value.isEmpty ? Colors.grey : Colors.red,
          ),
        );
      },
    );
  }

  void showSubmit() {
    var score =
        resultYourQuiz.countCorrect / resultYourQuiz.listYourQuiz.length * 100;

    Widget _widgetContent() {
      return ResultBox(
        title: score >= 50 ? "Congratulation!" : "Completed!",
        iconShow: score >= 50 ? AssetPNG.done : AssetPNG.replay,
        message: score >= 50 ? "You are amazing!!" : "Better luck next time!",
        time: '$_seconds',
        function: () {
          resultYourQuiz.remove();
          getData();
          startTimer();
          onPressedNavigatePop();
        },
        titleButton: "Play Again",
        score: '${resultYourQuiz.countCorrect}',
        questions: '${resultYourQuiz.listYourQuiz.length}',
      );
    }

    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _widgetContent(),
          ],
        );
      },
    );
  }

  void onPessedCheckedAnswer(String value) {
    chooseAnswerValueNotifier.value = value;
  }

  void onPressedNavigatePop() {
    Navigator.pop(context);
  }

  void handleSaveAnswer() {
    bool isCorrect = listQuiz[indexQuizValueNotifier.value].correctAnswer ==
        chooseAnswerValueNotifier.value;
    var yourAnswer = YourQuiz(
        correctAnswer:
            listQuiz[indexQuizValueNotifier.value].correctAnswer ?? '',
        allQuestion: listQuiz[indexQuizValueNotifier.value].allAnswer ?? [],
        yourChoose: chooseAnswerValueNotifier.value,
        isCorrect: isCorrect);

    if (isCorrect) {
      resultYourQuiz.addCount();
    }
    resultYourQuiz.addListQuiz(yourAnswer);
  }

  void onPressedNext() {
    indexQuizValueNotifier.value = indexQuizValueNotifier.value + 1;
    chooseAnswerValueNotifier.value = "";
  }

  void onPressedSubmit(Function showSubmit) {
    chooseAnswerValueNotifier.value = "";
    indexQuizValueNotifier.value = 0;
    print('resultYourQuizz $resultYourQuiz');
    print('time ${formatSeconds(_seconds)}s');
    setState(() {
      isLoading = true;
    });
    cancelTime();
    showSubmit();
  }

  void startTimer() {
    _seconds = 0;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      _seconds++;
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
