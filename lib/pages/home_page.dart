import 'package:flutter/material.dart';
import 'package:quiz_app/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  double _currentDifficultyLevel = 0;
  final List<String> _sliderLabel = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _homePageLogo(),
                    _appName(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _sliderLabel[_currentDifficultyLevel.toInt()],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    _difficulySlider(),
                  ],
                ),
                _startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appName() {
    return const Text(
      "Take A Quiz!",
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: Colors.orange,
      ),
    );
  }

  Widget _homePageLogo() {
    return Image.asset(
      "assets/logo/brain.png",
      height: 100,
      width: 100,
    );
  }

  Widget _difficulySlider() {
    return Slider(
        label: _sliderLabel[_currentDifficultyLevel.toInt()],
        min: 0,
        max: 2,
        divisions: 2,
        value: _currentDifficultyLevel,
        onChanged: (values) {
          setState(() {
            _currentDifficultyLevel = values;
          });
        });
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return GamePage(
                difficultyLevel:
                    _sliderLabel[_currentDifficultyLevel.toInt()].toLowerCase(),
              );
            },
          ),
        );
      },
      minWidth: _deviceWidth * 0.75,
      height: _deviceHeight * 0.07,
      color: Colors.orange,
      child: const Text(
        "Start Game ->",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
