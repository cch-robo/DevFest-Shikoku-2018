import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:devfest_shikoku_2018/src/json_model.dart';


/// コンテスト犬 リストを作成するサービス
class ApiService {

  /// コンテスト犬 リストを JSONから取得する。（本来はネットワーク越しに取得）
  static Future<List<ContestDog>> getJsonModels() async {
    /// 犬画像は、いらすとや を利用させていただきました。
    /// かわいいフリー素材集 いらすとや
    /// https://www.irasutoya.com/
    String jsonList = ''
        +'['
        + '{"dog":{"name":"ボーダーコリー","imageUrl":"http://cch-lab.com/reference/images/dog_Border_Collie.png"},"like":false},'
        + '{"dog":{"name":"秋田犬","imageUrl":"http://cch-lab.com/reference/images/dog_akitainu.png"},"like":false},'
        + '{"dog":{"name":"バセットハウンド","imageUrl":"http://cch-lab.com/reference/images/dog_basset_hound.png"},"like":false},'
        + '{"dog":{"name":"ボストンテリア","imageUrl":"http://cch-lab.com/reference/images/dog_boston_terrier.png"},"like":false},'
        + '{"dog":{"name":"ブルテリア","imageUrl":"http://cch-lab.com/reference/images/dog_bull_terrier.png"},"like":false},'
        + '{"dog":{"name":"ダルメシアン","imageUrl":"http://cch-lab.com/reference/images/dog_dalmatian.png"},"like":false},'
        + '{"dog":{"name":"シーズー","imageUrl":"http://cch-lab.com/reference/images/dog_shih_tzu.png"},"like":false},'
        + '{"dog":{"name":"スピッツ","imageUrl":"http://cch-lab.com/reference/images/dog_spitz.png"},"like":false},'
        + '{"dog":{"name":"土佐犬","imageUrl":"http://cch-lab.com/reference/images/dog_tosaken.png"},"like":false},'
        + '{"dog":{"name":"柴犬","imageUrl":"http://cch-lab.com/reference/images/dog_shibainu_brown.png"},"like":false}'
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
      new ContestDog("ボーダーコリー", "http://cch-lab.com/reference/images/dog_Border_Collie.png", false),
      new ContestDog("秋田犬", "http://cch-lab.com/reference/images/dog_akitainu.png", false),
      new ContestDog("バセットハウンド", "http://cch-lab.com/reference/images/dog_basset_hound.png", false),
      new ContestDog("ボストンテリア", "http://cch-lab.com/reference/images/dog_boston_terrier.png", false),
      new ContestDog("ブルテリア", "http://cch-lab.com/reference/images/dog_bull_terrier.png", false),
      new ContestDog("ダルメシアン", "http://cch-lab.com/reference/images/dog_dalmatian.png", false),
      new ContestDog("シーズー", "http://cch-lab.com/reference/images/dog_shih_tzu.png", false),
      new ContestDog("スピッツ", "http://cch-lab.com/reference/images/dog_spitz.png", false),
      new ContestDog("土佐犬", "http://cch-lab.com/reference/images/dog_tosaken.png", false),
      new ContestDog("柴犬", "http://cch-lab.com/reference/images/dog_shibainu_brown.png", false),
    ];
  }

  /// コンテスト犬 リストから JSON文字列を取得する。
  static String getJsonString(List<ContestDog> challenger) {
    String jsonString = json.encode(challenger);
    print("jsonString=${jsonString}");
    return jsonString;
  }
}
