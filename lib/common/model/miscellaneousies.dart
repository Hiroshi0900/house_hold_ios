import 'dart:convert';
import 'package:flutter/services.dart';
import '../api/networkhelper.dart';

import 'package:flutter/material.dart';

class Miscellaneous {
  // フィールドを生成
  int id;
  String day;
  String category;
  String price;

  // コンストラクタ
  Miscellaneous({this.id, this.day, this.category, this.price});
}

class Miscellaneousies with ChangeNotifier {
  @override
  // void initState() {
  //   getAwsJson();
  // }

  List<Miscellaneous> _miscellData = [];
  List<Map<String, List<Miscellaneous>>> _miscellaneousies = [];
  List<Map<String, List<Miscellaneous>>> get miscellaneous {
    return [..._miscellaneousies];
  }

  Map<String, String> _awsResponse = {};
  Future<void> getAwsJson() async {
    String awsHost = await rootBundle.loadString('json/aws.json');
    Map response = json.decode(awsHost);
    // 階層が深くなったらループした方が良い
    response.forEach((key, value) {
      _awsResponse['host'] = value[0]['host'];
      _awsResponse['gss'] = value[0]['detail'];
    });
  }

  Future<void> fetchMiscellaneous(String nowDateString) async {
    _miscellaneousies = []; // 初期化しないと増えてしまう
    await getAwsJson();

    // const url =
    //     'https://v6h26y4nyj.execute-api.ap-northeast-1.amazonaws.com/dev/api/gss';
    // final response = await http.get(url);
    String url = _awsResponse['host'] + _awsResponse['gss'];
    if (nowDateString != '') url = url + '/?ym=' + nowDateString;
    NetworkHelper networkHelper = NetworkHelper(url: url);
    print(url);
    final response = await networkHelper.getData();

    int idNumber = 1;
    response.forEach((var day, var valueData) {
      // print('$key : $value');
      for (List detail in valueData[1]) {
        Miscellaneous rowData = Miscellaneous(
          id: idNumber++,
          day: detail[0],
          category: detail[1],
          price: detail[2],
        );
        _miscellData.add(rowData);
      }
      _miscellaneousies.add({day: _miscellData});
      _miscellData = [];
      // break;
    });
    notifyListeners();
  }
}
