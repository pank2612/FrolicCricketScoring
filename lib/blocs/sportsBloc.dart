import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:froliccricketscore/models/playerModel.dart';

import '../models/player.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:froliccricketscore/constants/config.dart';
import 'package:froliccricketscore/models/MatchModel.dart';
import 'package:intl/intl.dart';
import '../constants/global_variables.dart' as global;

class SportsDataBloc extends Bloc<SportsDataBlocEvent, SportsDataBlocState> {
  SportsDataBloc() : super(SportsDataBlocState.initial());

  List<Over> _overList = List<Over>();

  final _firestore = Firestore.instance;
  //List<PlayerDetailsModel> _playerDetailList = List<PlayerDetailsModel>();
  //List<Players> _selectedPlayers = List<Players>();
  PlayerDetailsModel _stricker = PlayerDetailsModel();
  HashMap<int, ScoreModel> _teamPlayerScoring = HashMap<int, ScoreModel>();
  String _strikerNrunner = '';
  String _inningsFlag = '';

  PlayerDetailsModel _selectFielder = PlayerDetailsModel();
  PlayerDetailsModel _keeper = PlayerDetailsModel();
  HashMap<String, List<MatchDataForApp>> _sportsMap =
      HashMap<String, List<MatchDataForApp>>();
  var _tournamentDataMap = HashMap<String, TournamentData>();
  var _sportsDataFetched = false;
  PlayerDetailsModel _runner = PlayerDetailsModel();
  PlayerDetailsModel _bowler = PlayerDetailsModel();
  bool overFinished = false;
  int _battingCounter = 0;
  int _bowlingCounter = 0;
  void deleteMatchfromList(MatchDataForApp matchDataForApp) {
//    List<MatchDataForApp> _matchDataForApp = _sportsMap[matchDataForApp.sportsName];
//
//    int index = _matchDataForApp.indexOf(matchDataForApp);
//    _matchDataForApp.removeAt(index);
//
//    _sportsMap[matchDataForApp.sportsName] = _matchDataForApp;
//    add(SportsDataBlocEvent.setUpdate);

    int index = _sportsMap[matchDataForApp.sportsName].indexOf(matchDataForApp);
    _sportsMap[matchDataForApp.sportsName].removeAt(index);
    add(SportsDataBlocEvent.setUpdate);
  }

  updateOver(Bowl bowl) {
    setOver(bowl);
  }

  updateStriker(Bowl bowl, int teamId) {
    PlayerDetailsModel _playerDetailsModel = PlayerDetailsModel();
    _playerDetailsModel =
        _teamPlayerScoring[teamId].teamPlayerModelMap[_stricker.playerId];
    _playerDetailsModel.sixes += bowl.six;
    _playerDetailsModel.fours += bowl.four;
    _playerDetailsModel.tripples += bowl.tripple;
    _playerDetailsModel.runsMadeByBatsman += bowl.run;
    _playerDetailsModel.dotsBall += bowl.dotBall;
    _playerDetailsModel.facedBall += bowl.facedBall;
    _playerDetailsModel.doubles += bowl.double;
    _playerDetailsModel.singles += bowl.single;
    if (_playerDetailsModel.playerId == bowl.playerIdWhoIsOut) {
      if (bowl.wicket == 1) {
        _playerDetailsModel.typeOfOut = bowl.typeOfOut;
        _playerDetailsModel.batsmanOutThroughBowlerId = bowl.bowlerId;
        _playerDetailsModel.helpingPlayerId = bowl.helpingPlayerId;
        _playerDetailsModel.batsmanOut = bowl.wicket;
      }
    }
    _teamPlayerScoring[teamId].teamPlayerModelMap[_stricker.playerId] =
        _playerDetailsModel;
    if (bowl.run == 1 || bowl.run == 3 || bowl.run == 5) {
      if (bowl.typeOfOut != "runout") {
        rotateStrike();
      }
    }
    _teamPlayerScoring[teamId].extraRuns += bowl.extras;

    add(SportsDataBlocEvent.setUpdate);
  }

