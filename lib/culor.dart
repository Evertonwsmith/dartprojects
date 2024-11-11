import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dartprojects/decorations.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Color _targetColor;
  late Color _userColor;
  late Color _previousColor;
  late int _score;
  late Text buttonText;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    buttonText = Text("Click for answer");
    _score = 0;
    _previousColor = Colors.black;
    _targetColor = Color.fromARGB(255, Random().nextInt(256),
        Random().nextInt(256), Random().nextInt(256));
    _userColor = Colors.black;
  }

  void _startNewGame() {
    buttonText = Text("Click for answer");
    _previousColor = _targetColor;
    _targetColor = Color.fromARGB(255, Random().nextInt(256),
        Random().nextInt(256), Random().nextInt(256));
    _userColor = Colors.black;
  }

  void _calculateScore() {
    final int diff = _calculateColorDifference(_targetColor, _userColor);
    setState(() {
      _score += 50 - diff;
      _startNewGame();
    });
  }

  void _showAnswer() {
    setState(() {
      buttonText = Text(
        'Current Color: ${_targetColor.red}, ${_targetColor.green}, ${_targetColor.blue}',
        style: TextStyle(fontSize: 20),
      );
    });
  }

  int _calculateColorDifference(Color color1, Color color2) {
    final int rDiff = color1.red - color2.red;
    final int gDiff = color1.green - color2.green;
    final int bDiff = color1.blue - color2.blue;
    var _diff = rDiff.abs() + gDiff.abs() + bDiff.abs();
    if (_diff > 50) {
      _diff = 50;
    }
    return _diff;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Target Color',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              width: 150,
              height: 150,
              decoration: AppDecorations.colorDecoration(_targetColor),
            ),
            SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: TextFormField(
                controller: _controller,
                onChanged: (String value) {
                  final List<String> rgbValues = value.split(',');
                  if (rgbValues.length == 3) {
                    final int r = int.tryParse(rgbValues[0]) ?? 0;
                    final int g = int.tryParse(rgbValues[1]) ?? 0;
                    final int b = int.tryParse(rgbValues[2]) ?? 0;
                    setState(() {
                      _userColor = Color.fromARGB(255, r, g, b);
                    });
                  }
                },
                onFieldSubmitted: (String value) {
                  // _calculateScore();
                  // _controller.clear();
                },
                decoration: AppDecorations.inputDecoration(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => {_calculateScore(), _controller.clear()},
                child: Text("Enter")),

            SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Previous Color: ${_previousColor.red}, ${_previousColor.green}, ${_previousColor.blue}',
              style: TextStyle(fontSize: 20),
            ),
            //**for testing reasons */
            SizedBox(height: 20),
            // Text(
            //   'Current Color: ${_targetColor.red}, ${_targetColor.green}, ${_targetColor.blue}',
            //   style: TextStyle(fontSize: 20),
            // ),
            ElevatedButton(onPressed: _showAnswer, child: buttonText),
          ],
        ),
      ),
    );
  }
}
