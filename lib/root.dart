import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './common/util/Constants.dart';

// ===== 各画面のWidgetをインポート ===== //
import 'routes/bank_route.dart';
import 'routes/home_route.dart';
import 'routes/import_export_route.dart';
import 'routes/input_route.dart';
import 'routes/wallet_route.dart';
// ================================== //

// 動的に変動するのでステートフルウィジェット
class RootWidget extends StatefulWidget {
  // コンストラクト
  RootWidget({Key key}) : super(key: key);
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  // 選択箇所のインデックス
  int _selectedIndex = 0;
  // ナビゲーションバーウィジェット
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];
  // アイコン
  static const _footerIcons = [
    Icons.home,
    Icons.import_export_rounded,
    Icons.create,
    Icons.money,
    Icons.account_balance_wallet_rounded
  ];
  // アイコン文字列
  static const _footerItemName = ['ホーム', '入出金', '入力', '家計簿', '口座'];

  // ルート
  var _routes = [
    Home(),
    ImportExport(),
    Input(),
    Bank(),
    Wallet(),
  ];

  @override
  void initState() {
    // 初期処理
    super.initState();
    // フッター要素の格納
    _bottomNavigationBarItems.add(_UpdateActiveState(_selectedIndex));
    for (var i = 1; i < _footerIcons.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }

  // インデックスのアイテムを活性にする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        _footerIcons[index],
        color: kActiveColor,
      ),
      label: _footerItemName[index],
    );
  }

  // インデックスのアイテムを非活性にする
  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        _footerIcons[index],
        color: kDeActiveColor,
      ),
      label: _footerItemName[index],
    );
  }

  // アイコンクリック処理
  void _onItemTap(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // BottomNavigationBarType.fixedを指定しないと3つまでしか出せない
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        // onTapはタップイベント
        onTap: _onItemTap,
        // 活性化の文字色
        selectedItemColor: kActiveColor,
        unselectedItemColor: kDeActiveColor,
      ),
    );
  }
}
