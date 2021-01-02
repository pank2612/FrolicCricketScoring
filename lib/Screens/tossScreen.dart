import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/start_innings/start_Innings_Screen.dart';

class TossScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  TossScreen({this.matchDataForApp});
  @override
  _TossScreenState createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  int winningTossTeamID;

  Widget tossContainer({String name, String url}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.18,
        // height: 100,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade700, width: 3),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              name.toString(),
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget FirstTeamContainer({String name, String url}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.18,
        // height: 100,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade700, width: 3),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              name.toString(),
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget SecondTeamContainer({String name, String url}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.18,
        // height: 100,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade700, width: 3),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              name.toString(),
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  _gridNavigation(int indexValue) {
    if (indexValue == 0) {
      if (winningTossTeamID == widget.matchDataForApp.firstTeamId) {
        BATTING_TEAM_ID = widget.matchDataForApp.firstTeamId;
        BOWLING_TEAM_ID = widget.matchDataForApp.secondTeamId;
        return;
      } else {
        BATTING_TEAM_ID = widget.matchDataForApp.secondTeamId;
        BOWLING_TEAM_ID = widget.matchDataForApp.firstTeamId;
        return;
      }
    } else if (indexValue == 1) {
      if (winningTossTeamID == widget.matchDataForApp.firstTeamId) {
        BATTING_TEAM_ID = widget.matchDataForApp.secondTeamId;
        BOWLING_TEAM_ID = widget.matchDataForApp.firstTeamId;
        return;
      } else {
        BATTING_TEAM_ID = widget.matchDataForApp.firstTeamId;
        BOWLING_TEAM_ID = widget.matchDataForApp.secondTeamId;
        return;
      }
    }
  }

  List<Map<String, dynamic>> list = [
    {
      "name": "BAT",
      "image": "https://image.flaticon.com/icons/png/128/3439/3439653.png"
    },
    {
      "name": "BOWL",
      "image":
          "https://www.iconninja.com/files/829/530/352/cricket-ball-sport-cr%C3%ADquete-magento-england-bowling-icon.png"
    },
  ];
  var allPlayerList = List<Players>();
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeamData();
  }

  getTeamData() {
    HashMap<int, ScoreModel> teamPlayerScoring = HashMap<int, ScoreModel>();
    HashMap<int, PlayerDetailsModel> playerDetailsModelMap =
        HashMap<int, PlayerDetailsModel>();
    HashMap<int, PlayerDetailsModel> playerDetailsModelMap1 =
        HashMap<int, PlayerDetailsModel>();
    context
        .bloc<SportsDataBloc>()
        .state
        .tournamentDataMap[widget.matchDataForApp.tournamentName]
        .teamMap[widget.matchDataForApp.firstTeamId]
        .playerMap
        .forEach((playerID, playerDetail) {
//      print(
//          "batting index------- ${context.bloc<SportsDataBloc>().state.battingCounter}");
      //print("batting--- ${context.bloc<SportsDataBloc>().batting()}");
      context.bloc<SportsDataBloc>().batting();
      playerDetailsModelMap[playerID] = context
          .bloc<SportsDataBloc>()
          .getPlayerModel(widget.matchDataForApp.firstTeamId, playerDetail);
    });
    context.bloc<SportsDataBloc>().setBattingCounter(0);
    Over over = Over();
    List<Over> overList = List<Over>();
    overList.add(over);
    ScoreModel scoreModel = ScoreModel(
        extraRuns: 0,
        teamPlayerModelMap: playerDetailsModelMap,
        overList: overList);

    teamPlayerScoring[widget.matchDataForApp.firstTeamId] = scoreModel;
    context
        .bloc<SportsDataBloc>()
        .state
        .tournamentDataMap[widget.matchDataForApp.tournamentName]
        .teamMap[widget.matchDataForApp.secondTeamId]
        .playerMap
        .forEach((playerID, playerDetail) {
      //context.bloc<SportsDataBloc>().setBattingCounter();
      context.bloc<SportsDataBloc>().batting();
      playerDetailsModelMap1[playerID] = context
          .bloc<SportsDataBloc>()
          .getPlayerModel(widget.matchDataForApp.secondTeamId, playerDetail);
    });
    context.bloc<SportsDataBloc>().setBattingCounter(0);
    scoreModel = ScoreModel(
        extraRuns: 0,
        teamPlayerModelMap: playerDetailsModelMap1,
        overList: overList);

    teamPlayerScoring[widget.matchDataForApp.secondTeamId] = scoreModel;
    context.bloc<SportsDataBloc>().setTeamsScoring(teamPlayerScoring);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text(
            "Toss",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Who won the toss?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          children: [
                            InkWell(
                              splashColor: Colors.black,
                              onTap: () {
                                winningTossTeamID =
                                    widget.matchDataForApp.firstTeamId;
                              },
                              child: FirstTeamContainer(
                                  name:
                                      widget.matchDataForApp.firstTeamShortName,
                                  url:
                                      "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                            ),
                            InkWell(
                              splashColor: Colors.black,
                              onTap: () {
                                winningTossTeamID =
                                    widget.matchDataForApp.secondTeamId;
                              },
                              child: SecondTeamContainer(
                                  name: widget
                                      .matchDataForApp.secondTeamShortName,
                                  url:
                                      "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "Winner of the toss elected to?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
//                          SizedBox(
//                            height: MediaQuery.of(context).size.height * 0.005,
//                          ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: GridView.count(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          children: List.generate(2, (index) {
                            return InkWell(
                                splashColor: Colors.black,
                                child: tossContainer(
                                    name: list[index]['name'].toString(),
                                    url: list[index]['image'].toString()),
                                onTap: () {
                                  _gridNavigation(index);
                                });
                          })),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (winningTossTeamID == null) {
                  _showDialog("Please select toss winning team");
                  return;
                }
                if (BATTING_TEAM_ID == null || BOWLING_TEAM_ID == null) {
                  _showDialog("Please choose to bat or bowl");
                  return;
                }

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StartInningsScreen(
                          matchDataForApp: widget.matchDataForApp,
                          allPlayerList: allPlayerList,
                        )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Let's Play",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                color: Colors.green.shade900,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            )
          ],
        ));
  }

  _showDialog(String name) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(
      name,
      style: TextStyle(fontSize: 18),
    )));
  }
}