  updateRunner(Bowl bowl, int teamId) {
    PlayerDetailsModel _playerDetailsModel = PlayerDetailsModel();
    _playerDetailsModel =
        _teamPlayerScoring[teamId].teamPlayerModelMap[_runner.playerId];
    if (_playerDetailsModel.playerId == bowl.playerIdWhoIsOut) {
      if (bowl.wicket == 1) {
        _playerDetailsModel.typeOfOut = bowl.typeOfOut;
        _playerDetailsModel.batsmanOutThroughBowlerId = bowl.bowlerId;
        _playerDetailsModel.helpingPlayerId = bowl.helpingPlayerId;
        _playerDetailsModel.batsmanOut = bowl.wicket;
        _teamPlayerScoring[teamId].teamPlayerModelMap[_runner.playerId] =
            _playerDetailsModel;
        add(SportsDataBlocEvent.setUpdate);
      }
    }
  }

  void resetStriker(String player) {
    PlayerDetailsModel model = PlayerDetailsModel(playerName: player);
    _stricker = model;
    add(SportsDataBlocEvent.setUpdate);
  }

  void resetFielder(String player) {
    PlayerDetailsModel model = PlayerDetailsModel(playerName: player);
    _selectFielder = model;
    add(SportsDataBlocEvent.setUpdate);
  }

  void resetRunner(String player) {
    PlayerDetailsModel model = PlayerDetailsModel(playerName: player);
    _runner = model;
    add(SportsDataBlocEvent.setUpdate);
  }

  void resetBowler(String player) {
    PlayerDetailsModel model = PlayerDetailsModel(playerName: player);
    _bowler = model;
    add(SportsDataBlocEvent.setUpdate);
  }

  void resetKeeper(String player) {
    PlayerDetailsModel model = PlayerDetailsModel(playerName: player);
    _keeper = model;
    add(SportsDataBlocEvent.setUpdate);
  }

  updateBowler(Bowl bowl, int teamId) {
    PlayerDetailsModel _playerDetailsModel = PlayerDetailsModel();
    _playerDetailsModel =
        _teamPlayerScoring[teamId].teamPlayerModelMap[_bowler.playerId];
    _playerDetailsModel.overList =
        setOverList(bowl, _playerDetailsModel.overList);
    _teamPlayerScoring[BATTING_TEAM_ID].overList =
        setOverList(bowl, _teamPlayerScoring[BATTING_TEAM_ID].overList);
    _playerDetailsModel.runsByBowler += bowl.run;
//    _playerDetailsModel.runsByBowler += bowl.noBall;
    _playerDetailsModel.runsByBowler += bowl.wide;
//    _playerDetailsModel.extrasByBowlers += bowl.wide;
    _playerDetailsModel.runsByBowler += bowl.extras;
    _playerDetailsModel.sixesByBowlers += bowl.six;
    _playerDetailsModel.foursByBowler += bowl.four;
    _playerDetailsModel.trippleByBowler += bowl.tripple;
    _playerDetailsModel.singleByBowler += bowl.single;
    _playerDetailsModel.doubleByBowlers += bowl.double;
    _playerDetailsModel.foursByBowler += bowl.four;
    _playerDetailsModel.runout = bowl.runOut;
    _playerDetailsModel.caugth = bowl.caugth;
    _playerDetailsModel.bowled = bowl.bowled;
    _playerDetailsModel.dotsBallByBowler += bowl.dotBall;
    if (bowl.isValid == true) {
      _playerDetailsModel.ballsByBowler += 1;
      if (bowl.wicket == 1) {
        _playerDetailsModel.wickets += 1;
        _playerDetailsModel.helpingPlayerId = bowl.helpingPlayerId;
        _playerDetailsModel.typeOfOut = bowl.typeOfOut;
        _playerDetailsModel.batsmanOutThroughBowlerId = bowl.bowlerId;
      }
    }

    _teamPlayerScoring[teamId].teamPlayerModelMap[_bowler.playerId] =
        _playerDetailsModel;

    if (bowl.isValid == true) {
      int validBowl = 0;
      _playerDetailsModel.overList[_playerDetailsModel.overList.length - 1].over
          .forEach((singleBowl) {
        if (singleBowl.isValid == true) {
          validBowl += 1;
        }
      });
      if (validBowl == 6) {
        _playerDetailsModel.maxOverPerBowler += 1;
        overFinished = true;
        rotateStrike();
      }
    }
    add(SportsDataBlocEvent.setUpdate);
  }

