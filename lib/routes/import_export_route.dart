import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/api/keyakiController.dart';
import '../common/api/detailData.dart';
// import '../common/model/keyaki.dart';

import 'package:provider/provider.dart';
import '../common/model/keyakiModel.dart';
import '../common/model/miscellaneousies.dart';
import '../common/util/DateAssistant.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ImportExport extends StatefulWidget {
  @override
  _ImportExportState createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  String _nowDateString = '';
  DateTime date = DateTime.now();
  Future<void> _future;
  void initState() {
    _future = asyncGetHomeData();
    super.initState();
  }

  void _changeTarget(String target) {
    setState(() {
      _nowDateString = target;
      asyncGetHomeData();
    });
  }

  Future<void> asyncGetHomeData() async {
    await Provider.of<Miscellaneousies>(context, listen: false)
        .fetchMiscellaneous(_nowDateString);
  }

  @override
  Widget build(BuildContext context) {
    DateAssistant dateClass = new DateAssistant();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '入出金' +
                '：' +
                date.year.toString() +
                '/' +
                date.month.toString().padLeft(2, '0'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.business_rounded),
              onPressed: () => setState(() {
                selectDate(context);
              }),
            ),
          ],
        ),
        body: FutureBuilder(
            future: _future,
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
            }));
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
            color: Colors.green[200],
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

  selectDate(BuildContext context) async {
    // 1年前から1年後の範囲でカレンダーから日付を選択します。
    var selectedDate = await showMonthPicker(
      context: context,
      initialDate: this.date,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    // 選択がキャンセルされた場合はNULL
    if (selectedDate == null) return;

    // 選択されて日付で更新
    this.setState(() {
      this.date = selectedDate;
      this._changeTarget(selectedDate.year.toString() +
          selectedDate.month.toString().padLeft(2, '0'));
    });
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
