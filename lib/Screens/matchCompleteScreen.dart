import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchCompleteScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  String howWonTheMatch;
  MatchCompleteScreen({
    this.matchDataForApp,
    this.howWonTheMatch,
  });
  @override
  _MatchCompleteScreenState createState() => _MatchCompleteScreenState();
}

class _MatchCompleteScreenState extends State<MatchCompleteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print("how team won the match ${widget.howWonTheMatch} ");
  }

  int getWickets(HashMap<int, PlayerDetailsModel> teamPlayerModelMap) {
    int wickets = 0;
//    context
//        .bloc<SportsDataBloc>()
//        .state
//        .teamPlayerScoring[BOWLING_TEAM_ID]
//        .
    teamPlayerModelMap.values.forEach((element) {
      wickets += element.wickets;
    });
    return wickets;
  }

  String getScore(HashMap<int, PlayerDetailsModel> teamPlayerModelMap) {
    String totalscore = '';
    int score = 0;
    teamPlayerModelMap.values.forEach((element) {
      score += element.runsMadeByBatsman;
    });
    score += context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[BATTING_TEAM_ID]
        .extraRuns;
    totalscore = score.toString();
    return totalscore;
  }

  String getOvers(List<Over> overList) {
    String overs = "0";
    Over over = overList[overList.length - 1];

    int bowlCount = 0;
    if (over.over == null) {
      return "0";
    }
    over.over.forEach((element) {
      if (element.isValid == true) {
        bowlCount += 1;
      }
    });
    if (bowlCount < 6) {
      overs = (overList.length - 1).toString() + "." + bowlCount.toString();
    } else {
      overs = overList.length.toString() + ".0";
    }
    return overs;
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
                        widget.matchDataForApp.firstTeamShortName ?? "Team A",
//                        BOWLING_TEAM_ID == widget.matchDataForApp.firstTeamId
//                            ? widget.matchDataForApp.firstTeamShortName
//                            : widget.matchDataForApp.secondTeamShortName,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        getScore(context
                                .bloc<SportsDataBloc>()
                                .state
                                .teamPlayerScoring[
                                    widget.matchDataForApp.firstTeamId]
                                .teamPlayerModelMap)
                            .toString(),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        getWickets(context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .teamPlayerScoring[
                                        widget.matchDataForApp.firstTeamId]
                                    .teamPlayerModelMap)
                                .toString() ??
                            "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        getOvers(context
                                .bloc<SportsDataBloc>()
                                .state
                                .teamPlayerScoring[
                                    widget.matchDataForApp.firstTeamId]
                                .overList) ??
                            "0",
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
                        widget.matchDataForApp.secondTeamShortName,
//                        BATTING_TEAM_ID == widget.matchDataForApp.secondTeamId
//                            ? widget.matchDataForApp.secondTeamShortName
//                            : widget.matchDataForApp.firstTeamShortName,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        getScore(context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .teamPlayerScoring[
                                        widget.matchDataForApp.secondTeamId]
                                    .teamPlayerModelMap)
                                .toString() ??
                            "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        getWickets(context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .teamPlayerScoring[
                                        widget.matchDataForApp.secondTeamId]
                                    .teamPlayerModelMap)
                                .toString() ??
                            "0",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        getOvers(context
                                .bloc<SportsDataBloc>()
                                .state
                                .teamPlayerScoring[
                                    widget.matchDataForApp.secondTeamId]
                                .overList) ??
                            "0",
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
