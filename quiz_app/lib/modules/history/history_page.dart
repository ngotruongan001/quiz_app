import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/bloc/home/home_cubit.dart';
import 'package:quiz_app/common/widgets/button_widget.dart';
import 'package:quiz_app/models/save_history_model.dart';
import 'package:quiz_app/modules/history/history_detail_page.dart';
import 'package:quiz_app/themes/app_colors.dart';
import 'package:quiz_app/themes/styles_text.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.homeBloc}) : super(key: key);
  final HomeCubit homeBloc;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
          bloc: widget.homeBloc,
          builder: (context, state) {
            return Container(
              width: 1.sw,
              height: 1.sh,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(color: AppColors.background1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _widgetTitle(),
                    state is HomeInitial || state is HomeLoading
                        ? Text(
                            "List Empty...",
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          )
                        : const SizedBox.shrink(),
                    state is HomeSaveSuccess
                        ? _widgetListYourQuiz(state.listData)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _widgetTitle(){
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "History Submit Quiz",
            style: StylesText.header1
                .copyWith(color: AppColors.accent1),
          ),
          InkWell(
            onTap: () {
              onPressedNavigatePop();
            },
            child: Text(
              "x",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget _widgetListYourQuiz(List<SaveHistory> listData) {
    return Column(
      children: [
        for (var i = 0; i < listData.length; i++)
          _widgetYourQuiz(data: listData[i])
      ],
    );
  }

  Widget _widgetYourQuiz({required SaveHistory data}) {
    return Container(
      width: 1.sw,
      height: 65.h,
      margin: EdgeInsets.only(bottom: 20.r),
      padding: EdgeInsets.only(left: 15.r, right: 15.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65.r),
        border: Border.all(
          color: AppColors.grey,
          width: 2.r,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 0.5.sw,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Result: ",
                  style: StylesText.body2.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  "${data.resultYourQuiz.countCorrect}/${data.resultYourQuiz.listYourQuiz.length}",
                  style: StylesText.body2.copyWith(
                    color: data.resultYourQuiz.countCorrect >= 5
                        ? AppColors.accent1
                        : AppColors.red,
                  ),
                ),
                Text(
                  " ( Time: ${data.resultYourQuiz.seconds}s)",
                  style: StylesText.body4.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          MainButton(
            onPressed: () {
              onPressedNavigateDetail(data);
            },
            title: "Detail",
            minWidth: 0.2.sw,
            height: 5.h,
            radius: 60.r,
            backgroundColor: AppColors.accent1,
            textStyle: StylesText.body4,
          )
        ],
      ),
    );
  }

  void onPressedNavigatePop() {
    Navigator.pop(context);
  }

  void onPressedNavigateDetail(SaveHistory data) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizDetailPage(data: data),
        ));
  }
}
