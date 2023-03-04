import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'constant/words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _roundWords = [];
  final List<List<String>> _wordGrid =
      List.generate(4, (_) => List.generate(4, (_) => ''));

  void _setWordGrid() {
    setState(() {
      int idx = 0;
      while (true) {
        if (idx == 4) {
          break;
        }
        int randIdx = Random().nextInt(words.length);
        if (!_roundWords.contains(words[randIdx])) {
          var newWord = words[randIdx].toUpperCase();
          _roundWords.add(newWord);

          for (var i = 0; i < 4; i++) {
            _wordGrid[idx][i] = newWord.substring(i, i + 1);
          }
          idx++;
        }
      }
    });
  }

  void _shuffleWordGrid() {
    setState(() {
      for (int i = 0; i < 4; i++) {
        List<String> columnArr = [
          _wordGrid[0][i],
          _wordGrid[1][i],
          _wordGrid[2][i],
          _wordGrid[3][i]
        ];
        columnArr.shuffle();
        for (int j = 0; j < 4; j++) {
          _wordGrid[j][i] = columnArr[j];
        }
      }
    });
  }

  // Widget shuffleWords() {
  // return OutlinedButton(onPressed: _shuffleWordGrid, child: Text("SHUFFLE"));
  // }

  GridView makeWordGrid() {
    _setWordGrid();
    _shuffleWordGrid();
    int axisCount = _wordGrid.length;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount),
        itemCount: _wordGrid[0].length * _wordGrid.length,
        itemBuilder: _buildGridItems);
  }

  Widget _buildGridItems(BuildContext ctx, int index) {
    if (_wordGrid.isEmpty) {
      return const GridTile(

        child: Center(child: Text('')),
      );
    }
    int itemCount = _wordGrid.length;
    int x = 0, y = 0;
    x = (index / itemCount).floor();
    y = (index % itemCount);

    return GridTile(
      child: Center(child: Text(_wordGrid[x][y])),
    );
  }

  void lockRow() {}

  void unlockRow() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: makeWordGrid(),
          )
        ],
      ),
    );
  }
}
