import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/models/player.dart';
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

  Widget tossContainer1({String name, String url}) {
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

  Widget tossContainer2({String name, String url}) {
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
    getSquadTeamData();
  }

  Future<void> getSquadTeamData() async {
    allPlayerList = await _getMatchPlayers();
    if (allPlayerList.length > 0) {
      setState(() {
        _isLoading = true;
      });
      getPlayerDetailsList();
    }
  }

  Future<List<Players>> _getMatchPlayers() async {
    List<Players> playerList = List<Players>();

    HashMap<int, Team> teamMap = context
        .bloc<SportsDataBloc>()
        .getTournamentData(widget.matchDataForApp.tournamentName)
        .teamMap;

    for (PlayerDetails playerDetails
        in teamMap[widget.matchDataForApp.firstTeamId].playerMap.values) {
      Players players = Players();
      players.country = playerDetails.country;
      players.point =
          num.tryParse(playerDetails.credits.toString())?.toDouble();
      players.firstName = playerDetails.name;
      players.shortName = playerDetails.shortName;
      players.picture = playerDetails.pictures;
      players.pid = num.tryParse(playerDetails.playerId.toString())?.toInt();
      players.fantasyPlayerRating =
          num.tryParse(playerDetails.points.toString())?.toInt();
      players.playingRole = playerDetails.skills;
      players.teamId = teamMap[widget.matchDataForApp.firstTeamId].teamId;
      players.teamName = teamMap[widget.matchDataForApp.firstTeamId].shortName;
      players.playing11 = playerDetails.isPlaying.toString();
      players.battingStyle = 'RHB';
      players.bowlingStyle = 'RHB';
      players.nationality = playerDetails.country;

      playerList.add(players);
    }

    for (PlayerDetails playerDetails
        in teamMap[widget.matchDataForApp.secondTeamId].playerMap.values) {
      Players players = Players();
      players.country = playerDetails.country;
      players.point =
          num.tryParse(playerDetails.credits.toString())?.toDouble();
      players.firstName = playerDetails.name;
      players.shortName = playerDetails.shortName;
      players.picture = playerDetails.pictures;
      players.pid = num.tryParse(playerDetails.playerId.toString())?.toInt();
      players.fantasyPlayerRating =
          num.tryParse(playerDetails.points.toString())?.toInt();
      players.playingRole = playerDetails.skills;
      players.teamId = teamMap[widget.matchDataForApp.secondTeamId].teamId;
      players.teamName = teamMap[widget.matchDataForApp.secondTeamId].shortName;
      players.playing11 = playerDetails.isPlaying.toString();
      players.battingStyle = 'RHB';
      players.bowlingStyle = 'RHB';
      players.nationality = playerDetails.country;

      playerList.add(players);
    }

    return playerList;
  }

  getPlayerDetailsList() {
    context.bloc<SportsDataBloc>().getPlayerDetailList(allPlayerList);
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(
//        "length ----- ${context.bloc<SportsDataBloc>().state.playerDetailList[17].isPlaying}");
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
                              child: tossContainer1(
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
                              child: tossContainer2(
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
                          winningTossTeamId: winningTossTeamID,
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
