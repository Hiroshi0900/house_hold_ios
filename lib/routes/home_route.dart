import 'package:flutter/material.dart';
import '../common/views/tile.dart';

import 'package:provider/provider.dart';
import '../common/model/summary.dart';

// fl chart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import '../common/util/indicator.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ホーム'),
//       ),
//       // body: FutureBuilder(
//       //   future: Provider.of<Summary>(context, listen: false).fetchSummary(),
//       //   builder: (ctx, dataSnapshot) {
//       //     if (dataSnapshot.connectionState == ConnectionState.waiting) {
//       //       // まだ通信中
//       //       return Center(
//       //         child: CircularProgressIndicator(),
//       //       );
//       //     }
//       //     if (dataSnapshot.error != null) {
//       //       return Center(
//       //         child: Text('データが存在しません'),
//       //       );
//       //     }
//       //     return Column(); // TODO 開発中
//       //   },
//       // ),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     final summary = Provider.of<Summary>(context).fetchSummary();
//     return Scaffold(
//         appBar: AppBar(title: Text('ホーム')),
//         body: AspectRatio(
//           // return AspectRatio(
//           aspectRatio: 1.3,
//           child: Card(
//             color: Colors.white,
//             child: Row(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 18,
//                 ),
//                 Expanded(
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: PieChart(
//                       PieChartData(
//                           // クリックされた時
//                           pieTouchData:
//                               PieTouchData(touchCallback: (pieTouchResponse) {
//                             setState(() {
//                               final desiredTouch = pieTouchResponse.touchInput
//                                       is! PointerExitEvent &&
//                                   pieTouchResponse.touchInput
//                                       is! PointerUpEvent;
//                               if (desiredTouch &&
//                                   pieTouchResponse.touchedSection != null) {
//                                 touchedIndex = pieTouchResponse
//                                     .touchedSection.touchedSectionIndex;
//                               } else {
//                                 touchedIndex = -1;
//                               }
//                             });
//                           }),
//                           borderData: FlBorderData(
//                             show: false,
//                           ),
//                           sectionsSpace: 0,
//                           centerSpaceRadius: 40,
//                           sections: showingSections() // こいつがグラフ本体
//                           ),
//                     ),
//                   ),
//                 ),
//                 // Column( // 下の名称箇所
//                 //   // 全体
//                 //   mainAxisSize: MainAxisSize.max,
//                 //   mainAxisAlignment: MainAxisAlignment.end,
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: const <Widget>[
//                 //     Indicator(
//                 //       color: Color(0xff0293ee),
//                 //       text: 'First',
//                 //       isSquare: true,
//                 //     ),
//                 //     SizedBox(
//                 //       height: 4,
//                 //     ),
//                 //     Indicator(
//                 //       color: Color(0xfff8b250),
//                 //       text: 'Second',
//                 //       isSquare: true,
//                 //     ),
//                 //     SizedBox(
//                 //       height: 4,
//                 //     ),
//                 //     Indicator(
//                 //       color: Color(0xff845bef),
//                 //       text: 'Third',
//                 //       isSquare: true,
//                 //     ),
//                 //     SizedBox(
//                 //       height: 4,
//                 //     ),
//                 //     Indicator(
//                 //       color: Color(0xff13d38e),
//                 //       text: 'Fourth',
//                 //       isSquare: true,
//                 //     ),
//                 //     SizedBox(
//                 //       height: 18,
//                 //     ),
//                 //   ],
//                 // ),
//                 // const SizedBox(
//                 //   width: 28,
//                 // ),
//               ],
//             ),
//           ),
//         ));
//   }

//   // PieChartSectionDataはライブラリ指定のやつ
//   List<PieChartSectionData> showingSections() {
//     // 'List.generate(4, (i) {'はループを指す
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: const Color(0xff13d38e),
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }
class Home extends StatelessWidget {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('入出金'),
        ),
        body: FutureBuilder(
          future: Provider.of<Summary>(context, listen: false).fetchSummary(),
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
            return Consumer<Summary>(
                // return Card(
                builder: (cctx, data, child) => ListView(
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        Container(
                            color: Colors.orange[500],
                            child: ListTile(
                              title: Text(
                                data.summaryTotal.category,
                                // style: TextStyle(color: Colors.white),
                              ),
                              leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: 44,
                                      minWidth: 34,
                                      maxHeight: 64,
                                      maxWidth: 54),
                                  child: data.summaryTotal.icon),
                              subtitle: Text(
                                data.summaryTotal.price + '円',
                                // style: TextStyle(color: Colors.white),
                              ),
                            )),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  // クリックされた時
                                  pieTouchData: PieTouchData(
                                      touchCallback: (pieTouchResponse) {
                                    print(pieTouchResponse);
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 60,
                                  sections: showingSections(
                                      data.summaryData) // こいつがグラフ本体
                                  ),
                            ),
                          ),
                        ),
                        Column(
                            children: data.summaryData
                                .map((dynamic sum) => Container(
                                      decoration: BoxDecoration(
                                        // 枠線
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        // 角丸
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[500],
                                      ),
                                      // color: Colors.grey[500],
                                      child: ListTile(
                                        title: Text(
                                          sum.category,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        leading: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                minHeight: 44,
                                                minWidth: 34,
                                                maxHeight: 64,
                                                maxWidth: 54),
                                            child: sum.icon),
                                        subtitle: Text(
                                          sum.price + '円',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ))
                                .toList())
                      ],
                    ));
            // color: Colors.white,
            // child: Row(children: <Widget>[
            //   // const SizedBox(
            //   //   height: 18,
            //   // ),
            //   Column(
            //     children: data.summaryData.map(
            //         // (dynamic mis) => Indicator(
            //         //   color: Color(0xff0293ee),
            //         //   text: 'First',
            //         //   isSquare: true,
            //         // ),
            //         (dynamic mis) => Text(
            //             // title: Text(mis.category),
            //             'test'
            //             // subtitle: Text(mis.price + '円'),
            //             )).toList(),
            //   ),
            // children: data.summaryData
            //     .map(
            //         // (dynamic mis) => Indicator(
            //         //   color: Color(0xff0293ee),
            //         //   text: 'First',
            //         //   isSquare: true,
            //         // ),
            //         (dynamic mis) => ListTile(
            //               title: Text(mis.category),
            //               // 'test'
            //               subtitle: Text(mis.price + '円'),
            //             ))
            //     .toList(),
            // Expanded(
            //   child: AspectRatio(
            //     aspectRatio: 1,
            //     child: PieChart(
            //       PieChartData(
            //           // クリックされた時
            //           pieTouchData: PieTouchData(
            //               touchCallback: (pieTouchResponse) {
            //             print(pieTouchResponse);
            //           }),
            //           borderData: FlBorderData(
            //             show: false,
            //           ),
            //           sectionsSpace: 0,
            //           centerSpaceRadius: 60,
            //           sections: showingSections(
            //               data.summaryData) // こいつがグラフ本体
            //           ),
            //     ),
            //   ),
            // ),
          },
        ));
  }

  List<PieChartSectionData> showingSections(List<Sum> data) {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
          color: data[i].color,
          value: double.parse(
              data[i].price.replaceFirst('¥', '').replaceAll(',', '')),
          title: data[i].category,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)));
    });
  }
}
