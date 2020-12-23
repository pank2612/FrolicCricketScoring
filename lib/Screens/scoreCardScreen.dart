import 'dart:async';

import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';

class ScoreCardScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  String score;
  String wickets;
  int extraRuns;
  String totalOver;
  ScoreCardScreen(
      {this.matchDataForApp,
      this.wickets,
      this.extraRuns,
      this.totalOver,
      this.score});
  @override
  _ScoreCardScreenState createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("score is ${widget.score + "/" + widget.wickets}");
  }

  @override
  Widget build(BuildContext context) {
    List<PlayerDetailsModel> battingPlayerdetailList =
        List<PlayerDetailsModel>();
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
      if (element.teamId == BATTING_TEAM_ID) {
        battingPlayerdetailList.add(element);
      }
    });
    List<PlayerDetailsModel> bowlingPlayerdetailList =
        List<PlayerDetailsModel>();
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
      if (element.teamId == BOWLING_TEAM_ID) {
        bowlingPlayerdetailList.add(element);
      }
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
            height: MediaQuery.of(context).size.height * 0.25,
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
                          BATTING_TEAM_ID == widget.matchDataForApp.firstTeamId
                              ? "(${widget.totalOver ?? "0.0"} ov)"
                              : "",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          BATTING_TEAM_ID == widget.matchDataForApp.firstTeamId
                              ? "${widget.score + "/" + widget.wickets}"
                              : "0/0",
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
                          BATTING_TEAM_ID == widget.matchDataForApp.secondTeamId
                              ? "(${widget.totalOver ?? "0.0"} ov)"
                              : "",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            BATTING_TEAM_ID ==
                                    widget.matchDataForApp.secondTeamId
                                ? "${widget.score + "/" + widget.wickets}"
                                : "0/0",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
//                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Extras : ${widget.extraRuns ?? "0"}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
//                        textAlign: TextAlign.left,
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
                                      .madeRuns
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
                            bowlingPlayerdetailList[index].typeOfOut.toString(),
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
                  itemCount: 6,
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
                            "lbw b Bumrah",
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
                  itemCount: 6,
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
      case 'timed out':
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
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
      if (element.playerId == pId) {
        txt = element.shortName;
      }
    });
    return txt;
  }

  String getBowlerName(int pId) {
    String txt = '';
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
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