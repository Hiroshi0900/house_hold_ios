import 'package:flutter/material.dart';
import '../common/views/tile.dart';

import 'package:provider/provider.dart';
import '../common/model/summary.dart';

// fl chart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import '../common/util/indicator.dart';

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
