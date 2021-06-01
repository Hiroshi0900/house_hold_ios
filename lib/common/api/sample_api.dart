import 'package:flutter/material.dart';

// API検証
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// import '../model/user.dart';

class SampleApi extends StatefulWidget {
  @override
  _SampleApiState createState() => _SampleApiState();
}

class _SampleApiState extends State<SampleApi> {
  Map data;
  List userData;
  // 非同期データ取得
  Future getData() async {
    try {
      http.Response response =
          await http.get("https://reqres.in/api/users?page=2");
      data = json.decode(response.body); //json->Mapオブジェクトに格納
      print(data['data'][0]['email']);
      // userData = data;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // return Text(data['data'] != null ? data['data'][0]['email'] : null);
  }
}
