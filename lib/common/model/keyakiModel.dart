import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Keyaki {
  // フィールドを生成
  int id;
  String name;
  String birthday;
  String place;
  String team;

  // コンストラクタ
  Keyaki({this.id, this.name, this.birthday, this.place, this.team});
}

class KeyakiModel with ChangeNotifier {
  List<Keyaki> _keyakis = [];

  List<Keyaki> get keyakis {
    return [..._keyakis];
  }

  Future<void> fetchKeyaki() async {
    // const url = '...';
    // final response = await http.get(url);
    // final decodedData = json.decode(response.body) as Map<String, dynamic>;
    // if (decodedData == null) {
    //   return;
    // }
    // List<Book> responseBooks = [];
    // // パース
    // _books = responseBooks;
    List<Keyaki> list = [];
    // csvデータを全て読み込む
    String csv = await rootBundle.loadString("assets/keyaki.csv");
    print(csv);
    // csvデータを1行ずつ処理する
    List data = csv.replaceAll('\\n', '\n').split('\n');
    for (String line in data) {
      // カンマ区切りで各列のデータを配列に格納
      List rows = line.split(','); // split by comma

      // csvデータを生成
      Keyaki rowData = Keyaki(
          id: int.parse(rows[0]),
          name: rows[1],
          birthday: rows[2],
          place: rows[3],
          team: rows[4]);

      // csvデータをリストに格納

      _keyakis.add(rowData);
    }
    notifyListeners();
  }
}
