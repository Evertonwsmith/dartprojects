import 'package:dartprojects/culorTwo.dart';
import 'package:dartprojects/decorations.dart';
import 'package:flutter/material.dart';
import 'package:dartprojects/culor.dart';
import 'package:dartprojects/magicLife.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everton Smith Dart/Flutter Demos',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Everton Smith Dart/Flutter Demos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: AppDecorations.buttonStyle(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainApp()),
                );
              },
              child: const Text('Culor'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppDecorations.buttonStyle(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CulorTwo()),
                );
              },
              child: const Text('Culor Two'),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   style: AppDecorations.buttonStyle(),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const MagicLife()),
            //     );
            //   },
            //   child: const Text('Magic Life'),
            // ),
          ],
        ),
      ),
    );
  }
}
