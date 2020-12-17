import 'package:flutter/material.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/out/caugth.dart';
import 'package:froliccricketscore/modules/out/runOutScreen.dart';

class OutScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  List<Players> allPlayerList = List<Players>();
  OutScreen({this.matchDataForApp, this.allPlayerList});
  @override
  _OutScreenState createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Out How?",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 21),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.grey.shade200,
        child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 0.69,
            children: List.generate(16, (index) {
              return InkWell(
                  splashColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                        // color: Colors.blue,
                        child: Center(
                            child: Text(
                      list[index]["name"],
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 15),
                    ))),
                  ),
                  onTap: () {
                    _gridNavigation(index);
                  });
            })),
      ),
    );
  }

  _gridNavigation(int indexValue) {
    if (indexValue == 0) {
      print("0");
    } else if (indexValue == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CaugthScreen(
                    matchDataForApp: widget.matchDataForApp,
                    playerList: widget.allPlayerList,
                  )));
    } else if (indexValue == 5) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RunOutScreen()));
    }
  }

  List<Map<String, dynamic>> list = [
    {"name": "Bowled"},
    {"name": "Caugth"},
    {"name": "Caugth Behind"},
    {"name": "Caugth & Bowled"},
    {"name": "Stumped"},
    {"name": "Run Out"},
    {"name": "LBW"},
    {"name": "Hit Wicket"},
    {"name": "Retried Hurt"},
    {"name": "Retried Out"},
    {"name": "Action Out (Mankanded)"},
    {"name": "Absent"},
    {"name": "Hit the ball twice"},
    {"name": "Obstr. the field"},
    {"name": "Timed Out"},
    {"name": "Tried"},
  ];
}
