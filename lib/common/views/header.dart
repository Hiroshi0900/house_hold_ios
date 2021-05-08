import 'package:flutter/material.dart';

// TODO PreferredSizeWidgetとは？
class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  Widget build(BuildContext context) {
    return AppBar(
      // AppBarはleading,title,actionsをプロパティにもつ
      leading: Padding(
        child: Icon(Icons.settings),
        padding: const EdgeInsets.all(8.0),
      ),
      title: Text('ホーム'),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.add),
        ),
      ],
      // レイアウト設定
      backgroundColor: Colors.black87,
      centerTitle: true, // titleを中央に寄せる
      elevation: 0.0,
    );
  }
}
