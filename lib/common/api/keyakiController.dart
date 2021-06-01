import 'package:flutter/services.dart';
import '../model/keyaki.dart';

class KeyakiAPI {
  Future<List<Keyaki>> getCsvData() async {
    // 戻り値を生成
    List<Keyaki> list = [];

    // csvデータを全て読み込む
    String csv = await rootBundle.loadString("assets/keyaki.csv");

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

      list.add(rowData);
    }

    // リターン
    return list;
  }
}
