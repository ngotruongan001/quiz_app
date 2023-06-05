import 'package:flutter/material.dart';
import 'package:quiz_app/common/widgets/button_widget.dart';
import 'package:quiz_app/themes/app_colors.dart';
import 'package:quiz_app/themes/app_dimension.dart';
import 'package:quiz_app/themes/styles_text.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    this.title,
    this.iconShow,
    this.message,
    this.time,
    this.score,
    required this.titleButton,
    required this.function,
    this.questions
  }) : super(key: key);
  final String? title;
  final String? iconShow;
  final String? message;
  final String? time;
  final String? score;
  final String titleButton;
  final Function function;
  final String? questions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.85.sw,
      height: 0.36.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(
            '$iconShow',
            width: 100.w,
            height: 110.h,
          ),
          Text('$title', style: StylesText.header1),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
              child: Text('$message', style: StylesText.body3)),
          Text(
            '$score/$questions correct answer in $time seconds',
            style: StylesText.body3,
          ),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            onPressed: () => function(),
            title: titleButton,
            minWidth: 100.h,
            radius: 30.r,
            backgroundColor: AppColors.red,
            textStyle: StylesText.header2,
          )
        ],
      ),
    );
  }
}
