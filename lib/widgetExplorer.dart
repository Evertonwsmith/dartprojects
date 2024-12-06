import 'package:flutter/material.dart';

class WidgetExp extends StatelessWidget {
  const WidgetExp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: launch(),
    );
  }
}

class launch extends StatefulWidget {
  const launch({super.key});

  @override
  State<launch> createState() => _launchState();
}

class _launchState extends State<launch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Explorer'),
      ),
      body: Center(
        child: Text('Widget Explorer'),
      ),
    );
  }
}
