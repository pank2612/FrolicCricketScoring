import 'package:flutter/material.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';

class MatchCompleteScreen extends StatefulWidget {
  int scoreOfFirstInnings;
  int scoreOfSecondInnings;
  int wicketsOfFirstInnings;
  int wicketsOfSecondInnings;
  String oversOfFirstInnings;
  String oversOfSecondInnings;
  MatchDataForApp matchDataForApp;
  String howWonTheMatch;
  MatchCompleteScreen(
      {this.oversOfFirstInnings,
      this.oversOfSecondInnings,
      this.matchDataForApp,
      this.howWonTheMatch,
      this.scoreOfFirstInnings,
      this.scoreOfSecondInnings,
      this.wicketsOfFirstInnings,
      this.wicketsOfSecondInnings});
  @override
  _MatchCompleteScreenState createState() => _MatchCompleteScreenState();
}

class _MatchCompleteScreenState extends State<MatchCompleteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("how team won the match ${widget.howWonTheMatch} ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Match Complete",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 21),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//              Padding(
//                padding: const EdgeInsets.only(bottom: 5),
//                child: Text(
//                  "RCB won by 2 runs",
//                  style: TextStyle(
//                      color: Colors.grey.shade700,
//                      fontSize: 20,
//                      fontWeight: FontWeight.w600),
//                ),
//              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Name",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        "R",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        "W",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        "O",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        BOWLING_TEAM_ID == widget.matchDataForApp.firstTeamId
                            ? widget.matchDataForApp.firstTeamShortName
                            : widget.matchDataForApp.secondTeamShortName,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        widget.scoreOfFirstInnings.toString() ?? "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        widget.wicketsOfFirstInnings.toString() ?? "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        widget.oversOfFirstInnings.toString() ?? '0',
                        // totalOver == '' ? "0" : totalOver,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        BATTING_TEAM_ID == widget.matchDataForApp.secondTeamId
                            ? widget.matchDataForApp.secondTeamShortName
                            : widget.matchDataForApp.firstTeamShortName,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        widget.scoreOfSecondInnings.toString() ?? "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        widget.wicketsOfSecondInnings.toString() ?? "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        widget.oversOfSecondInnings.toString() ?? '0',
                        //  totalOver == '' ? "0" : totalOver,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              FlatButton(
                  onPressed: () {
//                        changeInnings();
//                        context
//                            .bloc<SportsDataBloc>()
//                            .inningsFlag("2nd innings");
//                        Navigator.pushReplacement(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => StartInningsScreen(
//                                      matchDataForApp: widget.matchDataForApp,
//                                      allPlayerList: widget.allPlayerList,
//                                    )));
                  },
                  color: Colors.teal,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "End Match",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "CONTINUE THIS OVER",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
