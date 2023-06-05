import 'package:dio/dio.dart';
import 'package:quiz_app/models/question_model.dart';

class Repository {
  final dio = Dio();

  Future<List<Quiz>> getData() async {
    try {
      var url = 'https://opentdb.com/api.php?amount=10';
      var res = await dio.get(url);
      var data = res.data;
      var result = OpenDb.fromMap(data);
      return result.results ?? [];
    } catch (e) {
      rethrow;
    }
  }
}