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
                FlatButton(
                  child: Text(
                    'Select next batsman',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.teal.shade600,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayersList(
                                  select: "Select next batsman",
                                  teamId: BATTING_TEAM_ID,
                                  matchDataForApp: widget.matchDataForApp,
                                ))).then(onGoBack1);
                    //Navigator.of(context).pop();
                  },
                ),
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.black,
                      onTap: () {
                        context.bloc<SportsDataBloc>().setStricker(
                            context.bloc<SportsDataBloc>().state.stricker.pid,
                            widget.playerList);
                      },
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
                          context.bloc<SportsDataBloc>().setStricker(
                              context.bloc<SportsDataBloc>().state.runner.pid,
                              widget.playerList);
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveScoreScreen(
                                  matchDataForApp: widget.matchDataForApp,
                                )));
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget chooseContainer1({String name, String url}) {
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
          Text(
            name,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget chooseContainer2({String name, String url}) {
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
      body: Container(
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
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: chooseContainer1(
                  name: context
                      .bloc<SportsDataBloc>()
                      .state
                      .stricker
                      .firstName
                      .toString(),
                  url: "https://image.flaticon.com/icons/png/128/10/10552.png"),
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
                child: chooseContainer2(
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
                  _whoIsOnStrikeDialogBox();
                },
                child: Text(
                  "OUT",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                splashColor: Colors.black,
                color: Colors.teal,
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  FutureOr onGoBack1(dynamic value) {
    setState(() {});
  }

  LiveScoreScreen liveScoreScreen = LiveScoreScreen();
//  out() {
//    int run;
////    if (_selectedNoBall == "From Bat") {
////      run = int.parse(_nbController.text) ?? 0;
////    }
////    if (_selectedNoBall == "Bye" || _selectedNoBall == "Leg Bye") {
////      run = 0;
////    }
//    Bowl bowl = Bowl(
//        dotBall: 0,
//        extras: int.parse(_nbController.text) + 1 ?? 0,
//        facedBall: 0,
//        run: run,
//        perBallRecord:
//            (int.parse(_nbController.text) + 1).toString() + "NB" ?? 0,
//        totalRun: int.parse(_nbController.text) + 1 ?? 0,
//        single: 0,
//        double: 0,
//        tripple: 0,
//        wide: 0,
//        bowled: 0,
//        caugth: 0,
//        four: 0,
//        noBall: 1,
//        runOut: 0,
//        six: 0,
//        lbw: 0,
//        stump: 0,
//        wicket: 0,
//        isValid: true);
//
//    updateOver(bowl);
//    updateStriker(bowl);
//    updateBowler(bowl);
//  }
}
