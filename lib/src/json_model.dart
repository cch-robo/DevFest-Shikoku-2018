import 'dart:core';


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
