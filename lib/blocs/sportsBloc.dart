import 'dart:collection';
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
  List<PlayerDetailsModel> _playerDetailList = List<PlayerDetailsModel>();
  List<Players> _selectedPlayers = List<Players>();
  Players _stricker = Players();

  HashMap<String, List<MatchDataForApp>> _sportsMap =
      HashMap<String, List<MatchDataForApp>>();
  var _tournamentDataMap = HashMap<String, TournamentData>();
  var _sportsDataFetched = false;
  Players _runner = Players();
  Players _bowler = Players();

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

  void setStricker(Players players) {
    _stricker = players;
    add(SportsDataBlocEvent.setUpdate);
  }

  Players stricker(Players players) {
    return state.stricker;
  }

  void setRunner(Players players) {
    _runner = players;
    add(SportsDataBlocEvent.setUpdate);
  }

  Players runner(Players players) {
    return state.runner;
  }

  void setBowler(Players players) {
    _bowler = players;
    add(SportsDataBlocEvent.setUpdate);
  }

  Players bowler(Players players) {
    return state.bowler;
  }

  void updatePlayerDetail(PlayerDetailsModel players) {
    _playerDetailList.forEach((element) {
      if (element.playerId == players.playerId) {
        _playerDetailList.remove(element);
      }
    });
    _playerDetailList.add(players);

    add(SportsDataBlocEvent.setUpdate);
  }

  PlayerDetailsModel playerModel(PlayerDetailsModel players) {
    return state.playerDetailsModel;
  }

  void setOver(Bowl bowl) {
    print("over Ball------- $bowl");
    if (_overList.isEmpty) {
      Over overNext = Over();
      List<Bowl> bowlList = List<Bowl>();
      bowlList.add(bowl);
      overNext.over = bowlList;
      print("over Next------- $overNext");
      _overList.add(overNext);
    } else {
      Over over = _overList[_overList.length];
      int bowlCount = 0;
      over.over.forEach((element) {
        if (element.isValid == true) {
          bowlCount += 1;
        }
      });
      if (bowlCount < 6) {
        over.over.add(bowl);
        _overList[_overList.length] = over;
      } else {
        Over overNext = Over();
        List<Bowl> bowlList = List<Bowl>();
        bowlList.add(bowl);
        overNext.over = bowlList;
        _overList.add(overNext);
//        Over overNext = Over();
//        overNext.over.add(bowl);
//        _overList.add(overNext);
      }
    }
    add(SportsDataBlocEvent.setUpdate);
  }

//  Over over(Over over) {
//    return state.over;
//  }

//  void getBowl(Bowl bowl) {
//    _bowl = bowl;
//    add(SportsDataBlocEvent.setUpdate);
//  }

  Bowl bowl(Bowl bowl) {
    return state.bowl;
  }

  void getPlayerDetailList(List<Players> allPlayerList) {
    List<PlayerDetailsModel> playerDetailList = List<PlayerDetailsModel>();
    allPlayerList.forEach((player) {
      PlayerDetailsModel playerDetailsModel = PlayerDetailsModel(
          playerName: player.firstName, playerId: player.pid);
      playerDetailList.add(playerDetailsModel);
    });
    _playerDetailList = playerDetailList;
    add(SportsDataBlocEvent.setUpdate);
  }

  List<PlayerDetailsModel> playerDetailList() {
    return state.playerDetailList;
  }

  void addNewPlayer(Players player) {
    _selectedPlayers.add(player);
    add(SportsDataBlocEvent.setUpdate);
  }

  void removePlayer(Players player) {
    _selectedPlayers.remove(player);
    add(SportsDataBlocEvent.setUpdate);
  }

  @override
  Stream<SportsDataBlocState> mapEventToState(
      SportsDataBlocEvent event) async* {
    switch (event) {
      case SportsDataBlocEvent.setUpdate:
        yield state.copyWith(
            sportsMap: _sportsMap,
            stricker: _stricker,
            overList: _overList,
            runner: _runner,
            bowler: _bowler,
            selectedPlayer: _selectedPlayers,
            tournamentDataMap: _tournamentDataMap,
            playerDetailList: _playerDetailList,
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
  List<PlayerDetailsModel> playerDetailList = List<PlayerDetailsModel>();
  Bowl bowl = Bowl();
  List<Over> overList = List<Over>();
  Players stricker = Players();
  Players runner = Players();
  Players bowler = Players();
  PlayerDetailsModel playerDetailsModel = PlayerDetailsModel();
  List<Players> selectedPlayer = List<Players>();
  HashMap<String, List<MatchDataForApp>> sportsMap =
      HashMap<String, List<MatchDataForApp>>();
  var tournamentDataMap = HashMap<String, TournamentData>();
  bool sportsDataFetched = false;

  SportsDataBlocState(
      {this.sportsMap,
      this.overList,
      this.playerDetailList,
      this.stricker,
      this.tournamentDataMap,
      this.sportsDataFetched,
      this.playerDetailsModel,
      this.runner,
      this.bowler,
      this.bowl,
      this.selectedPlayer});

  factory SportsDataBlocState.initial() {
    return SportsDataBlocState(
        sportsDataFetched: false,
        stricker: Players(),
        playerDetailsModel: PlayerDetailsModel(),
        sportsMap: HashMap<String, List<MatchDataForApp>>(),
        tournamentDataMap: HashMap<String, TournamentData>(),
        selectedPlayer: List<Players>(),
        runner: Players(),
        bowler: Players(),
        bowl: Bowl(),
        overList: List<Over>(),
        playerDetailList: List<PlayerDetailsModel>());
  }

  SportsDataBlocState copyWith(
      {HashMap<String, List<MatchDataForApp>> sportsMap,
      HashMap<String, TournamentData> tournamentDataMap,
      bool sportsDataFetched,
      List<Players> selectedPlayer,
      Players stricker,
      Players runner,
      Players bowler,
      Bowl bowl,
      List<Over> overList,
      List<PlayerDetailsModel> playerDetailList,
      PlayerDetailsModel playerDetailsModel}) {
    return SportsDataBlocState(
        sportsMap: sportsMap ?? this.sportsMap,
        selectedPlayer: selectedPlayer ?? this.selectedPlayer,
        tournamentDataMap: tournamentDataMap ?? this.tournamentDataMap,
        stricker: stricker ?? this.stricker,
        bowler: bowler ?? this.bowler,
        runner: runner ?? this.runner,
        bowl: bowl ?? this.bowl,
        overList: overList ?? this.overList,
        playerDetailsModel: playerDetailsModel ?? this.playerDetailsModel,
        playerDetailList: playerDetailList ?? this.playerDetailList,
        sportsDataFetched: sportsDataFetched ?? this.sportsDataFetched);
  }
}
