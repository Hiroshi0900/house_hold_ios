import 'dart:convert';
import 'package:flutter/services.dart';
import '../api/networkhelper.dart';
import '../util/Constants.dart';
import '../util/StrictAssistant.dart';

import 'package:flutter/material.dart';

class Sum {
  // フィールドを生成
  int id;
  String category;
  String price;
  Color color;
  Icon icon;

  // コンストラクタ
  Sum({this.id, this.category, this.price, this.color, this.icon});
}

class Summary with ChangeNotifier {
  @override
  // void initState() {
  //   getAwsJson();
  // }
  // 返却値
  List<Sum> _summaryData = [];
  List<Sum> get summaryData {
    return [..._summaryData];
  }

  Sum _summaryTotal;
  Sum get summaryTotal {
    return _summaryTotal;
  }

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

  Future<void> fetchSummary(String nowDateString) async {
    print('引数は' + nowDateString);
    _summaryData = []; // 初期化しないと増えてしまう
    await getAwsJson();

    // const url =
    //     'https://v6h26y4nyj.execute-api.ap-northeast-1.amazonaws.com/dev/api/gss';
    // final response = await http.get(url);
    String url = _awsResponse['host'] + _awsResponse['summary'];
    if (nowDateString != '') url = url + '/?ym=' + nowDateString;
    NetworkHelper networkHelper = NetworkHelper(url: url);

    final response = await networkHelper.getData();
    if (response == null) {
      return;
    }
    // final r = await rootBundle.loadString('json/sum_develop.json'); //開発用
    // final response = json.decode(r);

    int idNumber = 1;
    int index = 0;
    response.forEach((var category, var price) {
      if (index != 0) {
        Sum rowData = Sum(
          id: idNumber++,
          category: category,
          price: price,
          color: Color(StrictAssistant.getColorFromHex(kColorList[index++])),
          icon: kIconList[index],
        );
        _summaryData.add(rowData);
      } else {
        _summaryTotal = Sum(
          id: idNumber++,
          category: category,
          price: price,
          color: Color(StrictAssistant.getColorFromHex(kColorList[index++])),
          icon: kIconList[index],
        );
      }
    });
    notifyListeners();
  }
}
