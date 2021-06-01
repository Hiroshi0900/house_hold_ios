import 'package:flutter/services.dart';
// import '../model/keyaki.dart';
import 'dart:convert';

class DetailData {
  Future<List<dynamic>> getDetailData() async {
    // 戻り値を生成
    List<dynamic> list = [];

    String _data = "";
    String loadData = await rootBundle.loadString("assets/chelsea.json");
    final jsonResponse = json.decode(loadData);
    // jsonResponse.forEach((key, value) => _data = _data + '$key: $value \x0A');
    // print(jsonResponse['players'][0]);

    // リターン
    return jsonResponse['players'];
  }
}
