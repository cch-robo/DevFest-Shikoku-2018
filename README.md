# DevFest Shikoku 2018 Flutter コードラボ

[DevFest Shikoku 2018](https://gdgshikoku.connpass.com/event/98292/) のコードラボ資料です。
この README がセッション資料となります。

この資料は、以下のコードラボを下地にしています。

* [Write Your First Flutter App, part 1](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/index.html?index=..%2F..%2Findex#0)


* [Write Your First Flutter App, part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/index.html?index=..%2F..%2Findex#0)

* 上記コードラボの全ソース
[main.dart](https://gist.githubusercontent.com/Sfshaza/a95ff8ed0473073197d28437c8d68492/raw/6fb529524047c8c093cb6212dfb66635202ba272/main.dart)



## 注意事項

gitクローンされた場合は、ご自身のローカル環境に合わせて dart SDK へのパスなどを設定してください。

**【Android Studio での Dart SDK パス設定方法】**  
`Preferences > Languages & Frameworks > Dart` で Dart言語の設定画面を開いてください。  
**[v]Enable Dart support for the project `プロジェクト名`** にチェックを入れてから、  
**Dart SDK path:** に、 **`Flutter SDK インストール先`/flutter/bin/cache/dart-sdk** を設定すればOKです。

<br/>


### Flutter 2 環境でのビルド対応改訂　(2021/03/07 追加)

- Flutter 2 リリースに伴い、2021/03時点の Flutter環境でビルドできるよう改訂を行いました。
  - [Android ビルド設定](https://github.com/cch-robo/DevFest-Shikoku-2018/tree/master/android) を改訂
  - [iOS ビルド設定](https://github.com/cch-robo/DevFest-Shikoku-2018/tree/master/ios) を改訂
  - [Flutter for Web ビルド設定](https://github.com/cch-robo/DevFest-Shikoku-2018/tree/master/web) を追加
  - [DartPad](https://dartpad.dev/flutter) で実行できるコードを [dartpad/main.dart](https://github.com/cch-robo/DevFest-Shikoku-2018/blob/master/dartpad/main.dart) に追加しました。  
  このコードを [DartPad](https://dartpad.dev/flutter) に貼り付けることで、手軽にアプリの動作が確認できます。  
  *内容的には、このコードラボ全ファイルのクラスを一つの `main.dart` ファイルにまとめているだけです。*