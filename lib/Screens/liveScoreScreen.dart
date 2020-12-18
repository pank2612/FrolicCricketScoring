import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/Screens/scoreCardScreen.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/out/outScreen.dart';
import 'package:froliccricketscore/constants/global_variables.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';

class LiveScoreScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  List<Players> allPlayerList = List<Players>();
  LiveScoreScreen({this.matchDataForApp, this.allPlayerList});
  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  TextEditingController _nbController = TextEditingController();
  TextEditingController _byeController = TextEditingController();
  TextEditingController _legByeController = TextEditingController();
  TextEditingController _fiveSevenController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${getScore(state.overList)}/0",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 40),
                              ),
                              Text(
                                "(${getOverText(state.overList)})",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScoreCardScreen(
                                            matchDataForApp:
                                                widget.matchDataForApp,
                                            score: score,
                                            extraRuns: extraRuns,
                                            totalOver: totalOver,
                                          )));
                            },
                            child: Text(
                              "Score Card",
                              style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
//                        textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade50,
                      thickness: 1,
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
                                    state.stricker.firstName ?? "Striker",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Text(
                                getStrikerData(state.stricker.pid) ?? "0(0)",
                                // "${state.stricker.pid}(${state.playerDetailsModel.facedBall.toString() ?? "0"})",
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
                                          "https://cdn.iconscout.com/icon/premium/png-256-thumb/running-batsman-2049546-1729209.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    state.runner.firstName ?? "Runner",
//                                "Vivek",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Text(
                                getStrikerData(state.runner.pid) ?? "0(0)",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                state.bowler.firstName ?? "Bowler",
//                        "Avishek",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                getBowlerData(
                                        state.bowler.pid, state.overList) ??
                                    "(0-0)",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Extras -",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                getExtraRuns(state.overList).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 17),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            radius: 40,
                            child: Text(
                              state.overList[state.overList.length - 1]
                                  .over[index].perBallRecord
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                          );
                        },
                        itemCount: state.overList.isEmpty
                            ? 0
                            : state.overList[state.overList.length - 1].over
                                .length,
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
                  )),
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
      single();
    } else if (indexValue == 2) {
      double();
    } else if (indexValue == 3) {
      triple();
    } else if (indexValue == 4) {
      four();
    } else if (indexValue == 5) {
      six();
    } else if (indexValue == 6) {
      wide();
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
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OutScreen(
                matchDataForApp: widget.matchDataForApp,
                allPlayerList: widget.allPlayerList,
              )));
    } else if (indexValue == 3) {
      _legByeDialogBox();
    }
  }

  String _selectedNoBall;
  _noBallDialogBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Center(
            child: AlertDialog(
              title: Text(
                'No Ball',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "NB + ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
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
                          _nbController.text.isEmpty
                              ? " = 1 Runs"
                              : " = ${int.parse(_nbController.text) + 1} Runs ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            _selectedNoBall = "From Bat";
                          },
                          title: Text("From Bat"),
                        ),
                        ListTile(
                          onTap: () {
                            _selectedNoBall = "Bye";
                          },
                          title: Text("Bye"),
                        ),
                        ListTile(
                          onTap: () {
                            _selectedNoBall = "Leg Bye";
                          },
                          title: Text("Leg Bye"),
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
                            noBall();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  overFinishedDialogBox() {
    if (context.bloc<SportsDataBloc>().overFinished == true) {
      overFinished();
      context.bloc<SportsDataBloc>().resetOverFinished();
    }
  }

  overFinished() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text(
              'Score after this over',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Score : ",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            getScore(context
                                            .bloc<SportsDataBloc>()
                                            .state
                                            .overList)
                                        .toString() +
                                    "/0" ??
                                "0/0",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "${context.bloc<SportsDataBloc>().state.stricker.shortName} : " ??
                                "Striker",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            getStrikerData(context
                                .bloc<SportsDataBloc>()
                                .state
                                .stricker
                                .pid),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "${context.bloc<SportsDataBloc>().state.runner.shortName} : " ??
                                "Runner",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            getStrikerData(context
                                .bloc<SportsDataBloc>()
                                .state
                                .runner
                                .pid),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "${context.bloc<SportsDataBloc>().state.bowler.shortName} : " ??
                                "Bowler",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            getBowlerData(
                                context.bloc<SportsDataBloc>().state.bowler.pid,
                                context.bloc<SportsDataBloc>().state.overList),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  FlatButton(
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.teal.shade600,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayersList(
                                    matchDataForApp: widget.matchDataForApp,
                                    teamId: BOWLING_TEAM_ID,
                                    select: "Bowler",
                                  ))).then(goBack);
                    },
                  ),
                ],
              )
            ],
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
                    Text(
                      " Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
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
                        bye();
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
                        controller: _legByeController,
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
                      " Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
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
                        legBye();
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
                        controller: _fiveSevenController,
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
                      " Runs ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
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
                        fiveSeven();
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

  zero() {
    Bowl bowl = Bowl(
        dotBall: 1,
        facedBall: 1,
        run: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        perBallRecord: 0.toString(),
        totalRun: 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        extras: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(bowl);
    overFinishedDialogBox();
  }

  single() {
    Bowl bowl = Bowl(
        dotBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 1,
        perBallRecord: 1.toString(),
        totalRun: 1,
        single: 1,
        double: 0,
        tripple: 0,
        wide: 0,
        extras: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);

    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  double() {
    Bowl bowl = Bowl(
        dotBall: 0,
        facedBall: 1,
        run: 2,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        perBallRecord: 2.toString(),
        totalRun: 2,
        single: 0,
        double: 1,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        extras: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  triple() {
    Bowl bowl = Bowl(
        dotBall: 0,
        facedBall: 1,
        run: 3,
        perBallRecord: 3.toString(),
        totalRun: 3,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        single: 0,
        double: 0,
        tripple: 1,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        extras: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  four() {
    Bowl bowl = Bowl(
        dotBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 4,
        perBallRecord: 4.toString(),
        totalRun: 4,
        single: 0,
        double: 1,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 1,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        extras: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  six() {
    Bowl bowl = Bowl(
        dotBall: 0,
        extras: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 6,
        perBallRecord: 6.toString(),
        totalRun: 6,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 1,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(bowl);
    overFinishedDialogBox();
  }

  wide() {
    Bowl bowl = Bowl(
        dotBall: 0,
        extras: 1,
        facedBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        run: 1,
        perBallRecord: "WD",
        totalRun: 1,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 1,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: false);
    context.bloc<SportsDataBloc>().updateOver(bowl);
//    context.bloc<SportsDataBloc>().updateStriker(bowl,widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  legBye() {
    Bowl bowl = Bowl(
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        extras: int.parse(_legByeController.text) ?? 0,
        facedBall: 1,
        run: 0,
        perBallRecord: _legByeController.text + "LB",
        totalRun: int.parse(_legByeController.text) ?? 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  bye() {
    Bowl bowl = Bowl(
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        extras: int.parse(_byeController.text) ?? 0,
        facedBall: 1,
        run: 0,
        perBallRecord: _byeController.text + "B",
        totalRun: int.parse(_byeController.text) ?? 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  fiveSeven() {
    Bowl bowl = Bowl(
        dotBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        extras: int.parse(_fiveSevenController.text) ?? 0,
        facedBall: 0,
        run: int.parse(_fiveSevenController.text) ?? 0,
        perBallRecord: _fiveSevenController.text ?? 0,
        totalRun: int.parse(_fiveSevenController.text) ?? 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
//    context.bloc<SportsDataBloc>().updateStriker(bowl,widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  noBall() {
    int run;
    if (_selectedNoBall == "From Bat") {
      run = int.parse(_nbController.text) ?? 0;
    }
    if (_selectedNoBall == "Bye" || _selectedNoBall == "Leg Bye") {
      run = 0;
    }
    Bowl bowl = Bowl(
        dotBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        extras: int.parse(_nbController.text) + 1 ?? 0,
        facedBall: 0,
        run: run,
        perBallRecord:
            (int.parse(_nbController.text) + 1).toString() + "NB" ?? 0,
        totalRun: int.parse(_nbController.text) + 1 ?? 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 1,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: false);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  out() {
    int run;
    if (_selectedNoBall == "From Bat") {
      run = int.parse(_nbController.text) ?? 0;
    }
    if (_selectedNoBall == "Bye" || _selectedNoBall == "Leg Bye") {
      run = 0;
    }
    Bowl bowl = Bowl(
        dotBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        extras: int.parse(_nbController.text) + 1 ?? 0,
        facedBall: 0,
        run: run,
        perBallRecord:
            (int.parse(_nbController.text) + 1).toString() + "NB" ?? 0,
        totalRun: int.parse(_nbController.text) + 1 ?? 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: 1,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        wicket: 0,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.allPlayerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    overFinishedDialogBox();
  }

  String totalOver = '';
  String getOverText(List<Over> overList) {
    String txt = "";
    if (overList.isEmpty) {
      txt = "0.0";
      return txt;
    }

    Over over = overList[overList.length - 1];
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
    totalOver = txt;
    return txt;
  }

  String getCurrentBall(List<Over> overList) {
    String txt = "";
    if (overList.isEmpty) {
      txt = "0.0";
      return txt;
    }

    Over over = overList[overList.length - 1];
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

  int score = 0;
  int getScore(List<Over> overList) {
    int scoreText = 0;
    overList.forEach((element) {
      element.over.forEach((element) {
        scoreText += element.totalRun;
      });
    });
    score = scoreText;
    return scoreText;
  }

  int extraRuns = 0;
  int getExtraRuns(List<Over> overList) {
    int extraRunText = 0;
    overList.forEach((element) {
      element.over.forEach((element) {
        extraRunText += element.extras;
      });
    });
    extraRuns = extraRunText;
    return extraRunText;
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

  String getStrikerData(int strikerPID) {
    String text = '';
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
      if (element.playerId == strikerPID) {
        text = element.madeRuns.toString() +
            " (" +
            (element.facedBall.toString()) +
            ")";
      }
    });
    return text;
  }

  String getRunnerData(int runnerPID) {
    String text = '';
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
      if (element.playerId == runnerPID) {
        text = element.madeRuns.toString() +
            " (" +
            (element.facedBall.toString()) +
            ")";
      }
    });
    return text;
  }

  String getBowlerData(int bowlerPID, List<Over> overList) {
    String text = '';
    context.bloc<SportsDataBloc>().state.playerDetailList.forEach((element) {
      if (element.playerId == bowlerPID) {
        text = "(" +
            element.runsByBowler.toString() +
            " - " +
            (getBowlerOverText(element.overList)) +
            ")";
      }
    });
    return text;
  }

  FutureOr goBack(dynamic value) {
    setState(() {});
  }
}
