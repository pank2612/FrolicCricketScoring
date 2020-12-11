import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/out/outScreen.dart';
import 'package:froliccricketscore/constants/global_variables.dart' as global;

class LiveScoreScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  LiveScoreScreen({this.matchDataForApp});
  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  TextEditingController _nbController = TextEditingController();
  TextEditingController _byeController = TextEditingController();
  var allPlayerList = List<Players>();
  Bowl bowl = Bowl();
  bool _isLoading = false;
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

//        });
    return playerList;
  }

  getPlayerDetailsList() {
    context.bloc<SportsDataBloc>().getPlayerDetailList(allPlayerList);
    setState(() {
      _isLoading = true;
    });
  }

  List<Map<String, dynamic>> list1 = [
    {"name": "0"},
    {"name": "1"},
    {"name": "2"},
    {"name": "3"},
    {"name": "4"},
    {"name": "6"},
    {"name": "WD"},
    {"name": "NB"},
    {"name": "BYE"},
  ];
  List<Map<String, dynamic>> list2 = [
    {"name": "UNDO"},
    {"name": "5,7"},
    {"name": "OUT"},
    {"name": "LB"},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSquadTeamData();
  }

  @override
  Widget build(BuildContext context) {
    Players bowler = context.bloc<SportsDataBloc>().state.bowler;
    Players stricker = context.bloc<SportsDataBloc>().state.stricker;
    Players runner = context.bloc<SportsDataBloc>().state.runner;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Team Avishek",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.white),
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: null),
        ],
      ),
      body: BlocBuilder<SportsDataBloc, SportsDataBlocState>(
        builder: (_, state) {
          return ListView(
            children: [
              Container(
                color: Colors.grey.shade500,
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${state.bowl.totalRun ?? 0}/0",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 40),
                          ),
                          Text(
                            getOverText(state.overList),
                            //"0/2",
                            // "(0.${state.over.over == null ? "0" : getValidBall(state.over.over)}/${state.over.overCounter ?? "0"})",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 17,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network(
                                          "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    stricker.firstName ?? "Striker",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Text(
                                "${state.playerDetailsModel.madeRuns}(${state.playerDetailsModel.facedBall.toString() ?? "0"})",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 17,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network(
                                          "https://image.flaticon.com/icons/png/128/3439/3439653.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    runner.firstName ?? "Runner",
//                                "Vivek",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Text(
                                "0(0)",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                color: Colors.blueGrey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              maxRadius: 14,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                "https://www.iconninja.com/files/829/530/352/cricket-ball-sport-cr%C3%ADquete-magento-england-bowling-icon.png",
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            bowler.firstName ?? "Bowler",
//                        "Avishek",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            "(${state.playerDetailsModel.runsByBowler ?? 0} - 0)",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            radius: 40,
                            child: Text(
                              state.overList[state.overList.length].over[index]
                                  .run
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                          );
                        },
                        itemCount: state.overList.isEmpty
                            ? 0
                            : state.overList[state.overList.length].over.length,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.43,
                  color: Colors.grey.shade100,
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          //color: Colors.red,
                          child: Column(
                            children: [
                              GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.051,
                                  children: List.generate(9, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: RaisedButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            _grid1Navigation(index);
                                          },
                                          splashColor: Colors.grey,
                                          child: Center(
                                              child: Text(
                                            list1[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 32),
                                          ))),
                                    );
                                  })),
                            ],
                          ),
                        ),
                        flex: 3,
                      ),
                      Flexible(
                        child: Container(
                          // color: Colors.yellow,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              childAspectRatio: 1.39,
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        _grid2Navigation(index);
                                      },
                                      splashColor: Colors.grey,
                                      color: Colors.white,
                                      child: Center(
                                          child: Text(
                                        list2[index]["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 23),
                                      ))),
                                );
                              })),
                        ),
                        flex: 1,
                      )
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }

  Widget _grid1Navigation(int indexValue) {
    if (indexValue == 0) {
      zero();
    } else if (indexValue == 1) {
      //  single();
    } else if (indexValue == 2) {
      //double();
    } else if (indexValue == 3) {
      //triple();
    } else if (indexValue == 4) {
      //four();
    } else if (indexValue == 5) {
      //six();
    } else if (indexValue == 6) {
      //wide();
    } else if (indexValue == 7) {
      _noBallDialogBox();
    } else if (indexValue == 8) {
      _byeDialogBox();
    }
  }

  Widget _grid2Navigation(int indexValue) {
    if (indexValue == 0) {
      _undoDialogBox();
    } else if (indexValue == 1) {
      _57DialogBox();
    } else if (indexValue == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OutScreen()));
    } else if (indexValue == 3) {
      _legByeDialogBox();
    }
  }

  String radioItem = '';
  _noBallDialogBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'No Ball',
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "NB + ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: _nbController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 4,
                                    style: BorderStyle.solid))),
                      ),
                    ),
                    Text(
                      " = 2 Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
//                        autofocus: true,
//                        activeColor: Colors.blue,
                          value: "0",
                          onChanged: (val) {
                            setState(() {
                              radioItem = val;
                            });
                          },
                          groupValue: radioItem,
                        ),
                        Text("From Bat"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
//                        autofocus: true,
//                        activeColor: Colors.blue,
                          value: "0",
                          onChanged: (val) {
                            setState(() {
                              radioItem = val;
                            });
                          },
                          groupValue: radioItem,
                        ),
                        Text("Bye"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
//                        autofocus: true,
//                        activeColor: Colors.blue,
                          value: "0",
                          onChanged: (val) {
                            setState(() {
                              radioItem = val;
                            });
                          },
                          groupValue: radioItem,
                        ),
                        Text("Leg Bye"),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      //color: Colors.black,
                      borderSide: BorderSide(color: Colors.black),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.teal.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _byeDialogBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bye',
            style: TextStyle(
                color: Colors.red, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: _byeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 4,
                                    style: BorderStyle.solid))),
                      ),
                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
                    Text(
                      " Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.02,
//                ),
                Text(
                  "Current Keeper:",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      //color: Colors.black,
                      borderSide: BorderSide(color: Colors.black),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.teal.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _legByeDialogBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Leg Bye',
            style: TextStyle(
                color: Colors.red, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: _byeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 4,
                                    style: BorderStyle.solid))),
                      ),
                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
                    Text(
                      " Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.02,
//                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      //color: Colors.black,
                      borderSide: BorderSide(color: Colors.black),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.teal.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _57DialogBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Scored by running',
            style: TextStyle(
                color: Colors.red, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: _byeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 4,
                                    style: BorderStyle.solid))),
                      ),
                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
                    Text(
                      " Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.02,
//                ),
                Text(
                  "4 and 6 will not be considered boundaries",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      //color: Colors.black,
                      borderSide: BorderSide(color: Colors.black),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.teal.shade600,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _undoDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.warning,
                      color: Colors.orange,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Undo?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Confirmed undo last ball?",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.orange.shade700,
                    child: Text(
                      "YES, I'M SURE",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.transparent,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // int count = 0;
  updateOver(Bowl bowl) {
    context.bloc<SportsDataBloc>().setOver(bowl);
  }

  updateStriker(Bowl bowl) {
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
          player.playerId) {
        PlayerDetailsModel _playerDetailsModel =
            context.bloc<SportsDataBloc>().state.playerDetailsModel;
        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
        _playerDetailsModel.madeRuns += int.parse(bowl.run);
        _playerDetailsModel.facedBall += bowl.dotBall;
        // _playerDetailsModel.totalPlayedBalls += 1;
        if (int.parse(bowl.run) == 1 ||
            int.parse(bowl.run) == 3 ||
            int.parse(bowl.run) == 5) {
          // this.state.runner = player
          context.bloc<SportsDataBloc>().state.stricker.pid =
              context.bloc<SportsDataBloc>().state.runner.pid;
        }

        context.bloc<SportsDataBloc>().updatePlayerDetail(_playerDetailsModel);
      }
    });
  }

  updateRunner() {}
  updateBowler(Bowl bowl) {
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
      if (context.bloc<SportsDataBloc>().state.bowler.pid == player.playerId) {
        PlayerDetailsModel _playerDetailsModel =
            context.bloc<SportsDataBloc>().state.playerDetailsModel;
        _playerDetailsModel.runsByBowler += int.parse(bowl.run);
        if (bowl.isValid == true) {
          _playerDetailsModel.dotsBallByBowler += bowl.dotBall;
          if (bowl.wicket == 1) {
            _playerDetailsModel.wickets += 1;
          }
        }
        context.bloc<SportsDataBloc>().updatePlayerDetail(_playerDetailsModel);
      }
    });
  }

  zero() {
    Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
    Bowl bowl = Bowl(
        dotBall: 1,
        run: 0.toString(),
        // totalRun: _bowl.totalRun + 0,
        isValid: true);

    updateOver(bowl);
    updateStriker(bowl);
    updateBowler(bowl);
  }