  void whoIsOut(String value) {
    _strikerNrunner = value;
    add(SportsDataBlocEvent.setUpdate);
  }

  void inningsFlag(String value) {
    _inningsFlag = value;
    add(SportsDataBlocEvent.setUpdate);
  }

  void resetOverFinished() {
    overFinished = false;
    add(SportsDataBlocEvent.setUpdate);
  }

  List<Over> setOverList(Bowl bowl, List<Over> _overList) {
    if (_overList[0].over == null) {
      List<Over> __overList = List<Over>();
      Over overNext = Over();
      List<Bowl> bowlList = List<Bowl>();
      bowlList.add(bowl);
      overNext.over = bowlList;
      __overList.add(overNext);
      _overList = __overList;
    } else {
      Over over = _overList[_overList.length - 1];
      int bowlCount = 0;
      if (over.over != null) {
        over.over.forEach((element) {
          if (element.isValid == true) {
            bowlCount += 1;
          }
        });
      }
      if (bowlCount < 6) {
        over.over.add(bowl);
        _overList[_overList.length - 1] = over;
      } else {
        Over overNext = Over();
        List<Bowl> bowlList = List<Bowl>();
        bowlList.add(bowl);
        overNext.over = bowlList;
        _overList.add(overNext);
      }
    }
    return _overList;
  }

  int getSportsList() {
    //  print('datatatata');
    //  print(_sportsMap.keys.length);
    return _sportsMap.keys.length;
  }

  TournamentData getTournamentData(String tournamentName) {
    return _tournamentDataMap[tournamentName];
  }

  List<Players> getSelectedPlayers() {
    return state.selectedPlayer;
  }

  void setBattingCounter(int index) {
    _battingCounter = index;
    add(SportsDataBlocEvent.setUpdate);
  }

  void batting() {
    this._battingCounter += 1;
    add(SportsDataBlocEvent.setUpdate);
  }

  int bowling() {
    return _battingCounter++;
  }

  void setBowlingCounter() {
    _battingCounter;
    add(SportsDataBlocEvent.setUpdate);
  }

  void setStricker(int playerID, List<PlayerDetailsModel> playerList) {
    PlayerDetailsModel newPlayers = PlayerDetailsModel();
    PlayerDetailsModel oldPlayers = PlayerDetailsModel();
    int changeBattingIndex = -1;
    playerList.forEach((element) {
      if (element.playerId == playerID) {
        changeBattingIndex = element.battingPosition;
        newPlayers = element;
      }
      if (element.battingPosition == _battingCounter + 1) {
        oldPlayers = element;
      }
    });
//    print("oldPlayer ${oldPlayers.playerName}  "
//        "  ${oldPlayers.battingPosition.toString()}");
//    print("NewPlayer ${newPlayers.playerName}  "
//        "  ${newPlayers.battingPosition.toString()}");
    oldPlayers.battingPosition = changeBattingIndex;
    batting();
    _teamPlayerScoring[BATTING_TEAM_ID]
        .teamPlayerModelMap[oldPlayers.playerId] = oldPlayers;
    newPlayers.battingPosition = _battingCounter;
    _teamPlayerScoring[BATTING_TEAM_ID]
        .teamPlayerModelMap[newPlayers.playerId] = newPlayers;
//    print("oldPlayer ${oldPlayers.playerName}  "
//        "  ${oldPlayers.battingPosition.toString()}");
//    print("NewPlayer ${newPlayers.playerName}  "
//        "  ${newPlayers.battingPosition.toString()}");
    _stricker = newPlayers;
    add(SportsDataBlocEvent.setUpdate);
  }

