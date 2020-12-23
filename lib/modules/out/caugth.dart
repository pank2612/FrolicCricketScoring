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

class CaugthScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  List<Players> playerList = List<Players>();
  CaugthScreen({this.matchDataForApp, this.playerList});
  @override
  _CaugthScreenState createState() => _CaugthScreenState();
}

class _CaugthScreenState extends State<CaugthScreen> {
  Widget normalText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
    );
  }

  File _image1;
  File _image2;
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
                            name:
//                            playerIdWhoIsOut !=
//                                    context
//                                        .bloc<SportsDataBloc>()
//                                        .state
//                                        .stricker
//                                        .pid
//                                ? context
//                                        .bloc<SportsDataBloc>()
//                                        .state
//                                        .stricker
//                                        .firstName ??
//                                    "Striker"
//                                :
                                context
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
                              name:
//                              playerIdWhoIsOut !=
//                                      context
//                                          .bloc<SportsDataBloc>()
//                                          .state
//                                          .runner
//                                          .pid
//                                  ? context
//                                          .bloc<SportsDataBloc>()
//                                          .state
//                                          .runner
//                                          .firstName ??
//                                      "Runner"
//                                  :
                                  context
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
                  //color: Colors.black,
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
                    //  legBye();
                    Navigator.of(context).pop();
                    return true;
                    ;
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

  Widget whoIsOutContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 45,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
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
          Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget selectFielderContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 45,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.3,
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
  void initState() {
    // TODO: implement initState
    super.initState();
//    print("length is ${widget.playerList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Caugth",
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                normalText("Who?"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: whoIsOutContainer(
                          name: context
                              .bloc<SportsDataBloc>()
                              .state
                              .stricker
                              .firstName
                              .toString(),
                          url:
                              "https://image.flaticon.com/icons/png/128/10/10552.png"),
                    ),
//                    InkWell(
//                      splashColor: Colors.black,
//                      onTap: () {
//                        playerIdWhoIsOut =
//                            context.bloc<SportsDataBloc>().state.runner.pid;
////                        context.bloc<SportsDataBloc>().setRunner(
////                            context.bloc<SportsDataBloc>().state.stricker.pid,
////                            widget.playerList);
//                      },
//                      child: Padding(
//                        padding: const EdgeInsets.all(8),
//                        child: whoIsOutContainer(
//                            name: context
//                                .bloc<SportsDataBloc>()
//                                .state
//                                .runner
//                                .firstName
//                                .toString(),
//                            url:
//                                "https://cdn.iconscout.com/icon/premium/png-256-thumb/running-batsman-2049546-1729209.png"),
//                      ),
//                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                normalText("Select Fielder"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                InkWell(
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
                  splashColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectFielderContainer(
                        name: context
                                .bloc<SportsDataBloc>()
                                .state
                                .selectFielder
                                .firstName ??
                            " Select Fielder",
                        url:
                            "https://cdn0.iconfinder.com/data/icons/sports-and-games-3/512/140-128.png"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      out();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayersList(
                                    select: "Select next batsman",
                                    teamId: BATTING_TEAM_ID,
                                    matchDataForApp: widget.matchDataForApp,
                                  ))).then(onGoBack1);
                      //_whoIsOnStrikeDialogBox();
                    },
                    child: Text(
                      "OUT",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    splashColor: Colors.black,
                    color: Colors.teal,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  FutureOr onGoBack1(dynamic value) async {
    bool returnValue = await _whoIsOnStrikeDialogBox();
    if (returnValue == true) {
      Navigator.of(context).pop();
    }
  }

  out() {
//    print(
//        "selected fielder${context.bloc<SportsDataBloc>().state.selectFielder.pid}");
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        helpingPlayerId: context.bloc<SportsDataBloc>().state.selectFielder.pid,
        run: 0,
        typeOfOut: "caugth",
        perBallRecord: "W".toString(),
        totalRun: 0,
        single: 0,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 0,
        caugth: 1,
        four: 0,
        noBall: 0,
        runOut: 0,
        six: 0,
        lbw: 0,
        stump: 0,
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, widget.playerList);
    context.bloc<SportsDataBloc>().updateBowler(
          bowl,
        );
    // overFinishedDialogBox();
  }
}
