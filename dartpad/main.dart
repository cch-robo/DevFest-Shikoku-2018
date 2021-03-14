import 'dart:core';
import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());


/********** アプリ全体関連のクラス **********/

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


/********** 一覧画面関連のクラス **********/

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


/********** トータル画面関連のクラス **********/

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


/********** APIサービス関連のクラス **********/

/// コンテスト犬 リストを作成するサービス
class ApiService {

  /// コンテスト犬 リストを JSONから取得する。（本来はネットワーク越しに取得）
  static Future<List<ContestDog>> getJsonModels() async {
    /// 犬画像は、いらすとや を利用させていただきました。
    /// かわいいフリー素材集 いらすとや
    /// https://www.irasutoya.com/
    String jsonList = ''
        +'['
        + '{"dog":{"name":"ボーダーコリー","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_Border_Collie.png"},"like":false},'
        + '{"dog":{"name":"秋田犬","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_akitainu.png"},"like":false},'
        + '{"dog":{"name":"バセットハウンド","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_basset_hound.png"},"like":false},'
        + '{"dog":{"name":"ボストンテリア","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_boston_terrier.png"},"like":false},'
        + '{"dog":{"name":"ブルテリア","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_bull_terrier.png"},"like":false},'
        + '{"dog":{"name":"ダルメシアン","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_dalmatian.png"},"like":false},'
        + '{"dog":{"name":"シーズー","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_shih_tzu.png"},"like":false},'
        + '{"dog":{"name":"スピッツ","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_spitz.png"},"like":false},'
        + '{"dog":{"name":"土佐犬","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_tosaken.png"},"like":false},'
        + '{"dog":{"name":"柴犬","imageUrl":"https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_shibainu_brown.png"},"like":false}'
        + ']';

    List<dynamic> dynamicList = json.decode(jsonList);
    List<ContestDog> challenger = ContestDog.fromJsonList(dynamicList);

    // 取得したデータをデバッグ表示
    debugPrint("コンテスト件データ取得");
    debugPrint("challenger=${challenger.length}");
    challenger.forEach((i){
      debugPrint("dog=${i.dog.name}");
    });

    return challenger;
  }

  /// コンテスト犬 リストを 直接生成する場合。
  static List<ContestDog> createChallenger(){
    /// 犬画像は、いらすとや を利用させていただきました。
    /// かわいいフリー素材集 いらすとや
    /// https://www.irasutoya.com/
    return [
      new ContestDog("ボーダーコリー", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_Border_Collie.png", false),
      new ContestDog("秋田犬", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_akitainu.png", false),
      new ContestDog("バセットハウンド", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_basset_hound.png", false),
      new ContestDog("ボストンテリア", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_boston_terrier.png", false),
      new ContestDog("ブルテリア", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_bull_terrier.png", false),
      new ContestDog("ダルメシアン", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_dalmatian.png", false),
      new ContestDog("シーズー", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_shih_tzu.png", false),
      new ContestDog("スピッツ", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_spitz.png", false),
      new ContestDog("土佐犬", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_tosaken.png", false),
      new ContestDog("柴犬", "https://cch-robo.github.io/DevFest-Shikoku-2018/images/dog_shibainu_brown.png", false),
    ];
  }

  /// コンテスト犬 リストから JSON文字列を取得する。
  static String getJsonString(List<ContestDog> challenger) {
    String jsonString = json.encode(challenger);
    print("jsonString=${jsonString}");
    return jsonString;
  }
}


/********** JSONモデル関連のクラス **********/

/// ドッグ JSON モデル
class Dog {
  String _name;
  String _imageUrl;
  Dog(this._name, this._imageUrl);
  String get name => _name;
  String get imageUrl => _imageUrl;

  Dog.fromJson(Map<String, dynamic> json) {
    _name = json["name"];
    _imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    return {"name":_name, "imageUrl":_imageUrl};
  }

  static List<Dog> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Dog.fromJson(json)).toList();
  }
}

/// コンテスト犬・アイテム JSON モデル （オブジェクトのネスト構造）
class ContestDog {
  Dog _dog;
  bool _like;

  ContestDog(String name, String imageUrl, this._like) : this._dog = new Dog(name, imageUrl);
  Dog get dog => _dog;
  bool get like => _like;

  ContestDog.fromJson(Map<String, dynamic> json) {
    _dog = new Dog.fromJson(json["dog"]);
    _like = json["like"];
  }

  Map<String, dynamic> toJson() {
    return {"dog":_dog, "like":_like};
  }

  static List<ContestDog> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ContestDog.fromJson(json)).toList();
  }
}
