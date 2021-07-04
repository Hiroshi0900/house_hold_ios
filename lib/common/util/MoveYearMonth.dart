// import 'package:flutter/material.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';

// class MoveYearMonth extends StatefulWidget {
//   // const MoveYearMonth({ Key? key }) : super(key: key);

//   @override
//   _MoveYearMonthState createState() => _MoveYearMonthState();
// }

// class _MoveYearMonthState extends State<MoveYearMonth> {
//   @override
//   // Widget build(BuildContext context) {
//   //   return Container(
      
//   //   );
//   // }
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
//     this.setState(() {
//       this.date = selectedDate;
//       this._changeTarget(selectedDate.year.toString() +
//           selectedDate.month.toString().padLeft(2, '0'));
//     });
//   }
// }