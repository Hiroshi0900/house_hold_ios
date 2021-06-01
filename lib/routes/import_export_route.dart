import 'package:flutter/material.dart';
// import './import_export/detail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/api/keyakiController.dart';
import '../common/api/detailData.dart';
// import '../common/model/keyaki.dart';

import 'package:provider/provider.dart';
// import '../common/model/keyakiModel.dart';

class ImportExport extends StatelessWidget {
  DetailData detail = new DetailData();
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('ImportExport'),
    //   ),
    //   body: Center(
    //     child: Text('ImportExport'),
    //   ),
    //   // body: Center(child: Detail()),
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: FutureBuilder(
          future: detail.getDetailData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              // return Text("データを取得中");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data);
            if (snapshot.data.length == 0) {
              return Text("データが存在しませんでした。");
            }

            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  _buildListView(snapshot.data[index]),
            );
          },
        ));
  }

  // 一覧表示
  Widget _buildListView(dynamic data) {
    return Card(
        child: ListTile(
      title: Text(data['player_name']),
      subtitle: Text(data['player_name']),
    ));
  }
}