  void rotateStrike() {
    PlayerDetailsModel localRunner = _runner;
    PlayerDetailsModel localStriker = _stricker;
    _stricker = localRunner;
    _runner = localStriker;
    add(SportsDataBlocEvent.setUpdate);
  }

  void selectFielder(PlayerDetailsModel players) {
    _selectFielder = players;
    add(SportsDataBlocEvent.setUpdate);
  }

  PlayerDetailsModel stricker(PlayerDetailsModel players) {
    return state.stricker;
  }

  PlayerDetailsModel selectfielder(PlayerDetailsModel players) {
    return state.selectFielder;
  }

  void setRunner(int playerID, List<PlayerDetailsModel> playerList) {
    PlayerDetailsModel newPlayers = PlayerDetailsModel();
    PlayerDetailsModel oldPlayers = PlayerDetailsModel();
    int changeBattingIndex = -1;
    playerList.forEach((element) {
      if (element.playerId == playerID) {
        changeBattingIndex = element.battingPosition;
        newPlayers = element;
      }
      if (element.battingPosition == _battingCounter + 1) {
        oldPlayers = element;
      }
    });
//    print("oldPlayer ${oldPlayers.playerName}  "
//        "  ${oldPlayers.battingPosition.toString()}");
//    print("NewPlayer ${newPlayers.playerName}  "
//        "  ${newPlayers.battingPosition.toString()}");
    oldPlayers.battingPosition = changeBattingIndex;
    batting();
    _teamPlayerScoring[BATTING_TEAM_ID]
        .teamPlayerModelMap[oldPlayers.playerId] = oldPlayers;
    newPlayers.battingPosition = _battingCounter;
    _teamPlayerScoring[BATTING_TEAM_ID]
        .teamPlayerModelMap[newPlayers.playerId] = newPlayers;
//    print("oldPlayer ${oldPlayers.playerName}  "
//        "  ${oldPlayers.battingPosition.toString()}");
//    print("NewPlayer ${newPlayers.playerName}  "
//        "  ${newPlayers.battingPosition.toString()}");
    _runner = newPlayers;
    add(SportsDataBlocEvent.setUpdate);
////    setBattingCounter();
//    PlayerDetailsModel players = PlayerDetailsModel();
//    playerList.forEach((element) {
//      if (element.playerId == playerID) {
//        players = element;
////        players.battingPosition += batting();
//      }
//    });
//    print("Runner ${players.battingPosition}");
//    _runner = players;
//    add(SportsDataBlocEvent.setUpdate);
  }

  PlayerDetailsModel runner(PlayerDetailsModel players) {
    return state.runner;
  }

  void setKeeper(int playerID, List<PlayerDetailsModel> playerList) {
    PlayerDetailsModel players = PlayerDetailsModel();
    playerList.forEach((element) {
      if (element.playerId == playerID) {
        players = element;
      }
    });
    print("Keeper ${players.playerId}");
    _keeper = players;
    add(SportsDataBlocEvent.setUpdate);
  }

  PlayerDetailsModel keeper(PlayerDetailsModel players) {
    return state.keeper;
  }

//  int bowlingCounter = 1;
  void setBowler(int playerID, List<PlayerDetailsModel> playerList) {
//    setBowlingCounter();
    PlayerDetailsModel players = PlayerDetailsModel();
    playerList.forEach((element) {
      if (element.playerId == playerID) {
        players = element;
//        players.bowlingPosition += bowling();
      }
    });
    print("Bowler ${players.battingPosition}");
    _bowler = players;
    add(SportsDataBlocEvent.setUpdate);
  }

  PlayerDetailsModel bowler(PlayerDetailsModel players) {
    return state.bowler;
  }

  void resetOver() {
    _teamPlayerScoring[BATTING_TEAM_ID]
        .overList[_overList.length - 1]
        .over
        .forEach((element) {
      element.perBallRecord = '';
    });
//    Over over = _overList[_overList.length - 1];
//    over.over.add(bowl);
//    _overList[_overList.length - 1] = over;
    add(SportsDataBlocEvent.setUpdate);
  }

