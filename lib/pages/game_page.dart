import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/game_page_provider.dart';

class GamePage extends StatefulWidget {
  final String difficultyLevel;

  const GamePage({super.key, required this.difficultyLevel});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late double _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
          context: context, difficultyLevel: widget.difficultyLevel),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: const Text(
              "Quiz App",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
              // color: Colors.orange[300],
              padding: EdgeInsets.symmetric(
                horizontal: _deviceHeight * 0.05,
                vertical: _deviceWidth * 0.05,
              ),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _playButton("True", Colors.green),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _playButton("False", Colors.red),
          ],
        )
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuesiton(),
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  Widget _playButton(String name, Color btnColor) {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.answerQuestion(name);
      },
      color: btnColor,
      minWidth: _deviceWidth * .80,
      height: _deviceHeight * .10,
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
