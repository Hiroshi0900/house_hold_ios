import 'dart:convert';
import 'package:flutter/services.dart';
import '../api/networkhelper.dart';

import 'package:flutter/material.dart';

// class Summary {
//   // フィールドを生成
//   int id;
//   String day;
//   String category;
//   String price;

//   // コンストラクタ
//   Miscellaneous({this.id, this.day, this.category, this.price});
// }

class Summary with ChangeNotifier {
  @override
  // void initState() {
  //   getAwsJson();
  // }
  // 返却値
  List _summaryData = [];

  // List<Miscellaneous> _miscellData = [];
  // List<Map<String, List<Miscellaneous>>> _miscellaneousies = [];
  // List<Map<String, List<Miscellaneous>>> get miscellaneous {
  //   return [..._miscellaneousies];
  // }

  Map<String, String> _awsResponse = {};
  Future<void> getAwsJson() async {
    String awsHost = await rootBundle.loadString('json/aws.json');
    Map response = json.decode(awsHost);
    // 階層が深くなったらループした方が良い
    response.forEach((key, value) {
      _awsResponse['host'] = value[0]['host'];
      _awsResponse['summary'] = value[0]['summary'];
    });
  }

  Future<void> fetchMiscellaneous() async {
    _summaryData = []; // 初期化しないと増えてしまう
    await getAwsJson();

    // const url =
    //     'https://v6h26y4nyj.execute-api.ap-northeast-1.amazonaws.com/dev/api/gss';
    // final response = await http.get(url);
    String url = _awsResponse['host'] + _awsResponse['summary'];
    NetworkHelper networkHelper = NetworkHelper(url: url);

    final response = await networkHelper.getData();

    int idNumber = 1;
    response.forEach((var day, var valueData) {
      // print('$key : $value');
      for (List detail in valueData[1]) {}
      // break;
    });
    notifyListeners();
  }
}
