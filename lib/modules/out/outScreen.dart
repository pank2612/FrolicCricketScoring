import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/Screens/liveScoreScreen.dart';
import 'package:froliccricketscore/blocs/sportsBloc.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:froliccricketscore/models/player.dart';
import 'package:froliccricketscore/models/playerModel.dart';
import 'package:froliccricketscore/modules/out/caugth.dart';
import 'package:froliccricketscore/modules/out/runOutScreen.dart';
import 'package:froliccricketscore/modules/start_innings/player_list.dart';

class OutScreen extends StatefulWidget {
  MatchDataForApp matchDataForApp;
  List<Players> allPlayerList = List<Players>();
  OutScreen({this.matchDataForApp, this.allPlayerList});
  @override
  _OutScreenState createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> {
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
          "Out How?",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 21),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 0.69,
            children: List.generate(16, (index) {
              return InkWell(
                  splashColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                  ),
                  onTap: () {
                    _gridNavigation(index);
                  });
            })),
      ),
    );
  }

  FutureOr onGoBack1(dynamic value) async {
//    setState(() {
    //_whoIsOnStrikeDialogBox();
    bool returnValue = await _whoIsOnStrikeDialogBox();
    if (returnValue == true) {
      Navigator.of(context).pop();
    }
//    });
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
                    Navigator.of(context).pop();
                    return true;
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => LiveScoreScreen(
//                                  matchDataForApp: widget.matchDataForApp,
//                                  allPlayerList: widget.allPlayerList,
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

  _gridNavigation(int indexValue) {
    if (indexValue == 0) {
      bowled();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CaugthScreen(
                    matchDataForApp: widget.matchDataForApp,
                    playerList: widget.allPlayerList,
                  )));
    } else if (indexValue == 2) {
      caugthBehind();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 4) {
      stump();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 3) {
      caugthNbowled();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 5) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RunOutScreen(
                    matchDataForApp: widget.matchDataForApp,
                    playerList: widget.allPlayerList,
                  )));
    } else if (indexValue == 6) {
      lbw();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 7) {
      hitWicket();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 12) {
      hitTheBallTwice();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 13) {
      obstructingTheField();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    } else if (indexValue == 14) {
      timedOut();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayersList(
                    select: "Select next batsman",
                    teamId: BATTING_TEAM_ID,
                    matchDataForApp: widget.matchDataForApp,
                  ))).then(onGoBack1);
    }
  }

  List<Map<String, dynamic>> list = [
    {"name": "Bowled"},
    {"name": "Caugth"},
    {"name": "Caugth Behind"},
    {"name": "Caugth & Bowled"},
    {"name": "Stumped"},
    {"name": "Run Out"},
    {"name": "LBW"},
    {"name": "Hit Wicket"},
    {"name": "Retired Hurt"},
    {"name": "Retired Out"},
    {"name": "Action Out (Mankanded)"},
    {"name": "Absent"},
    {"name": "Hit the ball twice"},
    {"name": "Obstructing the field"},
    {"name": "Timed Out"},
    {"name": "Tried"},
  ];
  bowled() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        perBallRecord: "W".toString(),
        totalRun: 0,
        single: 0,
        typeOfOut: "bowled",
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 1,
        caugth: 0,
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
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  caugthBehind() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        helpingPlayerId: context.bloc<SportsDataBloc>().state.keeper.pid,
        perBallRecord: "W".toString(),
        totalRun: 0,
        single: 0,
        typeOfOut: "caugth behind",
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
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  stump() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        perBallRecord: "W".toString(),
        totalRun: 0,
        single: 0,
        typeOfOut: "stump",
        helpingPlayerId: context.bloc<SportsDataBloc>().state.keeper.pid,
        double: 0,
        tripple: 0,
        wide: 0,
        bowled: 1,
        caugth: 0,
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
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  caugthNbowled() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        perBallRecord: "W".toString(),
        totalRun: 0,
        single: 0,
        typeOfOut: "caugth & bowled",
        helpingPlayerId: context.bloc<SportsDataBloc>().state.bowler.pid,
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
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  lbw() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        // helpingPlayerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        typeOfOut: "lbw",
        perBallRecord: "W".toString(),
        totalRun: 0,
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
        lbw: 1,
        stump: 0,
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  hitWicket() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        typeOfOut: "hit-wicket",
        perBallRecord: "W".toString(),
        totalRun: 0,
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
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  hitTheBallTwice() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        typeOfOut: "hit the ball twice",
        perBallRecord: "W".toString(),
        totalRun: 0,
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
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  timedOut() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 0,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 0,
        run: 0,
        typeOfOut: "timed Out",
        perBallRecord: "W".toString(),
        totalRun: 0,
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
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
    // overFinishedDialogBox();
  }

  obstructingTheField() {
    Bowl bowl = Bowl(
        playerIdWhoIsOut: context.bloc<SportsDataBloc>().state.stricker.pid,
        dotBall: 1,
        bowlerId: context.bloc<SportsDataBloc>().state.bowler.pid,
        playerIdWhoFaced: context.bloc<SportsDataBloc>().state.stricker.pid,
        facedBall: 1,
        run: 0,
        typeOfOut: "Obstructing the field",
        perBallRecord: "W".toString(),
        totalRun: 0,
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
        extras: 0,
        wicket: 1,
        isValid: true);
    context.bloc<SportsDataBloc>().updateOver(bowl);
    context.bloc<SportsDataBloc>().updateStriker(bowl, BATTING_TEAM_ID);
    context.bloc<SportsDataBloc>().updateBowler(bowl, BOWLING_TEAM_ID);
  }
}
