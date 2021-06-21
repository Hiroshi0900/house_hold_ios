// import 'dart:js';

import 'package:flutter/material.dart';
// import './import_export/detail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/api/keyakiController.dart';
import '../common/api/detailData.dart';
// import '../common/model/keyaki.dart';

import 'package:provider/provider.dart';
import '../common/model/keyakiModel.dart';
import '../common/model/miscellaneousies.dart';

class ImportExport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('入出金'),
        ),
        body: FutureBuilder(
          // future: detail.getDetailData(),
          // future: miscellaneousExpenses.fetchMiscellaneous(), // 普通にデータをフェッチする場合
          // future: Provider.of<Miscellaneousies>(context, listen: false)
          future: Provider.of<Miscellaneousies>(context, listen: false)
              .fetchMiscellaneous(),
          // builder:
          //     (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              // まだ通信中
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('データが存在しません'),
              );
            }
            // return Consumer<Miscellaneousies>(
            return Consumer<Miscellaneousies>(
                builder: (cctx, data, child) => ListView.builder(
                      itemCount: data.miscellaneous.length,
                      itemBuilder: (lctx, index) {
                        return _buildListView(data.miscellaneous[index]);
                      },
                    ));
          },
        ));
  }

  Widget _buildListView(Map<String, List<Miscellaneous>> miscellaneous) {
    // Widget _buildListView(Map miscellaneous) {
    String day = '';
    List values = [];
    miscellaneous.forEach((key, value) {
      day = key;
      values = value;
    });

    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            height: 50,
            child: ListTile(
              title: Text(
                day,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            child: Column(
              children: values
                  .map((dynamic mis) => ListTile(
                        title: Text(mis.category),
                        subtitle: Text(mis.price + '円'),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
/*
  // 一覧表示
  // Widget _buildListView(Miscellaneous miscellaneous) {
  Widget _buildListView(dynamic miscellaneous) {
    print(miscellaneous.id);
    // return Card(
    //     child: ListTile(
    //   title: Text(miscellaneous.category),
    //   subtitle: Text(miscellaneous.price + '円'),
    // ));
  }
  */
}
