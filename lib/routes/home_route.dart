import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/model/summary.dart';
import '../common/util/DateAssistant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Home extends StatefulWidget {
  // const Home({ Key? key }) : super(key: key);
  Home({this.date, this.nowDateString});
  final DateTime date;
  String nowDateString;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DateAssistant dateAssistant = new DateAssistant();
  int touchedIndex = -1;
  DateTime date = DateTime.now();
  String _nowDateString = '';

  Future<void> _future;

  @override
  void initState() {
    _future = asyncGetHomeData();
    super.initState();
  }

  void _changeTarget(String target) {
    setState(() {
      _nowDateString = target;
      // dateAssistant.updateNowDate(target);
      asyncGetHomeData();
    });
  }

  Future<void> asyncGetHomeData() async {
    await Provider.of<Summary>(context, listen: false)
        .fetchSummary(_nowDateString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ホーム' +
                '：' +
                date.year.toString() +
                '/' +
                date.month.toString().padLeft(2, '0'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.business_rounded),
              onPressed: () => setState(() {
                selectDate(context);
              }),
            ),
          ],
        ),
        body: FutureBuilder(
          future: _future,
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
                        GestureDetector(
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

  selectDate(BuildContext context) async {
    var selectedDate = await showMonthPicker(
      context: context,
      initialDate: this.date,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    // 選択がキャンセルされた場合はNULL
    if (selectedDate == null) return;

    // 選択されて日付で更新
    this.setState(() {
      this.date = selectedDate;
      this._changeTarget(selectedDate.year.toString() +
          selectedDate.month.toString().padLeft(2, '0'));
    });
  }
}

// class Home extends StatelessWidget {
//   int touchedIndex = -1;
//   DateTime date = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('ホーム'),
//         ),
//         body: FutureBuilder(
//           future: Provider.of<Summary>(context, listen: false).fetchSummary(),
//           builder: (ctx, dataSnapshot) {
//             if (dataSnapshot.connectionState == ConnectionState.waiting) {
//               // まだ通信中
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (dataSnapshot.error != null) {
//               return Center(
//                 child: Text('データが存在しません'),
//               );
//             }
//             return Consumer<Summary>(
//                 // return Card(
//                 builder: (cctx, data, child) => ListView(
//                       padding: const EdgeInsets.all(8),
//                       children: <Widget>[
//                         Container(
//                             color: Colors.orange[500],
//                             child: ListTile(
//                               title: Text(
//                                 data.summaryTotal.category,
//                                 // style: TextStyle(color: Colors.white),
//                               ),
//                               leading: ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                       minHeight: 44,
//                                       minWidth: 34,
//                                       maxHeight: 64,
//                                       maxWidth: 54),
//                                   child: data.summaryTotal.icon),
//                               subtitle: Text(
//                                 data.summaryTotal.price + '円',
//                                 // style: TextStyle(color: Colors.white),
//                               ),
//                             )),
//                         GestureDetector(
//                           child: AspectRatio(
//                             aspectRatio: 1,
//                             child: PieChart(
//                               PieChartData(
//                                   // クリックされた時
//                                   pieTouchData: PieTouchData(
//                                       touchCallback: (pieTouchResponse) {
//                                     print(pieTouchResponse);
//                                   }),
//                                   borderData: FlBorderData(
//                                     show: false,
//                                   ),
//                                   sectionsSpace: 0,
//                                   centerSpaceRadius: 60,
//                                   sections: showingSections(
//                                       data.summaryData) // こいつがグラフ本体
//                                   ),
//                             ),
//                           ),
//                         ),
//                         Column(
//                             children: data.summaryData
//                                 .map((dynamic sum) => Container(
//                                       decoration: BoxDecoration(
//                                         // 枠線
//                                         border: Border.all(
//                                             color: Colors.white, width: 2),
//                                         // 角丸
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Colors.grey[500],
//                                       ),
//                                       // color: Colors.grey[500],
//                                       child: ListTile(
//                                         title: Text(
//                                           sum.category,
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                         leading: ConstrainedBox(
//                                             constraints: BoxConstraints(
//                                                 minHeight: 44,
//                                                 minWidth: 34,
//                                                 maxHeight: 64,
//                                                 maxWidth: 54),
//                                             child: sum.icon),
//                                         subtitle: Text(
//                                           sum.price + '円',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                     ))
//                                 .toList())
//                       ],
//                     ));
//           },
//         ));
//   }

//   List<PieChartSectionData> showingSections(List<Sum> data) {
//     return List.generate(data.length, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;

//       return PieChartSectionData(
//           color: data[i].color,
//           value: double.parse(
//               data[i].price.replaceFirst('¥', '').replaceAll(',', '')),
//           title: data[i].category,
//           radius: radius,
//           titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: const Color(0xffffffff)));
//     });
//   }

//   selectDate(BuildContext context) async {
//     // 1年前から1年後の範囲でカレンダーから日付を選択します。
//     var selectedDate = await showMonthPicker(
//       context: context,
//       initialDate: this.date,
//       firstDate: DateTime(DateTime.now().year - 1),
//       lastDate: DateTime(DateTime.now().year + 1),
//     );

//     // 選択がキャンセルされた場合はNULL
//     if (selectedDate == null) return;

//     // 選択されて日付で更新
//     // this.setState(() {
//     //   this.date = selectedDate;
//     // });
//   }
// }
