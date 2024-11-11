import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MagicLife());
}

class MagicLife extends StatelessWidget {
  const MagicLife({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Life',
      home: const MagicLifePage(),
    );
  }
}

class MagicLifePage extends StatefulWidget {
  const MagicLifePage({super.key});

  @override
  _MagicLifePageState createState() => _MagicLifePageState();
}

class _MagicLifePageState extends State<MagicLifePage> {
  int numPlayers = 2;
  List<int> lifeTotals = [40, 40];
  List<XFile?> images = [null, null];

  void addLife(int index) {
    setState(() {
      lifeTotals[index]++;
    });
  }

  void subtractLife(int index) {
    setState(() {
      lifeTotals[index]--;
    });
  }

  void uploadImage(int index) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      images[index] = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic Life'),
      ),
      body: Column(
        children: [
          DropdownButton<int>(
            value: numPlayers,
            onChanged: (value) {
              setState(() {
                numPlayers = value!;
                lifeTotals = List.filled(numPlayers, 40);
                images = List.filled(numPlayers, null);
              });
            },
            items: [
              DropdownMenuItem(value: 2, child: const Text('2 Players')),
              DropdownMenuItem(value: 3, child: const Text('3 Players')),
              DropdownMenuItem(value: 4, child: const Text('4 Players')),
            ],
          ),
          Expanded(
            child: GridView.builder(
              key: Key('grid-view'),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: numPlayers,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: images[index] != null
                            ? DecorationImage(
                                image: FileImage(File(images[index]!.path)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    Column(
                      children: [
                        Text('Player ${index + 1}'),
                        SizedBox(height: 10),
                        Text('Life: ${lifeTotals[index]}'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                addLife(index);
                              },
                              child: const Text('+'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                subtractLife(index);
                              },
                              child: const Text('-'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            uploadImage(index);
                          },
                          child: const Text('Upload Image'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
