import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late int gameDate;
  late Color color1;
  late Color color2;
  late Color color3;
  late int result;
  late int progress;
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

@override
void initState() {
  super.initState();
  var now = DateTime.now();
  var formatter = DateFormat('MMddyyyy');
  gameDate = int.parse(formatter.format(now));
}

class _GamePageState extends State<GamePage> {
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
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("STAR STAR STAR STAR STAR")]),
          ElevatedButton(onPressed: onPressed, child: child),
          ElevatedButton(onPressed: onPressed, child: child),
          ElevatedButton(onPressed: onPressed, child: child),
        ],
      )),
    );
  }
}
