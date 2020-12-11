import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/global_variables.dart' as global;

import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersList extends StatefulWidget {
  int teamId;
  String select;
  MatchDataForApp matchDataForApp;
  PlayersList({this.select, this.teamId, this.matchDataForApp});
  @override
  _PlayersListState createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
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
    }
  }

  Future<List<Players>> _getMatchPlayers() async {
    List<Players> playerList = List<Players>();
    HashMap<int, Team> teamMap = context
        .bloc<SportsDataBloc>()
        .getTournamentData(widget.matchDataForApp.tournamentName)
        .teamMap;
    for (PlayerDetails playerDetails
        in teamMap[widget.teamId].playerMap.values) {
      getPlayerData() {
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
        players.teamName =
            teamMap[widget.matchDataForApp.firstTeamId].shortName;
        players.playing11 = playerDetails.isPlaying.toString();
        players.battingStyle = 'RHB';
        players.bowlingStyle = 'RHB';
        players.nationality = playerDetails.country;
        playerList.add(players);
      }

      if (widget.select == 'Striker') {
        if (context.bloc<SportsDataBloc>().state.stricker != null) {
          if (playerDetails.playerId !=
              context.bloc<SportsDataBloc>().state.stricker.pid) {
            getPlayerData();
          }
        } else {
          getPlayerData();
        }
      }
      if (widget.select == 'Runner') {
        if (context.bloc<SportsDataBloc>().state.runner != null) {
          if (playerDetails.playerId !=
              context.bloc<SportsDataBloc>().state.runner.pid) {
            getPlayerData();
          }
        } else {
          getPlayerData();
        }
      }
      if (widget.select == 'Bowler') {
        if (context.bloc<SportsDataBloc>().state.bowler != null) {
          if (playerDetails.playerId !=
              context.bloc<SportsDataBloc>().state.bowler.pid) {
            getPlayerData();
          }
        } else {
          getPlayerData();
        }
      }
    }
    return playerList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Players List",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: _isLoading == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (widget.select == "Striker") {
                        if (context.bloc<SportsDataBloc>().state.runner !=
                            null) {
                          if (context.bloc<SportsDataBloc>().state.runner.pid ==
                              allPlayerList[index].pid) {
                            context.bloc<SportsDataBloc>().state.stricker =
                                null;
                          }
                        }
                        context
                            .bloc<SportsDataBloc>()
                            .setStricker(allPlayerList[index]);
                        //  stricker = allPlayerList[index];
                        //  context.bloc<SportsDataBloc>().state.selectPlayerForPosition = allPlayerList[index];
                        // global.striker = allPlayerList[index];
                        return;
                      } else if (widget.select == "Runner") {
                        if (context.bloc<SportsDataBloc>().state.stricker !=
                            null) {
                          if (context
                                  .bloc<SportsDataBloc>()
                                  .state
                                  .stricker
                                  .pid ==
                              allPlayerList[index].pid) {
                            context.bloc<SportsDataBloc>().state.stricker =
                                null;
                          }
                        }
                        context
                            .bloc<SportsDataBloc>()
                            .setRunner(allPlayerList[index]);
                        //global.runner = allPlayerList[index];
                        return;
                      } else if (widget.select == "Bowler") {
                        context
                            .bloc<SportsDataBloc>()
                            .setBowler(allPlayerList[index]);
                        return;
                      }
                    },
                    highlightColor: Colors.black,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          allPlayerList[index].firstName.toString(),
                          //snapShot.data['Players'][index].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      elevation: 5,
                    ),
                  );
                },
                itemCount: allPlayerList.length,
              )),
    );
  }
}
