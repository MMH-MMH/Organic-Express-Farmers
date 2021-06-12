import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOrders extends StatefulWidget {
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Map<String, dynamic>> order = [
    {"name": "S1", "pending": 0, "done": 0},
    {"name": "S2", "pending": 0, "done": 0},
    {"name": "S3", "pending": 0, "done": 0},
    {"name": "BF1", "pending": 0, "done": 0},
    {"name": "BF2", "pending": 0, "done": 0}
  ];

  TextStyle tableHeads = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  getDataRow(val) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(val["name"].toString())),
        DataCell(Text(val["pending"].toString())),
        DataCell(Text(val["done"].toString())),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context).myOrders,
                  style: TextStyle(color: Colors.teal, fontSize: 20)),
              SizedBox(height: 10),
              DataTable(
                columns: [
                  DataColumn(
                      label: Text(AppLocalizations.of(context).item,
                          style: tableHeads)),
                  DataColumn(
                      label: Text(AppLocalizations.of(context).pending,
                          style: tableHeads)),
                  DataColumn(
                      label: Text(AppLocalizations.of(context).done,
                          style: tableHeads)),
                ],
                rows: List.generate(
                  order.length,
                  (index) => getDataRow(order[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*



*/