  void setOver(Bowl bowl) {
//    print("over Ball------- $bowl");
    if (_overList.isEmpty) {
      Over overNext = Over();
      List<Bowl> bowlList = List<Bowl>();
      bowlList.add(bowl);
      overNext.over = bowlList;
      // print("over Next------- $overNext");
      _overList.add(overNext);
    } else {
      Over over = _overList[_overList.length - 1];
//      print("---------------${_overList[_overList.length - 1].over.length}");
      int bowlCount = 0;
      over.over.forEach((element) {
        if (element.isValid == true) {
          bowlCount += 1;
        }
      });
      if (bowlCount < 6) {
        over.over.add(bowl);
        _overList[_overList.length - 1] = over;
      } else {
        Over overNext = Over();
        List<Bowl> bowlList = List<Bowl>();
        bowlList.add(bowl);
        overNext.over = bowlList;
        _overList.add(overNext);
      }
    }
    add(SportsDataBlocEvent.setUpdate);
  }

  PlayerDetailsModel getPlayerModel(int teamId, PlayerDetails playerDetails) {
    // setBattingCounter();
//    print("index ${this._battingCounter}");
    Over over = Over();
    List<Over> __overList = List<Over>();
    __overList.add(over);
    PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
        battingPosition: this._battingCounter,
        playerName: playerDetails.name,
        isPlaying: playerDetails.isPlaying.toString(),
        shortName: playerDetails.shortName,
        teamId: teamId,
        playerId: playerDetails.playerId,
        overList: __overList);
//    print("batting index ${playerDetailsModel.battingPosition}");
    return playerDetailsModel;
  }

  setTeamsScoring(HashMap<int, ScoreModel> teamPlayerScoring) {
    _teamPlayerScoring = teamPlayerScoring;
    add(SportsDataBlocEvent.setUpdate);
  }

  List<PlayerDetailsModel> playerDetailList() {
    return state.playerDetailList;
  }

//  void addNewPlayer(Players player) {
//    _selectedPlayers.add(player);
//    add(SportsDataBlocEvent.setUpdate);
//  }

