import 'package:flutter/material.dart';
import './root.dart';
// import './common/views/header.dart';
// import './common/views/footer.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debugの表示をオフにする
      home: RootWidget(),
      title: 'Demo',
      theme: ThemeData(primaryColor: Colors.blueGrey[700]),
    );
  }
}
