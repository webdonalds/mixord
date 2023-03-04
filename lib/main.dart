import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';

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
      for (int idx = 0; idx < 4; ++idx) {
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

  ReorderableBuilder makeWordGrid(int idx) {
    final generatedChildren = List.generate(
      _wordGrid.length,
      (index) => Container(
        key: Key(_wordGrid[idx].elementAt(index)),
        color: Colors.lightBlue,
        child: Text(
          _wordGrid[idx].elementAt(index),
        ),
      ),
    );

    return ReorderableBuilder(
      scrollController: ScrollController(),
      onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {},
      builder: (children) {
        return GridView(
          key: GlobalKey(),
          controller: ScrollController(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          children: children,
        );
      },
      children: generatedChildren,
    );
  }

  void lockRow() {}

  void unlockRow() {}

  @override
  Widget build(BuildContext context) {
    _setWordGrid();
    _shuffleWordGrid();

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 100,
            child: makeWordGrid(0),
          ),
          SizedBox(
            width: 100,
            child: makeWordGrid(1),
          ),
          SizedBox(
            width: 100,
            child: makeWordGrid(2),
          ),
          SizedBox(
            width: 100,
            child: makeWordGrid(3),
          ),
        ],
      ),
    );
  }
}
