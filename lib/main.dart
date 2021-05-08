import 'package:flutter/material.dart';
import 'package:house_hold_app/common/views/header.dart';
import './common/views/header.dart';
import './common/views/footer.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debugの表示をオフにする
      home: Scaffold(
        appBar: Header(),
        body: Center(child: Text('devlop!')),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}