//  void removePlayer(Players player) {
//    _selectedPlayers.remove(player);
//    add(SportsDataBlocEvent.setUpdate);
//  }

  @override
  Stream<SportsDataBlocState> mapEventToState(
      SportsDataBlocEvent event) async* {
    switch (event) {
      case SportsDataBlocEvent.setUpdate:
        yield state.copyWith(
            sportsMap: _sportsMap,
            stricker: _stricker,
            keeper: _keeper,
            battingCounter: _battingCounter,
            bowlingCounter: _bowlingCounter,
            inningsFlag: _inningsFlag,
            strikerNrunner: _strikerNrunner,
            overList: _overList,
            runner: _runner,
            teamPlayerScoring: _teamPlayerScoring,
            overFinished: overFinished,
            bowler: _bowler,
            selectFielder: _selectFielder,
//            selectedPlayer: _selectedPlayers,
            tournamentDataMap: _tournamentDataMap,
//            playerDetailList: _playerDetailList,
            sportsDataFetched: _sportsDataFetched);
        break;
    }
  }

  HashMap<String, Skill> getTournamentSkills(sportsName, tournamentName) {
    return state.tournamentDataMap[tournamentName].skillMap;
  }

  Future<void> getSportsDataFromFirestore() async {
    var path = SPORTS_DATA;
    var sportsRef;
    try {
      sportsRef =
          await _firestore.collection(path).getDocuments(source: Source.server);
      if (sportsRef.documents.length == 0) {
        sportsRef = await _firestore
            .collection(path)
            .getDocuments(source: Source.server);
      }
    } catch (e) {
      sportsRef =
          await _firestore.collection(path).getDocuments(source: Source.server);
    } finally {
      if (sportsRef == null) {
        return;
      }

      if (sportsRef.documents.length > 0) {
        sportsRef.documents.forEach((element) async {
          var tournamentRef;
          try {
            tournamentRef = await _firestore
                .collection(path)
                .document(element.documentID.toString())
                .collection(TOURNAMENTS_DATA)
                .getDocuments(source: Source.server);

            if (tournamentRef.documents.length == 0) {
              tournamentRef = await _firestore
                  .collection(path)
                  .document(element.documentID.toString())
                  .collection(TOURNAMENTS_DATA)
                  .getDocuments(source: Source.server);
            }
          } catch (e) {
            tournamentRef = await _firestore
                .collection(path)
                .document(element.documentID.toString())
                .collection(TOURNAMENTS_DATA)
                .getDocuments(source: Source.server);
          } finally {
            if (tournamentRef.documents.length == 0) {
              return;
            }

            List<MatchDataForApp> matchDataForApp = List<MatchDataForApp>();
            if (tournamentRef.documents.length > 0) {
              tournamentRef.documents.forEach((tournamentElement) async {
//                HashMap<String, Skill> skillMap = HashMap<String, Skill>();
//                tournamentElement.data['skills'].forEach((skill) {
//                  skillMap[skill['short']] = Skill.fromJson(skill);
//                });
//
//                //Rule
//                HashMap<int, Rule> ruleMap = HashMap<int, Rule>();
//                tournamentElement.data['rules'].forEach((rule) {
//                  ruleMap[rule['id']] = Rule.fromJson(rule);
//                });
//
//                //SpecialRule
//                HashMap<String, SpecialRule> specialRuleMap =
//                    HashMap<String, SpecialRule>();
//                tournamentElement.data['specialrules'].forEach((specialRule) {
//                  specialRuleMap[specialRule['short']] =
//                      SpecialRule.fromJson(specialRule);
//                });

                //Team
                HashMap<int, Team> teamMap = HashMap<int, Team>();
                tournamentElement.data['teams'].forEach((team) {
                  HashMap<int, PlayerDetails> playersDetailsMap =
                      HashMap<int, PlayerDetails>();
                  if (team["plrs"] != null) {
                    //TODO remove when we have data
                    if (team["plrs"].length > 0) {
                      for (var i = 0; i < team["plrs"].length; i++) {
                        PlayerDetails player = PlayerDetails(
                            playerId: team["plrs"][i]["id"],
                            shortName: team["plrs"][i]["pShort"],
                            name: team["plrs"][i]["name"],
                            country: team["plrs"][i]["cnty"],
                            credits: team["plrs"][i]["cr"],
                            isPlaying: team["plrs"][i]["isP"],
                            points: team["plrs"][i]["pt"],
                            skills: team["plrs"][i]["pSkill"],
                            pictures: team["plrs"][i]['img'],
                            teamShortName: team["short"]);

                        playersDetailsMap[team["plrs"][i]['id']] = player;
                      }
                    }
                  }
                  Team tm = Team(
                      logo: team["logo"],
                      name: team["name"],
                      shortName: team["short"],
                      teamId: team["id"],
                      playerMap: playersDetailsMap);
                  teamMap[team['id']] = tm;
                });

                //Match

                HashMap<int, MatchData> matchMap = HashMap<int, MatchData>();
                tournamentElement.data['matches'].forEach((match) {
                  MatchData matchData = MatchData(
                      firstTeamId: match['tId1'],
                      secondTeamId: match['tId2'],
                      matchUniqueId: match['id'],
                      startTime: match['tm'],
                      startDate: match['dt'].toDate().toString());

                  matchMap[match['id']] = matchData;
                });
//                print('###############');
                matchMap.values.forEach((element) {
                  print(element.startDate);
                });

//                print('SruleMap');
//                print(specialRuleMap.length);
//                specialRuleMap.keys.forEach((element) {
//                  print(element);
//                });
                TournamentData tournamentData = TournamentData(
                  playersCount: tournamentElement.data['plr'],
                  totalPoints: tournamentElement.data['pts'],
                  playerImageFolder: tournamentElement.data['playerFolder'],
                  teamImageFolder: tournamentElement.data['teamImageFolder'],
                  id: tournamentElement.data['id'],
                  inningsOver: tournamentElement.data['inningsOver'],
                  maxOverPerPlayer: tournamentElement.data["maxOverPerPlayer"],
                  deadlineSeconds: tournamentElement.data['deadlineSeconds'],
                  maxPlayerFromSingleTeam: tournamentElement.data['maxPlr'],
                  name: tournamentElement.data['name'],
                  matchDataMap: matchMap,
//                  ruleMap: ruleMap,
//                  skillMap: skillMap,
//                  specialRuleMap: specialRuleMap,
                  teamMap: teamMap,
                );

//                print('tournament1111');
//                print(tournamentElement.data['name']);
//                print(tournamentData.toString());
//                print(tournamentData.skillMap.length);
                _tournamentDataMap[tournamentElement.data['name']] =
                    tournamentData;

//                print('sportssss');
//                print(element.documentID);
                matchDataForApp.addAll(
                    _convertMatchToApp(tournamentData, element.documentID));
              });
            }

//            print(matchDataForApp.length);

            _sportsMap[element.documentID] = matchDataForApp;

//            print(_sportsMap.length);
            _sportsDataFetched = true;
            add(SportsDataBlocEvent.setUpdate);
          }
        });
      } else {
        //TODO
        //as no data available for sports
        print('no data found');
        return;
      }
    }
  }

  List<MatchDataForApp> _convertMatchToApp(
      TournamentData tournamentData, String sportsName) {
    List<MatchDataForApp> matchDataForAppList = List<MatchDataForApp>();

    tournamentData.matchDataMap.values.forEach((matchData) {
      MatchDataForApp matchDataForApp = MatchDataForApp();
      matchDataForApp.sportsName = sportsName;
      matchDataForApp.firstTeamId = matchData.firstTeamId;
      matchDataForApp.matchUniqueId = matchData.matchUniqueId;
      matchDataForApp.secondTeamId = matchData.secondTeamId;
      matchDataForApp.startDate = matchData.startDate;
      matchDataForApp.startTime = matchData.startTime;

      DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(matchData.startDate + ' ' + matchData.startTime);

      var newDate =
          tempDate.add(new Duration(days: 22)).add(new Duration(minutes: 167));

//      print(matchDataForApp.matchUniqueId.toString() +
//          " :  " +
//          newDate.toString());
//      print(matchDataForApp.matchUniqueId.toString() +
//          " :  " +
//          newDate.toString());
      matchDataForApp.deadlineTime =
          (newDate.millisecondsSinceEpoch + 1000 * 60) -
              tournamentData.deadlineSeconds;
//      print(matchDataForApp.matchUniqueId.toString() +
//          " :  " +
//          matchDataForApp.deadlineTime.toString());
      matchDataForApp.tournamentId = tournamentData.id;
      matchDataForApp.tournamentName = tournamentData.name;
      matchDataForApp.maxOverPerPlayer = tournamentData.maxOverPerPlayer;
      matchDataForApp.inningsOver = tournamentData.inningsOver;
      matchDataForApp.firstTeamShortName =
          tournamentData.teamMap[matchData.firstTeamId].shortName;
      matchDataForApp.firstTeamLogo =
          tournamentData.teamMap[matchData.firstTeamId].logo;

      matchDataForApp.secondTeamShortName =
          tournamentData.teamMap[matchData.secondTeamId].shortName;
      ;
      matchDataForApp.secondTeamLogo =
          tournamentData.teamMap[matchData.secondTeamId].shortName;
      ;
      matchDataForAppList.add(matchDataForApp);
    });
    return matchDataForAppList;
  }
}

