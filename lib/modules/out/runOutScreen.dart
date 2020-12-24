import 'dart:async';

import 'package:flutter/material.dart';
import 'package:froliccricketscore/Screens/liveScoreScreen.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class RunOutScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  List<Players> playerList = List<Players>();
  RunOutScreen({this.matchDataForApp, this.playerList});
  @override
  _RunOutScreenState createState() => _RunOutScreenState();
}

class _RunOutScreenState extends State<RunOutScreen> {
  TextEditingController _runController = TextEditingController();
  File _image1;
  File _image2;
  File _image3;
  File _image4;
  final picker = ImagePicker();

  Future getImage1() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage3() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage4() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image4 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget chooseStrikerContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget normalText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
    );
  }

  Widget strikerContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget selectFielderContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget wicket_keeper_Container({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget runnerContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 20,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Run Out",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 21),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
            // height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                normalText("Who is Out?"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          playerIdWhoIsOut =
                              context.bloc<SportsDataBloc>().state.stricker.pid;
                          context.bloc<SportsDataBloc>().whoIsOut("striker");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: strikerContainer(
                              name: context
                                      .bloc<SportsDataBloc>()
                                      .state
                                      .stricker
                                      .firstName ??
                                  "Striker",
                              url:
                                  "https://image.flaticon.com/icons/png/128/10/10552.png"),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    InkWell(
                      splashColor: Colors.black,
                      onTap: () {
                        playerIdWhoIsOut =
                            context.bloc<SportsDataBloc>().state.runner.pid;
                        context.bloc<SportsDataBloc>().whoIsOut("runner");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: runnerContainer(
                            name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .runner
                                    .firstName ??
                                "Runner",
                            url:
                                "https://cdn0.iconfinder.com/data/icons/sports-and-games-3/512/140-128.png"),
                      ),
                    )
                  ],
                ),
                normalText("Select Fielder"),
                InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayersList(
                                    select: "Select Fielder",
                                    teamId: BOWLING_TEAM_ID,
                                    matchDataForApp: widget.matchDataForApp,
                                  ))).then(onGoBack);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: selectFielderContainer(
                          name: context
                                  .bloc<SportsDataBloc>()
                                  .state
                                  .selectFielder
                                  .firstName ??
                              "Thrower",
                          url:
                              "https://cdn0.iconfinder.com/data/icons/sports-and-games-3/512/140-128.png"),
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        normalText("Delivery Type"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              children: List.generate(4, (index) {
                                return InkWell(
                                    splashColor: Colors.grey.shade300,
                                    child: Card(
                                        // color: Colors.blue,
                                        child: Center(
                                            child: Text(
                                      list[index]["name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15),
                                    ))),
                                    onTap: () {
                                      _gridNavigation(index);
                                    });
                              })),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        normalText("Runs Scored"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextFormField(
                            controller: _runController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 4,
                                        style: BorderStyle.solid))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayersList(
                              select: "Select next batsman",
                              teamId: BATTING_TEAM_ID,
                              matchDataForApp: widget.matchDataForApp,
                            ))).then(onGoBack1);
              },
              color: Colors.red,
              child: Text(
                "OUT",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }

  _gridNavigation(int indexValue) {
    if (indexValue == 0) {
      deliveryType = 'WD';
    } else if (indexValue == 1) {
      deliveryType = 'NB';
    } else if (indexValue == 2) {
      deliveryType = 'BYE';
    } else if (indexValue == 3) {
      deliveryType = 'LB';
    }
  }

  List<Map<String, dynamic>> list = [
    {"name": "WD"},
    {"name": "NB"},
    {"name": "BYE"},
    {"name": "LB"},
  ];
  _whoIsOnStrikeDialogBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Striker',
            style: TextStyle(
                color: Colors.red, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.black,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: chooseStrikerContainer(
                            name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .stricker
                                    .firstName ??
                                "Striker",
                            url:
                                "https://image.flaticon.com/icons/png/128/10/10552.png"),
                      ),
                    ),
                    InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          context.bloc<SportsDataBloc>().rotateStrike();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: chooseStrikerContainer(
                              name: context
                                      .bloc<SportsDataBloc>()
                                      .state
                                      .runner
                                      .firstName ??
                                  "Runner",
                              url:
                                  "https://image.flaticon.com/icons/png/128/10/10552.png"),
                        ))
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
                  borderSide: BorderSide(color: Colors.black),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return false;
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.teal.shade600,
                  onPressed: () {
                    runOut();
                    Navigator.of(context).pop();
                    return true;
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => LiveScoreScreen(
//                                  matchDataForApp: widget.matchDataForApp,
//                                  allPlayerList: widget.playerList,
//                                )));
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  FutureOr onGoBack1(dynamic value) async {
    bool returnValue = await _whoIsOnStrikeDialogBox();
    if (returnValue == true) {
      Navigator.of(context).pop();
    }
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  int playerIdWhoIsOut = 0;
  String deliveryType = '';
  runOut() {
    int totalRun = 0;
    int run = 0;
    if (deliveryType == "WD") {
      totalRun = int.parse(_runController.text) + 1;
      run = 0;
    } else if (deliveryType == "NB") {
      totalRun = int.parse(_runController.text) + 1;
      run = int.parse(_runController.text);
    } else if (deliveryType == "BYE") {
      totalRun = int.parse(_runController.text);
      run = 0;
    } else if (deliveryType == "LB") {
      totalRun = int.parse(_runController.text);
      run = 0;
    } else {
      totalRun = int.parse(_runController.text);
      run = int.parse(_runController.text);
    }
    Bowl bowl = Bowl(
        playerIdWhoIsOut: playerIdWhoIsOut,
        dotBall: (deliveryType == "WD" || deliveryType == "NB") ? 0 : 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: (deliveryType == "WD" || deliveryType == "NB") ? 0 : 1,
        run: run,
        helpingPlayerId: context.bloc<SportsDataBloc>().state.selectFielder.pid,
        perBallRecord: "W".toString(),
        totalRun: totalRun,
        single: 0,
        double: 0,
        tripple: 0,
        wide: deliveryType == "WD" ? 1 : 0,
        bowled: 0,
        caugth: 0,
        four: 0,
        noBall: deliveryType == "NB" ? 1 : 0,
        runOut: 1,
        six: 0,
        lbw: 0,
        typeOfOut: "runout",
        stump: 0,
        extras: (deliveryType == "WD" || deliveryType == "NB") ? 1 : 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }
}
