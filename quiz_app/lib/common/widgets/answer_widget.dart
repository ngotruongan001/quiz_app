import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/themes/app_colors.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key? key,
    required this.onPressed,
    required this.answer,
    required this.isCheck,

  }) : super(key: key);

  final void Function() onPressed;
  final String answer;
  final bool isCheck;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onPressed()},
      child: Container(
        width: 0.9.sw,
        height: 60.h,
        margin: EdgeInsets.only(bottom: 12.h),
        padding:
        EdgeInsets.only(top: 10.r, bottom: 10.r, left: 16.r, right: 16.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: AppColors.white, width: 2.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 0.7.sw,
              height: 1.sh,
              child: Row(children: [
                Text(
                  answer,
                  style: TextStyle(
                    color: isCheck ? Colors.red : Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],)
            ),
            Icon(
              isCheck ? Icons.check_circle_outline : Icons.circle_outlined,
              size: 20.r,
              color: isCheck ? Colors.red : AppColors.white,
            ),
            // Icon(Icons.check_circle_outline, color: AppColors.white)
          ],
        ),
      ),
    );
  }
}