//  zero1() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            dotsBall: _playerDetailsModel.dotsBall + 1,
//            madeRuns: _playerDetailsModel.madeRuns + 0,
//            totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1);
//        Bowl bowl = Bowl(
//            dotBall: _bowl.dotBall + 1,
//            run: 0.toString(),
//            totalRun: _bowl.totalRun + 0,
//            isValid: true);
//        ball.add(bowl);
//        if (getValidBall(ball) == 6) {
//          setState(() {
//            // count = 0;
//          });
//          return;
//        }
//        //   print("Count---------------${count}");
//        print("---------------${getValidBall(ball)}");
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
//    });
//  }
//
//  wide() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            //dotsBall: _playerDetailsModel.dotsBall + 1,
//            //madeRuns: _playerDetailsModel.madeRuns + 0,
//            // totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1
//            );
//        Bowl bowl = Bowl(
//            dotBall: _bowl.dotBall + 1,
//            wide: _bowl.wide + 1,
//            run: "WD",
//            totalRun: _bowl.totalRun + 1,
//            isValid: true);
//        ball.add(bowl);
////        if (getValidBall(ball) == 6) {
////          setState(() {
////            count = 0;
////          });
////          return;
////        }
//        // print("Count---------------${count}");
//        print("---------------${getValidBall(ball)}");
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
//    });
//  }
//
//  single() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            singles: _playerDetailsModel.singles + 1,
//            madeRuns: _playerDetailsModel.madeRuns + 1,
//            totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1);
//        Bowl bowl = Bowl(
//            run: 1.toString(), totalRun: _bowl.totalRun + 1, isValid: true);
//        ball.add(bowl);
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
////      if (context.bloc<SportsDataBloc>().state.bowler.pid == player.playerId) {
////        PlayerDetailsModel _playerDetailsModel =
////            context.bloc<SportsDataBloc>().state.playerDetailsModel;
////        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
////        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
////          runsByBowler: _playerDetailsModel.runsByBowler + 1,
////          // madeRuns: _playerDetailsModel.madeRuns + 0,
////          //  totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1
////        );
//////        Bowl bowl = Bowl(
//////            //dotBall: count + 1,
//////            //run: 0.toString(),
//////            //totalRun: _bowl.totalRun + 0,
//////            isValid: true);
//////        ball.add(bowl);
//////        if (getValidBall(ball) == 6) {
//////          setState(() {
//////            count = 0;
//////          });
//////          return;
//////        }
////        print("Count---------------${count}");
////        print("---------------${getValidBall(ball)}");
////        Over over = Over(over: ball);
////        setState(() {
////          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//////          context.bloc<SportsDataBloc>().getBowl(bowl);
//////          context.bloc<SportsDataBloc>().getOver(over);
////        });
////      }
//    });
//  }
//
//  double() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            doubles: _playerDetailsModel.doubles + 1,
//            madeRuns: _playerDetailsModel.madeRuns + 2,
//            totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1);
//        Bowl bowl = Bowl(
//            run: 2.toString(), totalRun: _bowl.totalRun + 2, isValid: true);
//        ball.add(bowl);
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
//    });
//  }
//
//  triple() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            tripples: _playerDetailsModel.tripples + 1,
//            madeRuns: _playerDetailsModel.madeRuns + 3,
//            totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1);
//        Bowl bowl = Bowl(
//            run: 3.toString(), totalRun: _bowl.totalRun + 3, isValid: true);
//        ball.add(bowl);
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
//    });
//  }
//
//  four() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            fours: _playerDetailsModel.fours + 1,
//            madeRuns: _playerDetailsModel.madeRuns + 4,
//            totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1);
//        Bowl bowl = Bowl(
//            run: 4.toString(), totalRun: _bowl.totalRun + 4, isValid: true);
//        ball.add(bowl);
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
//    });
//  }
//
//  six() {
//    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((player) {
//      if (context.bloc<SportsDataBloc>().state.stricker.pid ==
//          player.playerId) {
//        Bowl _bowl = context.bloc<SportsDataBloc>().state.bowl;
//        PlayerDetailsModel _playerDetailsModel =
//            context.bloc<SportsDataBloc>().state.playerDetailsModel;
//        PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
//            sixes: _playerDetailsModel.sixes + 1,
//            madeRuns: _playerDetailsModel.madeRuns + 6,
//            totalPlayedBalls: _playerDetailsModel.totalPlayedBalls + 1);
//        Bowl bowl = Bowl(
//            run: 6.toString(), totalRun: _bowl.totalRun + 6, isValid: true);
//        ball.add(bowl);
//        Over over = Over(over: ball);
//        setState(() {
//          context.bloc<SportsDataBloc>().getPlayerDetail(playerDetailsModel);
//          context.bloc<SportsDataBloc>().getBowl(bowl);
//          context.bloc<SportsDataBloc>().getOver(over);
//        });
//      }
//    });
//  }

  int getValidBall(List<Bowl> bowlList) {
    int length = 0;
    bowlList.forEach((element) {
      if (element.isValid == true) {
        print("length is ${bowlList.length}");
        length += 1;
      }
    });
    return length;
    //state.over.over.length
  }

  String getOverText(List<Over> overList) {
    String txt = "";
    if (overList.isEmpty) {
      txt = "0.0";
      return txt;
    }
    Over over = overList[overList.length];
    int bowlCount = 0;
    over.over.forEach((element) {
      if (element.isValid == true) {
        bowlCount += 1;
      }
    });
    if (bowlCount < 6) {
      txt = (overList.length - 1).toString() + "." + bowlCount.toString();
    } else {
      txt = overList.length.toString() + ".0";
    }
    return txt;
  }
}
