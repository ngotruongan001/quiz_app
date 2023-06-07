import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/bloc/home/home_cubit.dart';
import 'package:quiz_app/common/widgets/button_widget.dart';
import 'package:quiz_app/modules/history/history_page.dart';
import 'package:quiz_app/modules/question/question_page.dart';
import 'package:quiz_app/themes/app_colors.dart';
import 'package:quiz_app/themes/styles_text.dart';
import 'package:quiz_app/utils/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = HomeCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(),
                _buttonStart(),
                _buttonHistory(),
                _buttonExit()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo(){
    return SizedBox(
      width: 200,
      height: 200,
      child: Lottie.asset(AssetJSON.logo)
    );
  }

  Widget _buttonStart() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: MainButton(
        title: "Start Quiz",
        textStyle: StylesText.body1,
        onPressed: (){onPresedNavigate(QuestionPage(homeBloc: bloc,));},
        minWidth: 170.w,
        backgroundColor: AppColors.red,
        radius: 50.r,

      ),
    );
  }

  Widget _buttonHistory() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: MainButton(
        title: "History",
        textStyle: StylesText.body1,
        onPressed: (){onPresedNavigate(HistoryPage(homeBloc: bloc,));},
        minWidth: 170.w,
        backgroundColor: AppColors.red,
        radius: 50.r,

      ),
    );
  }

  Widget _buttonExit() {
    return MainButton(
      title: "Exit",
      textStyle: StylesText.body1,
      onPressed: (){
        SystemNavigator.pop();
      },
      minWidth: 170.w,
      backgroundColor: AppColors.red,
      radius: 50.r,

    );
  }

  void onPresedNavigate(Widget widget){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
  }

}
