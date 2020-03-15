import 'package:covid19simulator/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'Coronavirus Simulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Game(),
    );
  }
}