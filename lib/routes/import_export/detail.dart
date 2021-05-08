import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  // 引数で受け取る
  String detailName;
  Detail({String detailName}) {
    this.detailName = detailName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.detailName),
        // ヘッダーバー追加
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(icon: Icon(Icons.search), onPressed: () => {}),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(icon: Icon(Icons.call), onPressed: () => {}),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(icon: Icon(Icons.dehaze), onPressed: () => {}),
          ),
        ],
      ),
      body: Center(
        child: Text("sdfghjkjnbnjk"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => {}),
            IconButton(icon: Icon(Icons.camera_alt), onPressed: () => {}),
            IconButton(icon: Icon(Icons.photo), onPressed: () => {}),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aa',
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.mic), onPressed: () => {})
          ],
        ),
      ),
      backgroundColor: Colors.cyan,
    );
  }
}
