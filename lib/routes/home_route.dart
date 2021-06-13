import 'package:flutter/material.dart';
import '../common/views/tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      // body: ListView(
      //   // リストビューを追加
      //   padding: const EdgeInsets.all(8.0),
      //   children: <Widget>[
      //     Tile(
      //       icon: Icons.accessibility_new,
      //       username: 'test',
      //       message: '1234567890-',
      //     ),
      //   ],
      // ),
      body: Container(),
    );
  }
}
