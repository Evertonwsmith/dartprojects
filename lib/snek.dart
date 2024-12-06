import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(snek());
}

class snek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SnakeGameScreen(),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  List<Offset> snake = [Offset(0, 0)];
  Offset food = Offset(5, 5);
  int gridSize = 10;
  Offset direction = Offset(1, 0);
  bool isGameOver = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startGame();
    _initializeKeyListener();
  }

  // Starts the game
  void _startGame() {
    setState(() {
      isGameOver = false;
      snake = [Offset(0, 0)];
      food = _generateFood();
      direction = Offset(1, 0);
    });
    _timer = Timer.periodic(Duration(milliseconds: 200), _gameLoop);
  }

  // Initializes the key listener for arrow key input
  void _initializeKeyListener() {
    // Detect arrow key presses for direction changes
    window.onKeyDown.listen((event) {
      if (event.key == "ArrowUp") {
        _changeDirection(Offset(0, -1));
      } else if (event.key == "ArrowDown") {
        _changeDirection(Offset(0, 1));
      } else if (event.key == "ArrowLeft") {
        _changeDirection(Offset(-1, 0));
      } else if (event.key == "ArrowRight") {
        _changeDirection(Offset(1, 0));
      }
    });
  }

  // Main game loop
  void _gameLoop(Timer timer) {
    setState(() {
      _moveSnake();
      _checkCollisions();
      _checkFood();
    });
  }

  // Move the snake based on the current direction
  void _moveSnake() {
    final head = snake.first + direction;
    snake = [head] + snake.sublist(0, snake.length - 1);
  }

  // Check for collisions (wall or self)
  void _checkCollisions() {
    final head = snake.first;
    if (head.dx < 0 ||
        head.dy < 0 ||
        head.dx >= gridSize ||
        head.dy >= gridSize ||
        snake.skip(1).contains(head)) {
      _endGame();
    }
  }

  // Check if snake eats the food
  void _checkFood() {
    if (snake.first == food) {
      setState(() {
        snake.add(snake.last);
        food = _generateFood();
      });
    }
  }

  // Generate food at random position
  Offset _generateFood() {
    final random = Random();
    return Offset(random.nextInt(gridSize).toDouble(),
        random.nextInt(gridSize).toDouble());
  }

  // End the game
  void _endGame() {
    setState(() {
      isGameOver = true;
      _timer?.cancel();
    });
  }

  // Change the snake's direction
  void _changeDirection(Offset newDirection) {
    if (direction.dx == -newDirection.dx || direction.dy == -newDirection.dy) {
      return; // Prevent reversing the snake
    }
    setState(() {
      direction = newDirection;
    });
  }

  // Build the game board with snake and food
  Widget _buildGameBoard() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize,
        ),
        itemCount: gridSize * gridSize,
        itemBuilder: (context, index) {
          final row = index ~/ gridSize;
          final col = index % gridSize;
          final offset = Offset(col.toDouble(), row.toDouble());

          if (snake.contains(offset)) {
            return _buildCell(Colors.green);
          } else if (offset == food) {
            return _buildCell(Colors.red);
          }
          return _buildCell(Colors.white);
        },
      ),
    );
  }

  // Build each cell of the game grid
  Widget _buildCell(Color color) {
    return Container(
      margin: EdgeInsets.all(1),
      color: color,
    );
  }

  // Build the reset button
  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _startGame,
      child: Text('Reset Game'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isGameOver) _startGame();
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isGameOver)
                      Text('Game Over', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 20),
                    _buildGameBoard(),
                    SizedBox(height: 20),
                    _buildResetButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
