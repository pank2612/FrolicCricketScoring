import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/global_variables.dart' as global;

import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:froliccricketscore/models/playerModel.dart';

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
  List<PlayerDetailsModel> playerDetailModelList = List<PlayerDetailsModel>();
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTeamData();
  }

  getTeamData() {
    context
        .bloc<SportsDataBloc>()
        .state
        .teamPlayerScoring[widget.teamId]
        .teamPlayerModelMap
        .values
        .forEach((player) {
      if (widget.select == "Striker") {
        if (player.isPlaying == "1") {
          if (context.bloc<SportsDataBloc>().state.stricker != null) {
            if (player.playerId !=
                context.bloc<SportsDataBloc>().state.runner.playerId) {
              playerDetailModelList.add(player);
            }
          } else {
            playerDetailModelList.add(player);
          }
        }
      }
      if (widget.select == 'Runner') {
        if (player.isPlaying == "1") {
          if (context.bloc<SportsDataBloc>().state.runner != null) {
            if (player.playerId !=
                context.bloc<SportsDataBloc>().state.stricker.playerId) {
              playerDetailModelList.add(player);
            }
          } else {
            playerDetailModelList.add(player);
          }
        }
      }
      if (widget.select == 'Bowler') {
        if (player.isPlaying == "1") {
          if (context.bloc<SportsDataBloc>().state.bowler != null) {
            if (player.playerId !=
                context.bloc<SportsDataBloc>().state.keeper.playerId) {
              context
                  .bloc<SportsDataBloc>()
                  .state
                  .teamPlayerScoring[widget.teamId]
                  .teamPlayerModelMap
                  .values
                  .forEach((element) {
                if (element.playerId == player.playerId) {
                  if (element.maxOverPerBowler <
                      widget.matchDataForApp.maxOverPerPlayer) {
                    playerDetailModelList.add(player);
                  }
                }
              });
//              playerDetailModelList.add(player);
            }
          } else {
            playerDetailModelList.add(player);
          }
        }
      }

      if (widget.select == 'Keeper') {
        if (player.isPlaying == "1") {
          if (context.bloc<SportsDataBloc>().state.keeper != null) {
            if (player.playerId !=
                context.bloc<SportsDataBloc>().state.bowler.playerId) {
              playerDetailModelList.add(player);
            }
          } else {
            playerDetailModelList.add(player);
          }
        }
      }
      if (widget.select == 'Select Fielder') {
        if (context.bloc<SportsDataBloc>().state.keeper.playerId !=
            player.playerId) {
          playerDetailModelList.add(player);
        }
      }
      if (widget.select == 'Select next batsman') {
        // isPlaying check
        if (player.isPlaying == "1") {
          if (context.bloc<SportsDataBloc>().state.stricker != null) {
            if (player.playerId !=
                    context.bloc<SportsDataBloc>().state.stricker.playerId &&
                player.playerId !=
                    context.bloc<SportsDataBloc>().state.runner.playerId) {
              PlayerDetailsModel playerDetailsModel = PlayerDetailsModel();
              context
                  .bloc<SportsDataBloc>()
                  .state
                  .teamPlayerScoring[widget.teamId]
                  .teamPlayerModelMap
                  .values
                  .forEach((element) {
                if (player.playerId == element.playerId) {
                  playerDetailsModel = element;
                }
              });
              if (playerDetailsModel.batsmanOut == 0) {
                playerDetailModelList.add(player);
              }
            }
          } else {
            playerDetailModelList.add(player);
          }
        }
      }
    });
//    print('----- ${playerDetailModelList.length}');
  }
