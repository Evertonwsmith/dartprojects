import 'dart:math';

import 'package:dartprojects/decorations.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const CulorTwo());
}

class CulorTwo extends StatelessWidget {
  const CulorTwo({super.key});

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
  late int gameDate;
  late Color color1;
  late Color color2;
  late Color color3;
  late int result;
  late int progress;
  late List colorList;
  late int ranInt;
  late Text progressText;
  late Widget statusBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statusBox = SizedBox(height: 15);
    gameDate = DateTime.now().millisecondsSinceEpoch;
    color1 = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
    color2 = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
    color3 = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
    colorList = [color1, color2, color3];
    progressText =
        Text("Select the RGB value you think matches the colour shown :)");
    result = 0;
    progress = 0;
    int randomNumber = Random().nextInt(3) + 1;
    ranInt = randomNumber - 1;
  }

  void _nextRound() {
    color1 = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
    color2 = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
    color3 = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256));
    colorList = [color1, color2, color3];
    int randomNumber = Random().nextInt(3) + 1;
    ranInt = randomNumber - 1;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        statusBox = SizedBox(height: 15);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Culor2'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          progressText,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(progress.toString() + "/5", style: TextStyle(fontSize: 40))
          ]),
          SizedBox(height: 20),
          statusBox,
          SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorList[ranInt],
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
              style: AppDecorations.buttonStyle(),
              onPressed: () => endResult(1),
              child: Text(color1.red.toString() +
                  "," +
                  color1.green.toString() +
                  "," +
                  color1.blue.toString())),
          SizedBox(height: 20),
          ElevatedButton(
              style: AppDecorations.buttonStyle(),
              onPressed: () => endResult(2),
              child: Text(color2.red.toString() +
                  "," +
                  color2.green.toString() +
                  "," +
                  color2.blue.toString())),
          SizedBox(height: 20),
          ElevatedButton(
              style: AppDecorations.buttonStyle(),
              onPressed: () => endResult(3),
              child: Text(color3.red.toString() +
                  "," +
                  color3.green.toString() +
                  "," +
                  color3.blue.toString())),
        ],
      )),
    );
  }

  endResult(int n) {
    if (n == ranInt + 1) {
      correct();
    } else {
      wrong();
    }
  }

  correct() {
    setState(() {
      progress++;
      statusBox = Text("Correct!", style: TextStyle(fontSize: 24));
      if (progress == 5) {
        _showEndGame();
      } else {
        _nextRound();
      }
    });
  }

  _showEndGame() {
    setState(() {
      progressText = Text("Great Job!", style: TextStyle(fontSize: 24));
    });
  }

  wrong() {
    setState(() {
      statusBox = Text("Wrong!", style: TextStyle(fontSize: 24));
      if (progress > 0) {
        progress--;
      }
      _nextRound();
    });
  }
}
