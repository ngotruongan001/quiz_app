part of 'question_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizGetDataSuccess extends QuizState {
  final List<Quiz> listData;
  QuizGetDataSuccess(this.listData);
}

class QuizSubmit extends QuizState {
  final List<Quiz> listData;
  final String message;
  QuizSubmit(this.listData, this.message);
}

class QuizGetDataFailed extends QuizState {
  final String errorMessage;

  QuizGetDataFailed(this.errorMessage);
}