enum SportsDataBlocEvent { setUpdate }

class SportsDataBlocState {
  String strikerNrunner = '';
  String inningsFlag = '';
  int battingCounter = 1;
  int bowlingCounter = 1;
  HashMap<int, ScoreModel> teamPlayerScoring = HashMap<int, ScoreModel>();
  PlayerDetailsModel selectFielder = PlayerDetailsModel();
  List<PlayerDetailsModel> playerDetailList = List<PlayerDetailsModel>();
  List<Over> overList = List<Over>();
  PlayerDetailsModel stricker = PlayerDetailsModel();
  PlayerDetailsModel keeper = PlayerDetailsModel();
  PlayerDetailsModel runner = PlayerDetailsModel();
  PlayerDetailsModel bowler = PlayerDetailsModel();
  bool overFinished = false;
  List<Players> selectedPlayer = List<Players>();
  HashMap<String, List<MatchDataForApp>> sportsMap =
      HashMap<String, List<MatchDataForApp>>();
  var tournamentDataMap = HashMap<String, TournamentData>();
  bool sportsDataFetched = false;

  SportsDataBlocState(
      {this.sportsMap,
      this.strikerNrunner,
      this.overList,
      this.overFinished,
      this.playerDetailList,
      this.stricker,
      this.keeper,
      this.teamPlayerScoring,
      this.inningsFlag,
      this.tournamentDataMap,
      this.sportsDataFetched,
      this.selectFielder,
      this.runner,
      this.battingCounter,
      this.bowlingCounter,
      this.bowler,
      this.selectedPlayer});