//  Future<List<Players>> _getMatchPlayers() async {
//    List<Players> playerList = List<Players>();
//    HashMap<int, Team> teamMap = context
//        .bloc<SportsDataBloc>()
//        .getTournamentData(widget.matchDataForApp.tournamentName)
//        .teamMap;
//    for (PlayerDetails playerDetails
//        in teamMap[widget.teamId].playerMap.values) {
//      getPlayerData() {
//        Players players = Players();
//        players.country = playerDetails.country;
//        players.point =
//            num.tryParse(playerDetails.credits.toString())?.toDouble();
//        players.firstName = playerDetails.name;
//        players.shortName = playerDetails.shortName;
//        players.picture = playerDetails.pictures;
//        players.pid = num.tryParse(playerDetails.playerId.toString())?.toInt();
//        players.fantasyPlayerRating =
//            num.tryParse(playerDetails.points.toString())?.toInt();
//        players.playingRole = playerDetails.skills;
//        players.teamId = teamMap[widget.matchDataForApp.firstTeamId].teamId;
//        players.teamName =
//            teamMap[widget.matchDataForApp.firstTeamId].shortName;
//        players.playing11 = playerDetails.isPlaying.toString();
//        players.battingStyle = 'RHB';
//        players.bowlingStyle = 'RHB';
//        players.nationality = playerDetails.country;
//        playerList.add(players);
//      }
//
//      if (widget.select == 'Striker') {
//        // isPlaying check
//        if (playerDetails.isPlaying == 1) {
//          if (context.bloc<SportsDataBloc>().state.stricker != null) {
//            if (playerDetails.playerId !=
//                context.bloc<SportsDataBloc>().state.runner.pid) {
//              getPlayerData();
//            }
//          } else {
//            getPlayerData();
//          }
//        }
//      }
//      if (widget.select == 'Runner') {
//        if (playerDetails.isPlaying == 1) {
//          if (context.bloc<SportsDataBloc>().state.runner != null) {
//            if (playerDetails.playerId !=
//                context.bloc<SportsDataBloc>().state.stricker.pid) {
//              getPlayerData();
//            }
//          } else {
//            getPlayerData();
//          }
//        }
//      }
//      if (widget.select == 'Bowler') {
//        if (playerDetails.isPlaying == 1) {
//          if (context.bloc<SportsDataBloc>().state.bowler != null) {
//            if (playerDetails.playerId !=
//                context.bloc<SportsDataBloc>().state.keeper.pid) {
//              context
//                  .bloc<SportsDataBloc>()
//                  .state
//                  .playerDetailList
//                  .forEach((element) {
//                if (element.playerId == playerDetails.playerId) {
//                  if (element.maxOverPerBowler <
//                      widget.matchDataForApp.maxOverPerPlayer) {
//                    getPlayerData();
//                  }
//                }
//              });
//            }
//          } else {
//            getPlayerData();
//          }
//        }
//      }
//      if (widget.select == 'Keeper') {
//        if (playerDetails.isPlaying == 1) {
//          if (context.bloc<SportsDataBloc>().state.keeper != null) {
//            if (playerDetails.playerId !=
//                context.bloc<SportsDataBloc>().state.bowler.pid) {
//              getPlayerData();
//            }
//          } else {
//            getPlayerData();
//          }
//        }
//      }
//      if (widget.select == 'Select Fielder') {
//        if (context.bloc<SportsDataBloc>().state.keeper.pid !=
//            playerDetails.playerId) {
//          getPlayerData();
//        }
//      }
//      if (widget.select == 'Select next batsman') {
//        // isPlaying check
//        if (playerDetails.isPlaying == 1) {
//          if (context.bloc<SportsDataBloc>().state.stricker != null) {
//            if (playerDetails.playerId !=
//                    context.bloc<SportsDataBloc>().state.stricker.pid &&
//                playerDetails.playerId !=
//                    context.bloc<SportsDataBloc>().state.runner.pid) {
//              PlayerDetailsModel playerDetailsModel = PlayerDetailsModel();
//              context
//                  .bloc<SportsDataBloc>()
//                  .state
//                  .playerDetailList
//                  .forEach((element) {
//                if (playerDetails.playerId == element.playerId) {
//                  playerDetailsModel = element;
//                }
//              });
//              if (playerDetailsModel.batsmanOut == 0) {
//                getPlayerData();
//              }
//            }
//          } else {
//            getPlayerData();
//          }
//        }
//      }
//    }
//    return playerList;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.select == "Select next batsman"
              ? "Select next batsman"
              : "Players List",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemBuilder: (context, index) {
//              PlayerDetailsModel key = context
//                  .bloc<SportsDataBloc>()
//                  .state
//                  .teamPlayerScoring[widget.teamId]
//                  .teamPlayerModelMap
//                  .values
//                  .elementAt(index);
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  if (widget.select == "Striker") {
                    if (context.bloc<SportsDataBloc>().state.runner != null) {
                      if (context
                              .bloc<SportsDataBloc>()
                              .state
                              .runner
                              .playerId ==
                          playerDetailModelList[index].playerId) {
                        context.bloc<SportsDataBloc>().state.runner = null;
                      }
                    }
                    context.bloc<SportsDataBloc>().setStricker(
                        playerDetailModelList[index].playerId,
                        playerDetailModelList);
                    return;
                  } else if (widget.select == "Runner") {
                    if (context.bloc<SportsDataBloc>().state.stricker != null) {
                      if (context
                              .bloc<SportsDataBloc>()
                              .state
                              .stricker
                              .playerId ==
                          playerDetailModelList[index].playerId) {
                        context.bloc<SportsDataBloc>().state.stricker = null;
                      }
                    }
                    context.bloc<SportsDataBloc>().setRunner(
                        playerDetailModelList[index].playerId,
                        playerDetailModelList);
//global.runner = allPlayerList[index];
                    return;
                  } else if (widget.select == "Keeper") {
                    if (context.bloc<SportsDataBloc>().state.bowler != null) {
                      if (context
                              .bloc<SportsDataBloc>()
                              .state
                              .bowler
                              .playerId ==
                          playerDetailModelList[index].playerId) {
                        context.bloc<SportsDataBloc>().state.bowler = null;
                      }
                    }
                    context.bloc<SportsDataBloc>().setKeeper(
                        playerDetailModelList[index].playerId,
                        playerDetailModelList);
                    return;
                  } else if (widget.select == "Bowler") {
                    if (context.bloc<SportsDataBloc>().state.keeper != null) {
                      if (context
                              .bloc<SportsDataBloc>()
                              .state
                              .keeper
                              .playerId ==
                          playerDetailModelList[index].playerId) {
                        context.bloc<SportsDataBloc>().state.bowler = null;
                      }
                    }
                    context.bloc<SportsDataBloc>().setBowler(
                        playerDetailModelList[index].playerId,
                        playerDetailModelList);
                    return;
                  } else if (widget.select == "Select Fielder") {
                    context
                        .bloc<SportsDataBloc>()
                        .selectFielder(playerDetailModelList[index]);
                    return;
                  } else if (widget.select == "Select next batsman") {
                    if (context.bloc<SportsDataBloc>().state.runner != null) {
                      if (context
                              .bloc<SportsDataBloc>()
                              .state
                              .runner
                              .playerId ==
                          playerDetailModelList[index].playerId) {
                        context.bloc<SportsDataBloc>().state.stricker = null;
                      }
                    }
                    if (context.bloc<SportsDataBloc>().state.strikerNrunner ==
                        "striker") {
                      context.bloc<SportsDataBloc>().setStricker(
                          playerDetailModelList[index].playerId,
                          playerDetailModelList);
                    } else if (context
                            .bloc<SportsDataBloc>()
                            .state
                            .strikerNrunner ==
                        "runner") {
                      context.bloc<SportsDataBloc>().setRunner(
                          playerDetailModelList[index].playerId,
                          playerDetailModelList);
                    } else {
                      context.bloc<SportsDataBloc>().setStricker(
                          playerDetailModelList[index].playerId,
                          playerDetailModelList);
                    }

                    return;
                  }
                },
                highlightColor: Colors.black,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      playerDetailModelList[index].playerName.toString(),
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
            itemCount: playerDetailModelList.length,
          )),
    );
  }
}
//InkWell(
//onTap: () {
//Navigator.of(context).pop();
//if (widget.select == "Striker") {
//if (context.bloc<SportsDataBloc>().state.runner != null) {
//if (context.bloc<SportsDataBloc>().state.runner.pid ==
//allPlayerList[index].pid) {
//context.bloc<SportsDataBloc>().state.stricker = null;
//}
//}
//context
//    .bloc<SportsDataBloc>()
//    .setStricker(allPlayerList[index].pid, allPlayerList);
//return;
//} else if (widget.select == "Runner") {
//if (context.bloc<SportsDataBloc>().state.stricker != null) {
//if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//allPlayerList[index].pid) {
//context.bloc<SportsDataBloc>().state.stricker = null;
//}
//}
//context
//    .bloc<SportsDataBloc>()
//    .setRunner(allPlayerList[index].pid, allPlayerList);
////global.runner = allPlayerList[index];
//return;
//} else if (widget.select == "Keeper") {
//if (context.bloc<SportsDataBloc>().state.bowler != null) {
//if (context.bloc<SportsDataBloc>().state.bowler.pid ==
//allPlayerList[index].pid) {
//context.bloc<SportsDataBloc>().state.bowler = null;
//}
//}
//context
//    .bloc<SportsDataBloc>()
//    .setKeeper(allPlayerList[index].pid, allPlayerList);
//return;
//} else if (widget.select == "Bowler") {
//if (context.bloc<SportsDataBloc>().state.keeper != null) {
//if (context.bloc<SportsDataBloc>().state.keeper.pid ==
//allPlayerList[index].pid) {
//context.bloc<SportsDataBloc>().state.bowler = null;
//}
//}
//context
//    .bloc<SportsDataBloc>()
//    .setBowler(allPlayerList[index].pid, allPlayerList);
//return;
//} else if (widget.select == "Select Fielder") {
//context
//    .bloc<SportsDataBloc>()
//    .selectFielder(allPlayerList[index]);
//return;
//} else if (widget.select == "Select next batsman") {
//if (context.bloc<SportsDataBloc>().state.runner != null) {
//if (context.bloc<SportsDataBloc>().state.runner.pid ==
//allPlayerList[index].pid) {
//context.bloc<SportsDataBloc>().state.stricker = null;
//}
//}
//if (context.bloc<SportsDataBloc>().state.strikerNrunner ==
//"striker") {
//context
//    .bloc<SportsDataBloc>()
//    .setStricker(allPlayerList[index].pid, allPlayerList);
//} else if (context
//    .bloc<SportsDataBloc>()
//    .state
//    .strikerNrunner ==
//"runner") {
//context
//    .bloc<SportsDataBloc>()
//    .setRunner(allPlayerList[index].pid, allPlayerList);
//} else {
//context
//    .bloc<SportsDataBloc>()
//    .setStricker(allPlayerList[index].pid, allPlayerList);
//}
//
//return;
//}
//},
//highlightColor: Colors.black,
//child: Card(
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Text(
//teamData[index].playerName.toString(),
//style: TextStyle(
//color: Colors.black,
//fontSize: 25,
//fontWeight: FontWeight.w500),
//),
//),
//elevation: 5,
//),
//);
