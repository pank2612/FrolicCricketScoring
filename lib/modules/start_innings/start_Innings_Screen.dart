import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Screens/liveScoreScreen.dart';
import 'package:froliccricketscore/constants/global_variables.dart' as global;

class StartInningsScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  int winningTossTeamId;
  StartInningsScreen({this.matchDataForApp, this.winningTossTeamId});
  @override
  _StartInningsScreenState createState() => _StartInningsScreenState();
}

class _StartInningsScreenState extends State<StartInningsScreen> {
  File _image1;
  File _image2;
  File _image3;
  final picker = ImagePicker();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
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

  Widget chooseContainer1({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
//            _image1 == null
//                ?
                InkWell(
              onTap: () {
                // getImage1();
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PlayersList(
                              matchDataForApp: widget.matchDataForApp,
                              teamId: BATTING_TEAM_ID,
                              select: "Striker",
                            ))).then(onGoBack);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 45,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //: Image.file(_image1),
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

  Widget chooseContainer2({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
//            _image2 == null
//                ?
                InkWell(
              onTap: () {
                // getImage2();
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PlayersList(
                            matchDataForApp: widget.matchDataForApp,
                            teamId: BATTING_TEAM_ID,
//                            teamName: widget.tossModel.choose == "BAT"
//                                ? widget.tossModel.wonTossTeamName
//                                : looseTossTeamName,
//                            teamId: widget.tossModel.teamId,
                            select: "Runner"))).then(onGoBack);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 45,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
//                : Image.file(_image2),
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

  Widget chooseContainer3({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
//            _image3 == null
//                ?
                InkWell(
              onTap: () {
                //  getImage3();
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PlayersList(
                            matchDataForApp: widget.matchDataForApp,
                            teamId: BOWLING_TEAM_ID,
                            select: "Bowler"))).then(onGoBack);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 45,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //  : Image.file(_image3),
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
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Start Innings",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Batting - ${getBattingTeamName()}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    chooseContainer1(
                        name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .stricker
                                    .firstName ==
                                null
                            ? "Select Striker"
                            : context
                                .bloc<SportsDataBloc>()
                                .state
                                .stricker
                                .firstName,
                        url:
                            "https://cdn.iconscout.com/icon/premium/png-256-thumb/playing-cricket-1580212-1335319.png"),
                    chooseContainer2(
                        name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .runner
                                    .firstName ==
                                null
                            ? "Select Runner"
                            : context
                                .bloc<SportsDataBloc>()
                                .state
                                .runner
                                .firstName,
                        url:
                            "https://cdn.iconscout.com/icon/premium/png-256-thumb/running-batsman-2049546-1729209.png"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "Bowling- ${getBowlingTeamName()}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    chooseContainer3(
                        name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .bowler
                                    .firstName ==
                                null
                            ? "Select Bowler"
                            : context
                                .bloc<SportsDataBloc>()
                                .state
                                .bowler
                                .firstName,
                        url:
                            "https://cdn.iconscout.com/icon/premium/png-128-thumb/bowler-6-870764.png"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          InkWell(
            onTap: () {
//              if (global.striker == null) {
//                _showDialog("Please select Striker");
//                return;
//              }
//              if (global.runner == null) {
//                _showDialog("Please select Non-Striker");
//                return;
//              }
//              if (global.bowler == null) {
//                _showDialog("Please select bowler");
//                return;
//              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LiveScoreScreen(
                        matchDataForApp: widget.matchDataForApp,
                      )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Start Innings",
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
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  String getBattingTeamName() {
    if (BATTING_TEAM_ID == widget.matchDataForApp.firstTeamId) {
      return widget.matchDataForApp.firstTeamShortName;
    } else {
      return widget.matchDataForApp.secondTeamShortName;
    }
  }

  String getBowlingTeamName() {
    if (BOWLING_TEAM_ID == widget.matchDataForApp.firstTeamId) {
      return widget.matchDataForApp.firstTeamShortName;
    } else {
      return widget.matchDataForApp.secondTeamShortName;
    }
  }

  _showDialog(String name) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text(
      name,
      style: TextStyle(fontSize: 18),
    )));
  }
}
