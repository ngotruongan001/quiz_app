import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/common/widgets/button_widget.dart';
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
    return MainButton(
      title: "Start Quiz",
      textStyle: StylesText.body1,
      onPressed: onPressNavigate,
      minWidth: 150.w,
      backgroundColor: AppColors.red,
      radius: 50.r,
    );
  }

  void onPressNavigate(){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> QuestionPage()));
  }

}
