import 'package:flutter/material.dart';
import 'package:devfest_shikoku_2018/src/app.dart';
import 'package:devfest_shikoku_2018/src/json_model.dart';

/// トータル画面 （Widgetツリー定義）
class TotalPage extends StatefulWidget {

  final MyAppStatus appStatus;
  final _TotalPageController controller = new _TotalPageController();
  TotalPage(this.appStatus);

  @override
  TotalPageState createState() => new TotalPageState();
}

class TotalPageState extends State<TotalPage> {

  @override
  Widget build(BuildContext context) {
    // どのタイミングで画面が生成されるかデバッグ表示
    debugPrint("TotalPageState  build!");

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Saved Dogs'),
      ),
      body: new ListView(
          children: ListTile.divideTiles(
            context: context,

            /*
            // リストに、丸アイコンを表示する場合
            tiles: widget.appStatus.saved.map((ContestDog challenger) =>
              new ListTile(
                leading: new CircleAvatar(backgroundImage: new NetworkImage(challenger.dog.imageUrl)),
                title: new Text(
                  challenger.dog.name,
                  style: widget.appStatus.biggerFont,
                ),
              ),
            ),
           */
            // リストに、サイズ指定して画像を表示
            tiles: widget.appStatus.saved.map((ContestDog challenger) =>
              SizedBox(
                height: 50.0,
                child:
                    new ListTile(
                      leading: new Image.network(challenger.dog.imageUrl),
                      title: new Text(
                        challenger.dog.name,
                        style: widget.appStatus.biggerFont,
                      ),
                    ),
              )
            ),

          ).toList(),
        ),
    );
  }
}

/// トータル画面のコントローラ
class _TotalPageController {
}