  factory SportsDataBlocState.initial() {
    return SportsDataBlocState(
        sportsDataFetched: false,
        selectFielder: PlayerDetailsModel(),
        stricker: PlayerDetailsModel(),
        overFinished: false,
        sportsMap: HashMap<String, List<MatchDataForApp>>(),
        tournamentDataMap: HashMap<String, TournamentData>(),
        selectedPlayer: List<Players>(),
        runner: PlayerDetailsModel(),
        strikerNrunner: '',
        teamPlayerScoring: HashMap<int, ScoreModel>(),
        inningsFlag: '',
        battingCounter: 0,
        bowlingCounter: 0,
        bowler: PlayerDetailsModel(),
        keeper: PlayerDetailsModel(),
        overList: List<Over>(),
        playerDetailList: List<PlayerDetailsModel>());
  }

  SportsDataBlocState copyWith({
    HashMap<String, List<MatchDataForApp>> sportsMap,
    HashMap<String, TournamentData> tournamentDataMap,
    bool sportsDataFetched,
    List<PlayerDetailsModel> selectedPlayer,
    PlayerDetailsModel stricker,
    PlayerDetailsModel runner,
    PlayerDetailsModel bowler,
    HashMap<int, ScoreModel> teamPlayerScoring,
    String strikerNrunner,
    int battingCounter,
    int bowlingCounter,
    PlayerDetailsModel keeper,
    String inningsFlag,
    bool overFinished,
    List<Over> overList,
    PlayerDetailsModel selectFielder,
    List<PlayerDetailsModel> playerDetailList,
  }) {
    return SportsDataBlocState(
        sportsMap: sportsMap ?? this.sportsMap,
        selectedPlayer: selectedPlayer ?? this.selectedPlayer,
        tournamentDataMap: tournamentDataMap ?? this.tournamentDataMap,
        stricker: stricker ?? this.stricker,
        bowler: bowler ?? this.bowler,
        runner: runner ?? this.runner,
        bowlingCounter: bowlingCounter ?? this.bowlingCounter,
        battingCounter: battingCounter ?? this.battingCounter,
        keeper: keeper ?? this.keeper,
        teamPlayerScoring: teamPlayerScoring ?? this.teamPlayerScoring,
        inningsFlag: inningsFlag ?? this.inningsFlag,
        strikerNrunner: strikerNrunner ?? this.strikerNrunner,
        overFinished: overFinished ?? this.overFinished,
        selectFielder: selectFielder ?? this.selectFielder,
        overList: overList ?? this.overList,
        playerDetailList: playerDetailList ?? this.playerDetailList,
        sportsDataFetched: sportsDataFetched ?? this.sportsDataFetched);
  }
}
