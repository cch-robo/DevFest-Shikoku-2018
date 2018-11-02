import 'package:flutter/material.dart';
import 'package:devfest_shikoku_2018/src/json_model.dart';
import 'package:devfest_shikoku_2018/src/list_page.dart';

void main() => runApp(new MyApp());

/// アプリ全体のルート （Widgetツリー定義）
class MyApp extends StatelessWidget {

  final MyAppStatus _myAppStatus = new MyAppStatus();
  MyAppStatus get status => _myAppStatus;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Love Dog',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new ListPage(status),
    );
  }
}

/// アプリ全体で共有する状態
class MyAppStatus {
  final List<ContestDog> challengers = <ContestDog>[];
  final Set<ContestDog> saved = new Set<ContestDog>();
  final TextStyle biggerFont = const TextStyle(fontSize: 18.0);
}
