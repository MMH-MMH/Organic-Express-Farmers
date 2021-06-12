import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Leaderboard extends StatefulWidget {
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Map<String, dynamic>> list = [
    {"name": "Farmer 1", "points": "500"},
    {"name": "Farmer 2", "points": "490"},
    {"name": "Farmer 3", "points": "472"},
    {"name": "Farmer 4", "points": "430"}
  ];

  TextStyle thead = TextStyle(color: Colors.teal, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Table(
                    defaultColumnWidth: FixedColumnWidth(
                        MediaQuery.of(context).size.width * 0.4),
                    border: TableBorder.all(
                        color: Colors.grey, style: BorderStyle.solid, width: 1),
                    children: [
                      TableRow(
                        children: [
                          Column(
                            children: [
                              Text(AppLocalizations.of(context).name,
                                  style: thead)
                            ],
                          ),
                          Column(
                            children: [
                              Text(AppLocalizations.of(context).points,
                                  style: thead)
                            ],
                          )
                        ],
                      ),
                      TableRow(children: [
                        Column(
                          children: [Text("Farmer 1")],
                        ),
                        Column(
                          children: [Text("500")],
                        )
                      ]),
                      TableRow(children: [
                        Column(
                          children: [Text("Farmer 2")],
                        ),
                        Column(
                          children: [Text("487")],
                        )
                      ]),
                      TableRow(children: [
                        Column(
                          children: [Text("Farmer 3")],
                        ),
                        Column(
                          children: [Text("445")],
                        )
                      ]),
                      TableRow(children: [
                        Column(
                          children: [Text("Farmer 4")],
                        ),
                        Column(
                          children: [Text("421")],
                        )
                      ]),
                      TableRow(children: [
                        Column(
                          children: [Text("Farmer 5")],
                        ),
                        Column(
                          children: [Text("401")],
                        )
                      ]),
                    ],
                  ),
                ],
              ),
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   children: list.map<Widget>((product) {
              //     return TableR
              //   }).toList(),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
