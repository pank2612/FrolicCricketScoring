import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Screens/liveScoreScreen.dart';
import 'package:froliccricketscore/constants/global_variables.dart' as global;

class StartInningsScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;

  StartInningsScreen({this.matchDataForApp});
  @override
  _StartInningsScreenState createState() => _StartInningsScreenState();
}

class _StartInningsScreenState extends State<StartInningsScreen> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  Widget strikerContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
                InkWell(
              onTap: () {
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

  Widget runnerContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
                InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PlayersList(
                            matchDataForApp: widget.matchDataForApp,
                            teamId: BATTING_TEAM_ID,
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

  Widget bowlerContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
                InkWell(
              onTap: () {
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

  Widget chooseKeeperContainer({String name, String url}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child:
                CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 45,
              child: Image.network(
                url,
                fit: BoxFit.cover,
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
                    strikerContainer(
                        name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .stricker
                                    .playerName ==
                                null
                            ? "Select Striker"
                            : context
                                .bloc<SportsDataBloc>()
                                .state
                                .stricker
                                .playerName,
                        url:
                            "https://cdn.iconscout.com/icon/premium/png-256-thumb/playing-cricket-1580212-1335319.png"),
                    runnerContainer(
                        name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .runner
                                    .playerName ==
                                null
                            ? "Select Runner"
                            : context
                                .bloc<SportsDataBloc>()
                                .state
                                .runner
                                .playerName,
                        url:
                            "https://cdn.iconscout.com/icon/premium/png-256-thumb/running-batsman-2049546-1729209.png"),
                  ],
                ),
                Text(
                  "Bowling- ${getBowlingTeamName()}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bowlerContainer(
                        name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .bowler
                                    .playerName ==
                                null
                            ? "Select Bowler"
                            : context
                                .bloc<SportsDataBloc>()
                                .state
                                .bowler
                                .playerName,
                        url:
                            "https://cdn.iconscout.com/icon/premium/png-128-thumb/bowler-6-870764.png"),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => PlayersList(
                                    matchDataForApp: widget.matchDataForApp,
                                    teamId: BOWLING_TEAM_ID,
                                    select: "Keeper"))).then(onGoBack);
                      },
                      splashColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: chooseKeeperContainer(
                            name: context
                                    .bloc<SportsDataBloc>()
                                    .state
                                    .keeper
                                    .playerName ??
                                "Wicket Keeper",
                            url:
                                "http://images.clipartpanda.com/keeper-clipart-cricket_wicket_keeper.jpg"),
                      ),
                    )
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
              if (context.bloc<SportsDataBloc>().state.stricker.playerName ==
                  null) {
                _showDialog("Please select Striker");
                return;
              }
              if (context.bloc<SportsDataBloc>().state.runner.playerName ==
                  null) {
                _showDialog("Please select Non-Striker");
                return;
              }
              if (context.bloc<SportsDataBloc>().state.bowler.playerName ==
                  null) {
                _showDialog("Please select bowler");
                return;
              }
              if (context.bloc<SportsDataBloc>().state.keeper.playerName ==
                  null) {
                _showDialog("Please select Wicket-Keeper");
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LiveScoreScreen(
                        matchDataForApp: widget.matchDataForApp
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
