import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './root.dart';
// import './common/views/header.dart';
// import './common/views/footer.dart';
import './common/model/miscellaneousies.dart';
import './common/model/summary.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false, // Debugの表示をオフにする
    //   home: RootWidget(),
    //   title: 'Demo',
    //   theme: ThemeData(primaryColor: Colors.blueGrey[700]),
    // );
    // return ChangeNotifierProvider(
    //     // Providerを使用
    //     create: (ctx) => Miscellaneousies(),
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false, // Debugの表示をオフにする
    //       home: RootWidget(),
    //       title: 'Demo',
    //       theme: ThemeData(primaryColor: Colors.blueGrey[700]),
    //     ));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Miscellaneousies>(
            create: (context) => Miscellaneousies(),
          ),
          ChangeNotifierProvider<Summary>(
            create: (context) => Summary(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ja'),
          ],
          debugShowCheckedModeBanner: false, // Debugの表示をオフにする
          home: RootWidget(),
          title: 'Demo',
          theme: ThemeData(primaryColor: Colors.blueGrey[700]),
        ));
    // Providerを使用
    // create: (ctx) => Miscellaneousies(),
    // child: MaterialApp(
    //   debugShowCheckedModeBanner: false, // Debugの表示をオフにする
    //   home: RootWidget(),
    //   title: 'Demo',
    //   theme: ThemeData(primaryColor: Colors.blueGrey[700]),
    // ));
  }
}
