import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';

class ScoreCardScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  ScoreCardScreen({this.matchDataForApp});
  @override
  _ScoreCardScreenState createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  String getScore(
      HashMap<int, PlayerDetailsModel> teamPlayerModelMap, int teamId) {
    String totalscore = '';
    int score = 0;
//    context
//        .bloc<SportsDataBloc>()
//        .state
//        .teamPlayerScoring[BATTING_TEAM_ID]
//        .
    teamPlayerModelMap.values.forEach((element) {
      score += element.runsMadeByBatsman;
    });
    score += context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[teamId]
        .extraRuns;
    totalscore = score.toString();
    return totalscore;
  }

  @override
  Widget build(BuildContext context) {
    List<PlayerDetailsModel> battingPlayerdetailList =
        List<PlayerDetailsModel>();
    for (int i = 0; i < 11; i++) {
      battingPlayerdetailList.add(null);
    }
    context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[BATTING_TEAM_ID]
        .teamPlayerModelMap
        .values
        .forEach((element) {
      battingPlayerdetailList[element.battingPosition - 1] = element;
    });

    List<PlayerDetailsModel> bowlingPlayerdetailList =
        List<PlayerDetailsModel>();
    for (int i = 0; i < 11; i++) {
      bowlingPlayerdetailList.add(null);
    }
    context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[BOWLING_TEAM_ID]
        .teamPlayerModelMap
        .values
        .forEach((element) {
      // if (element.teamId == BOWLING_TEAM_ID) {
      bowlingPlayerdetailList[element.battingPosition - 1] = element;
//      bowlingPlayerdetailList.add(element);
      //}
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Score Card",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              // border: Border.all(),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.28,
            padding: EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LIVE",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      widget.matchDataForApp.tournamentName +
                          "    " +
                          widget.matchDataForApp.startDate,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          color: Colors.white,
                          child: Image.network(
                            "https://1.bp.blogspot.com/-OJnaSK0cPEE/UyrNQajBVII/AAAAAAAATsc/FdxXVOeyg_I/s1600/CSK.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.matchDataForApp.firstTeamShortName ??
                                "Team A",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
//                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "(${getOvers(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.firstTeamId].overList)} ov)",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "${getScore(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.firstTeamId].teamPlayerModelMap, widget.matchDataForApp.firstTeamId) + "/" + getWickets(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.secondTeamId].teamPlayerModelMap).toString()}",
//                          BATTING_TEAM_ID == widget.matchDataForApp.firstTeamId
//                              ? "${getScore(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.firstTeamId].teamPlayerModelMap) + "/" + getWickets(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.firstTeamId].teamPlayerModelMap) .toString()}"
//                              : "${firstInningsScore().toString() + "/" + firstInningsWickets().toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
//                            textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Extras : ${context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.firstTeamId].extraRuns ?? "0"}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
//                        textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          color: Colors.white,
                          child: Image.network(
                            "https://thepopshopblog.files.wordpress.com/2017/03/rcb-logo.png?w=100",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            widget.matchDataForApp.secondTeamShortName ??
                                "Team B",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
//                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "(${getOvers(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.secondTeamId].overList)} ov)",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "${getScore(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.secondTeamId].teamPlayerModelMap, widget.matchDataForApp.secondTeamId) + "/" + getWickets(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.firstTeamId].teamPlayerModelMap).toString()}",

//                            BATTING_TEAM_ID ==
//                                    widget.matchDataForApp.secondTeamId
//                                ? "${getScore(context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.secondTeamId].teamPlayerModelMap) + "/" + getTotalWickets().toString()}"
//                                : "${firstInningsScore().toString() + "/" + firstInningsWickets().toString()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Extras : ${context.bloc<SportsDataBloc>().state.teamPlayerScoring[widget.matchDataForApp.secondTeamId].extraRuns ?? "0"}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                )
              ],
            ),
          ),
          ExpansionTile(
            title: Text(
              BATTING_TEAM_ID == widget.matchDataForApp.firstTeamId
                  ? "${widget.matchDataForApp.firstTeamShortName} innings"
                  : "${widget.matchDataForApp.secondTeamShortName} innings",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            children: [
              Container(
                color: Colors.blue.shade100,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "BATSMEN",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.34,
                    ),
                    Container(
                      child: Text(
                        "R",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "B",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "4s",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "6s",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        width: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                      .shortName
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.34,
                              ),
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                      .runsMadeByBatsman
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                      .facedBall
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                      .fours
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    battingPlayerdetailList[index]
                                        .sixes
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "${getOutText(battingPlayerdetailList[index])}",
                            //"${bowlingPlayerdetailList[index].typeOfOut.toString()} ${getHelpingFielderName(bowlingPlayerdetailList[index].playerId)}",
                            //"lbw b Bumrah",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          Divider(
                            thickness: 1.5,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: battingPlayerdetailList.length,
                  shrinkWrap: true,
                ),
              ),
              Container(
                color: Colors.blue.shade100,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "BOWLING",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.34,
                    ),
                    Container(
                      child: Text(
                        "O",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "M",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "R",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "W",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        width: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                      .shortName
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.34,
                              ),
                              Container(
                                child: Text(
                                  getBowlerOverText(
                                      bowlingPlayerdetailList[index].overList),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                      .maiden
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                      .runsByBowler
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    bowlingPlayerdetailList[index]
                                        .wickets
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                ),
                              ),
                            ],
                          ),
//                          SizedBox(
//                            height: MediaQuery.of(context).size.height * 0.01,
//                          ),
//                          Text(
//                            "lbw b Bumrah",
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w500,
//                                fontSize: 16),
//                          ),
                          Divider(
                            thickness: 1.5,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: bowlingPlayerdetailList.length,
                  shrinkWrap: true,
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.5,
          ),
          ExpansionTile(
            title: Text(
              BOWLING_TEAM_ID == widget.matchDataForApp.secondTeamId
                  ? "${widget.matchDataForApp.secondTeamShortName} innings"
                  : "${widget.matchDataForApp.firstTeamShortName} innings",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            children: [
              Container(
                color: Colors.blue.shade100,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "BATSMEN",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.34,
                    ),
                    Container(
                      child: Text(
                        "R",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "B",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "4s",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "6s",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        width: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                          .shortName
                                          .toString() ??
                                      "BATSMEN",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.34,
                              ),
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                          .runsMadeByBatsman
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                          .facedBall
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  bowlingPlayerdetailList[index]
                                          .fours
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    bowlingPlayerdetailList[index]
                                            .sixes
                                            .toString() ??
                                        "0",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "${getOutText(bowlingPlayerdetailList[index])}",
//                            "lbw b Bumrah",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          Divider(
                            thickness: 1.5,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: bowlingPlayerdetailList.length,
                  shrinkWrap: true,
                ),
              ),
              Container(
                color: Colors.blue.shade100,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "BOWLING",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.34,
                    ),
                    Container(
                      child: Text(
                        "O",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "M",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Text(
                        "R",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "W",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        width: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                          .shortName
                                          .toString() ??
                                      "BOWLER",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.34,
                              ),
                              Container(
                                child: Text(
                                  getBowlerOverText(
                                          battingPlayerdetailList[index]
                                              .overList) ??
                                      "R",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                          .maiden
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Container(
                                child: Text(
                                  battingPlayerdetailList[index]
                                          .runsByBowler
                                          .toString() ??
                                      "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                width: MediaQuery.of(context).size.width * 0.18,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    battingPlayerdetailList[index]
                                            .wickets
                                            .toString() ??
                                        "0",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.5,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: battingPlayerdetailList.length,
                  shrinkWrap: true,
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "To change wicket-keeper :",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                FlatButton(
                  child: BlocBuilder<SportsDataBloc, SportsDataBlocState>(
                    builder: (_, state) {
                      return Text(
                        state.keeper.shortName ?? "Change Keeper",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayersList(
                                  matchDataForApp: widget.matchDataForApp,
                                  teamId: BOWLING_TEAM_ID,
                                  select: "Keeper",
                                ))).then(goBackKeeper);
                  },
                  color: Colors.teal,
                  splashColor: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getBowlerOverText(List<Over> overList) {
    String txt = "";
    if (overList == null) {
      txt = "0.0";
      return txt;
    }

    Over over = overList[overList.length - 1];
    int bowlCount = 0;
    if (over.over != null) {
      over.over.forEach((element) {
        if (element.isValid == true) {
          bowlCount += 1;
        }
      });
    }
    if (bowlCount < 6) {
      txt = (overList.length - 1).toString() + "." + bowlCount.toString();
    } else {
      txt = overList.length.toString() + ".0";
    }
    return txt;
  }

  String getOutText(PlayerDetailsModel playerDetailsModel) {
    switch (playerDetailsModel.typeOfOut) {
      case 'runout':
        return "r.o. " +
            getHelpingFielderName(playerDetailsModel.helpingPlayerId) +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'caugth':
        return "c " +
            getHelpingFielderName(playerDetailsModel.helpingPlayerId) +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'caugth behind':
        return "cb " +
            getHelpingFielderName(playerDetailsModel.helpingPlayerId) +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'lbw':
        return "lbw " +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'caugth & bowled':
        return "c & b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'stump':
        return "s " +
            getHelpingFielderName(playerDetailsModel.helpingPlayerId) +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'hit-wicket':
        return "hit-wicket " +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'hit the ball twice':
        return "hit the ball twice " +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'timed Out':
        return "timed out " +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'obstructing the field':
        return "obstructing the field " +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      case 'bowled':
        return "b " +
            " b " +
            getBowlerName(playerDetailsModel.batsmanOutThroughBowlerId);
      default:
        return "Not Out";
    }
  }

  String getHelpingFielderName(int pId) {
    String txt = '';
    context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[BOWLING_TEAM_ID]
        .teamPlayerModelMap
        .values
        .forEach((element) {
      if (element.playerId == pId) {
        txt = element.shortName;
      }
    });
    return txt;
  }

  String getBowlerName(int pId) {
    String txt = '';
    context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[BOWLING_TEAM_ID]
        .teamPlayerModelMap
        .values
        .forEach((element) {
      if (element.playerId == pId) {
        txt = element.shortName;
      }
    });
    return txt;
  }

  FutureOr goBackKeeper(dynamic value) {
    setState(() {});
  }
}
