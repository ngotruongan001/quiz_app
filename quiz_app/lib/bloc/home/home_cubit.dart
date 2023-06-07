import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/models/save_history_model.dart';
import 'package:quiz_app/models/save_quiz_model.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<SaveHistory> listData =[];

  void initData(){
    emit(HomeLoading());
    emit(HomeSaveSuccess(listData));
  }

  void addData(SaveQuiz value){
    var newList = [...listData];
    emit(HomeLoading());
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(now);
    var newData = SaveHistory(
        resultYourQuiz: value,
        time: formattedDate
    );
    newList.insert(0, newData);
    listData = newList;
    emit(HomeSaveSuccess(listData));
  }
}