import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:devfest_shikoku_2018/src/app.dart';
import 'package:devfest_shikoku_2018/src/api_service.dart';
import 'package:devfest_shikoku_2018/src/json_model.dart';
import 'package:devfest_shikoku_2018/src/total_page.dart';

/// 一覧画面 （Widgetツリー定義）
class ListPage extends StatefulWidget {

  final MyAppStatus appStatus;
  final _ListPageController controller = new _ListPageController();
  ListPage(this.appStatus);

  @override
  ListPageState createState() => new ListPageState();
}

class ListPageState extends State<ListPage> {

  @override
  void initState() {
    super.initState();
    widget.controller.initChallenger(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.appStatus.challengers.clear();
  }

  @override
  Widget build(BuildContext context) {
    // どのタイミングで画面が生成されるかデバッグ表示
    debugPrint("ListPageState  build!");

    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Dog Contest'),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.list),
                onPressed: () => widget.controller._pushSaved(context, widget.appStatus)
            ),
          ],
        ),
        body: new ListView.builder(
                shrinkWrap: false, //just set
                padding: const EdgeInsets.all(16.0),
                itemCount: widget.appStatus.challengers.length * 2,
                itemBuilder: (BuildContext _context, int i) => widget.controller.itemBuilder(_context, i, widget, this)
        ),
    );
  }
}


/// 一覧画面のコントローラ
class _ListPageController {

  /// コンテスト犬 アイテム(リスト行)を作成する
  Widget itemBuilder(BuildContext _context, int i,
                      ListPage widget, ListPageState pageState) {

    if (i.isOdd) {
      return const Divider();
    }
    final int index = i ~/ 2;
    final bool alreadySaved = widget.appStatus.saved.contains(
        widget.appStatus.challengers[index]);
    return new ListTile(
      title: new Text(
        widget.appStatus.challengers[index].dog.name,
        style: widget.appStatus.biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () => widget.controller._like(alreadySaved, index, pageState),
    );
  }

  /// タッチした犬のハートマークを ON/OFF する。
  void _like(bool alreadySaved, int index, ListPageState state){
    state.setState(() {
      if (alreadySaved) {
        state.widget.appStatus.saved.remove(
            state.widget.appStatus.challengers[index]);
      } else {
        state.widget.appStatus.saved.add(
            state.widget.appStatus.challengers[index]);
      }
    });
  }

  /// タッチした犬を保存する
  void _pushSaved(BuildContext context, MyAppStatus appStatus) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return TotalPage(appStatus);
          }),
    );
  }

  /// コンテスト犬 リストを設定する。
  Future<void> initChallenger(ListPageState pageState) async {
    List<ContestDog> items = pageState.widget.appStatus.challengers;
    if(items.isEmpty) {
      List<ContestDog> challenger = await ApiService.getJsonModels();
      items.clear();
      items.addAll(challenger);
      pageState.setState((){});
    }
  }
}
