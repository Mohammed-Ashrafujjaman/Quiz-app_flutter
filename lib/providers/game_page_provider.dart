import 'dart:convert';

import 'package:flutter/material.dart';
import "package:dio/dio.dart";

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  List? questions;
  int _currrentQuestion = 0;

  BuildContext context;
  GamePageProvider({required this.context}) {
    // https://opentdb.com/api.php?amount=10&category=18&difficulty=easy&type=boolean
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionFromApi();
  }

  Future<void> _getQuestionFromApi() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'category': 18,
        'difficulty': 'easy',
        'type': 'boolean',
      },
    );
    var _data = jsonDecode(_response.toString());
    questions = _data['results'];
    print(questions);
    notifyListeners();
  }

  String getCurrentQuesiton() {
    return questions![_currrentQuestion]['question'];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect = questions![_currrentQuestion]['correct_answer'] == _answer;
    _currrentQuestion++;
    print(isCorrect ? "Correct" : 'Incorrect');
    notifyListeners();
  }
}
