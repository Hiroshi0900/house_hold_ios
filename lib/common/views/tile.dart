import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../routes/import_export/detail.dart';

class Tile extends StatelessWidget {
  // 引数でうけとる
  IconData icon;
  String username;
  String message;
  // コンストラクト
  Tile({
    IconData icon,
    String username,
    String message,
  }) {
    this.icon = icon;
    this.username = username;
    this.message = message;
  }
  // 画面遷移イベント
  // void goDetail(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: ()=> Detail()))
  // }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(this.icon),
            backgroundColor: Colors.pink,
          ),
          title: Text(this.username),
          subtitle: Text(this.message),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(
                          detailName: this.username,
                        )))
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.blue,
          icon: Icons.flash_off,
          onTap: () => {},
        ),
        IconSlideAction(
          color: Colors.indigo,
          icon: Icons.volume_off,
          onTap: () => {},
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.black45,
          iconWidget: Text(
            "非表示",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => {},
        ),
        IconSlideAction(
          color: Colors.red,
          iconWidget: Text(
            "非表示",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => {},
        ),
      ],
    );
  }
}
