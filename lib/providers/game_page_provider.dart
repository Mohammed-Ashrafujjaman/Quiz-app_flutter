import 'dart:convert';
import 'package:flutter/material.dart';
import "package:dio/dio.dart";

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  final String difficultyLevel;
  List? questions;
  int _currrentQuestion = 0;
  int _correctAnswer = 0;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}) {
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
        'difficulty': difficultyLevel,
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
    _correctAnswer += isCorrect ? 1 : 0;
    _currrentQuestion++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigator.pop(context);
    }

    if (_currrentQuestion >= 10) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "Game Ends.",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          content: Text(
            "Score: $_correctAnswer/10",
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
