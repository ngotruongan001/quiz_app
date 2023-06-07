import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/bloc/home/home_cubit.dart';
import 'package:quiz_app/bloc/question/question_cubit.dart';
import 'package:quiz_app/common/widgets/answer_widget.dart';
import 'package:quiz_app/common/widgets/button_widget.dart';
import 'package:quiz_app/common/widgets/result_box_widget.dart';
import 'package:quiz_app/data/repository.dart';
import 'package:quiz_app/themes/app_colors.dart';
import 'package:quiz_app/themes/styles_text.dart';
import 'package:quiz_app/utils/app_images.dart';
import '../../common/widgets/question_widget.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.homeBloc}) : super(key: key);
  final HomeCubit homeBloc;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var bloc = QuizCubit();
  var repo = Repository();

  @override
  void initState() {
    super.initState();
    print("init State");
    bloc.initData();
    bloc.startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: bloc.indexQuizValueNotifier,
        builder: (context, index, child) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // từ bạn, đợi show lịch sử thử
                BlocConsumer(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is QuizLoading || state is QuizInitial) {
                      return _widgetTextMessage("Loading...");
                    }
                    if (state is QuizGetDataSuccess) {
                      var listQuiz = state.listData;
                      print("listQuiz ${listQuiz}");
                      return Column(
                        // ý t là show lên sao câu hỏi vẫn hiện ra ở nền
                        children: [
                          _exitQuestion(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _question(index, listQuiz.length, listQuiz[index].question ?? ""),
                            ],
                          ),
                          _widgetListAnswer(listQuiz[index].allAnswer ?? []),
                          _buttonNextQuestion(bloc.handleSaveAnswer, index, () {
                            bloc.onPressedSubmit();
                          }, bloc.onPressedNext),
                        ],
                      );
                    }
                    if (state is QuizGetDataFailed) {
                      return _widgetTextMessage(state.errorMessage);
                    }
                    if(state is QuizSubmit){
                      return _widgetTextMessage(state.message);
                    }
                    return _widgetTextMessage("....");
                  },
                  listener: (context, state) {},
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

  Widget _widgetTextMessage(String message) {
    return Center(
      child: Text(
        message,
        style: StylesText.header1.copyWith(color: AppColors.white),
      ),
    );
  }

  Widget _question(int index, int length,String question) {
    return QuestionWidget(
      indexAction: index,
      question: question,
      totalQuestions: length,
    );
  }

  Widget _widgetListAnswer(List<String> allQuestion) {
    return ValueListenableBuilder(
      valueListenable: bloc.chooseAnswerValueNotifier,
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
      onPressed: () => bloc.onPressedCheckedAnswer(answer),
    );
  }

  Widget _buttonNextQuestion(
      handleSaveAnswer, index, Function() onPressedSubmit, onPressedNext) {
    return ValueListenableBuilder(
      valueListenable: bloc.chooseAnswerValueNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: MainButton(
            onPressed: () {
              value.isEmpty
                  ? null
                  : bloc.handleSaveAnswer();
              value.isEmpty
                  ? null
                  : index == (bloc.listQuiz.length - 1)
                  ? showSubmit()
                  : bloc.onPressedNext();
            },
            height: 60.h,
            radius: 60.r,
            minWidth: 0.7.sw,
            title: index == (bloc.listQuiz.length - 1) ? "Submit" : "Next",
            backgroundColor: value.isEmpty ? Colors.grey : Colors.red,
          ),
        );
      },
    );
  }

  void showSubmit() {
    widget.homeBloc.addData(bloc.resultYourQuiz);
    bloc.onPressedSubmit();
    var score = bloc.resultYourQuiz.countCorrect /
        bloc.resultYourQuiz.listYourQuiz.length * 100;

    Widget _widgetContent() {
      return ResultBox(
        title: score >= 50 ? "Congratulation!" : "Completed!",
        iconShow: score >= 50 ? AssetPNG.done : AssetPNG.replay,
        message: score >= 50 ? "You are amazing!!" : "Better luck next time!",
        time: '${bloc.seconds}',
        function: () {
          bloc.onPressedPlayAgain();
          onPressedNavigatePop();
        },
        titleButton: "Play Again",
        score: '${bloc.resultYourQuiz.countCorrect}',
        questions: '${bloc.resultYourQuiz.listYourQuiz.length}',
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

  void onPressedNavigatePop() {
    Navigator.pop(context);
  }

}
