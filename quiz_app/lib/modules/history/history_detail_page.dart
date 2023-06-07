import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/common/widgets/second_button.dart';
import 'package:quiz_app/models/save_history_model.dart';
import 'package:quiz_app/models/your_answer_model.dart';
import 'package:quiz_app/themes/app_colors.dart';


import '../../themes/styles_text.dart';

class QuizDetailPage extends StatelessWidget {
  const QuizDetailPage({Key? key, required this.data}) : super(key: key);
  final SaveHistory data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Detail result: ${data.time}",
              style: StylesText.body1.copyWith(color: AppColors.white),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "${data.resultYourQuiz.countCorrect}/${data.resultYourQuiz.listYourQuiz.length}",
                  style: StylesText.body2.copyWith(
                    color: data.resultYourQuiz.countCorrect >= 5 ? AppColors.accent1 : AppColors.red,
                  ),
                ),
                Text(
                  " (${data.resultYourQuiz.seconds}s)",
                  style: StylesText.body4.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AppColors.background1,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _widgetListQuestion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetListQuestion() {
    var listYourQuiz = data.resultYourQuiz.listYourQuiz;
    return Column(
      children: [
        for(var i = 0; i < listYourQuiz.length;i++ ) _widgetQuestion(index: i, value: listYourQuiz[i])
      ],
    );
  }

  Widget _widgetQuestion({required YourAnswer value, required int index}) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.r),
      margin: EdgeInsets.only(bottom: 10.r, top: 30.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 2.r),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.7.sw,
                child: Text(
                  "${index + 1}. ${value.question}",
                  style: StylesText.header2.copyWith(
                    color: value.isCorrect ? AppColors.accent1 : AppColors  .red,
                  ),
                ),
              ),
              Text(
                "${value.isCorrect}",
                style: StylesText.header2.copyWith(
                  color: value.isCorrect ? AppColors.accent1 : AppColors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.r,),
          for(var i = 0; i< value.allAnswer.length; i++) SecondButton(
            onPressed: () {},
            answer: value.allAnswer[i],
            correctAnswer: value.correctAnswer,
            isChecked: value.yourChoose == value.allAnswer[i],
            isSubmited: true,
          ),
        ],
      ),
    );
  }

  void onPressedNavigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}