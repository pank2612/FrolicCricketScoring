// To parse this JSON data, do
//
//     final playerModel = playerModelFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';

PlayerModel playerModelFromJson(String str) =>
    PlayerModel.fromJson(json.decode(str));

String playerModelToJson(PlayerModel data) => json.encode(data.toJson());

class PlayerModel {
  PlayerModel({
    this.playerName,
    this.playerId,
  });

  String playerName;
  String playerId;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        playerName: json["playerName"],
        playerId: json["playerID"],
      );

  Map<String, dynamic> toJson() => {
        "playerName": playerName,
        "playerID": playerId,
      };
}

PlayerDetailsModel playerDetailsModelFromJson(String str) =>
    PlayerDetailsModel.fromJson(json.decode(str));

String playerDetailsModelToJson(PlayerDetailsModel data) =>
    json.encode(data.toJson());

class PlayerDetailsModel {
  PlayerDetailsModel(
      {this.playerId,
      this.helpingPlayerId = 0,
      this.playerName,
      this.totalPlayedBalls = 0,
      this.madeRuns = 0,
      this.overList,
      this.fours = 0,
      this.sixes = 0,
      this.overs = 0,
      this.maiden = 0,
      this.runsByBowler = 0,
      this.wickets = 0,
      this.caugth,
      this.runout,
      this.singles = 0,
      this.doubles = 0,
      this.tripples = 0,
      this.singleByBowler = 0,
      this.doubleByBowlers = 0,
      this.trippleByBowler = 0,
      this.foursByBowler = 0,
      this.hitWicket = 0,
      this.extrasByBowlers = 0,
      this.sixesByBowlers = 0,
      this.dotsBall = 0,
      this.batsmanOutThroughBowlerId = 0,
      this.bowled = 0,
      this.maxOverPerBowler = 0,
      this.ballsByBowler = 0,
      this.facedBall = 0,
      this.batsmanOut = 0,
      this.keeper,
      this.teamId = 0,
      this.typeOfOut = 'Not Out',
      this.shortName = '',
      this.isPlaying = '',
      this.dotsBallByBowler = 0});
  List<Over> overList = List<Over>();
  int playerId;
  int teamId;
  String typeOfOut = 'Not Out';
  String shortName;
  String playerName;
  int helpingPlayerId = 0;
  int totalPlayedBalls = 0;
  int madeRuns = 0;
  int batsmanOutThroughBowlerId = 0;
  int maxOverPerBowler = 0;
  int fours = 0;
  int sixes = 0;
  int hitWicket = 0;
  int hitTheBallTwice = 0;
  int overs = 0;
  int maiden = 0;
  int runsByBowler = 0;
  int wickets = 0;
  int caugth;
  int runout;
  int bowled = 0;
  int batsmanOut = 0;
  int singles = 0;
  int doubles = 0;
  int tripples = 0;
  int foursByBowler = 0;
  int sixesByBowlers = 0;
  int singleByBowler = 0;
  int doubleByBowlers = 0;
  int trippleByBowler = 0;
  int extrasByBowlers = 0;
  int dotsBall = 0;
  int dotsBallByBowler = 0;
  int facedBall = 0;
  bool keeper;
  int ballsByBowler = 0;
  String isPlaying = '';
  factory PlayerDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlayerDetailsModel(
        playerId: json["playerId"],
        teamId: json['teamId'] ?? 0,
        keeper: json['keeper'],
        ballsByBowler: json['ballsByBowler'],
        dotsBallByBowler: json['dotsBallByBowler'] ?? 0,
        playerName: json["playerName"],
        maxOverPerBowler: json['minOverPerBowler'] ?? 0,
        totalPlayedBalls: json["totalPlayedBalls"] ?? 0,
        madeRuns: json["madeRuns"] ?? 0,
        fours: json["fours"] ?? 0,
        batsmanOutThroughBowlerId: json['batsmanOutThroughBowlerId'] ?? 0,
        typeOfOut: json['typeOfOut'] ?? "Not Out",
        helpingPlayerId: json['helpingPlayerId'] ?? 0,
        sixes: json["sixes"] ?? 0,
        bowled: json["bowled"] ?? 0,
        overs: json["overs"] ?? 0,
        batsmanOut: json['batsmanOut'] ?? 0,
        shortName: json["shortName"] ?? "",
        isPlaying: json["isPlaying"] ?? '',
        maiden: json["maiden"] ?? 0,
        runsByBowler: json["runsByBowler"] ?? 0,
        wickets: json["wickets"] ?? 0,
        caugth: json["caugth"],
        runout: json["runout"],
        extrasByBowlers: json['extrasByBowlers'] ?? 0,
        singles: json["singles"] ?? 0,
        doubles: json["doubles"] ?? 0,
        tripples: json["tripples"] ?? 0,
        foursByBowler: json["foursByBowler"],
        sixesByBowlers: json["sixesByBowlers"],
        dotsBall: json["dotsBall"] ?? 0,
        facedBall: json["facedBall"] ?? 0,
        overList:
            List<Over>.from(json["overList"].map((x) => Over.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "playerName": playerName,
        "batsmanOut": batsmanOut,
        "shortName": shortName,
        "totalPlayedBalls": totalPlayedBalls,
        "madeRuns": madeRuns,
        "fours": fours,
        "batsmanOutThroughBowlerId": batsmanOutThroughBowlerId,
        "teamId": teamId,
        "sixes": sixes,
        "keeper": keeper,
        "typeOfOut": typeOfOut,
        "isPlaying": isPlaying,
        "ballsByBowler": ballsByBowler,
        "helpingPlayerId": helpingPlayerId,
        "overs": overs,
        "maiden": maiden,
        "runsByBowler": runsByBowler,
        "wickets": wickets,
        "caugth": caugth,
        "runout": runout,
        "extrasByBowlers": extrasByBowlers,
        "minOverPerBowler": maxOverPerBowler,
        "singles": singles,
        "doubles": doubles,
        "tripples": tripples,
        //  "overList": List<dynamic>.from(overList.map((x) => x.toJson())),
        "foursByBowler": foursByBowler,
        "sixesByBowlers": sixesByBowlers,
        "dotsBall": dotsBall,
        "facedBall": facedBall,
      };
}

class Over {
  Over({
    this.overCounter = 0,
    this.over,
  });

  int overCounter = 0;
  List<Bowl> over;

  factory Over.fromJson(Map<String, dynamic> json) => Over(
        overCounter: json["overCounter"] ?? 0,
        over: List<Bowl>.from(json["over"].map((x) => Bowl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "overCounter": overCounter,
        "over": List<dynamic>.from(over.map((x) => x.toJson())),
      };
}

class Bowl {
  Bowl(
      {this.run = 0,
      this.totalRun = 0,
      this.wicket,
      this.single = 0,
      this.double = 0,
      this.tripple = 0,
      this.wide = 0,
      this.typeOfOut = '',
      this.bowlerId = 0,
      this.noBall,
      this.helpingPlayerId = 0,
      this.playerIdWhoFaced = 0,
      this.runOut,
      this.playerIdWhoIsOut,
      this.four,
      this.perBallRecord = '',
      this.sixdads,
      this.totalWicket = 0,
      this.facedBall = 0,
      this.six,
      this.bowled,
      this.dotBall = 0,
      this.caugth,
      this.stump,
      this.extras = 0,
      this.lbw,
      this.isValid});
  bool isValid;
  int run = 0;
  String typeOfOut = '';
  int bowlerId = 0;
  String perBallRecord = '';
  int totalRun = 0;
  int wicket = 0;
  int totalWicket = 0;
  int wide = 0;
  int single = 0;
  int double = 0;
  int tripple = 0;
  int noBall;
  int helpingPlayerId = 0;
  int playerIdWhoFaced = 0;
  int runOut = 0;
  int playerIdWhoIsOut = 0;
  int four;
  String sixdads;
  int six;
  int bowled;
  int dotBall = 0;
  int caugth;
  int facedBall = 0;
  int stump;
  int extras = 0;
  int lbw;

  factory Bowl.fromJson(Map<String, dynamic> json) => Bowl(
        run: json["run"] ?? 0,
        perBallRecord: json['perBallRecord'] ?? 0,
        facedBall: json['facedBall'] ?? 0,
        totalRun: json['totalRun'] ?? 0,
        wicket: json["wicket"],
        wide: json["wide"] ?? 0,
        bowlerId: json['bowlerId'] ?? 0,
        noBall: json["noBall"],
        totalWicket: json['totalWicket'] ?? 0,
        helpingPlayerId: json["helpingPlayerId"] ?? 0,
        playerIdWhoFaced: json["playerIdWhoFaced"] ?? 0,
        runOut: json["runOut"],
        playerIdWhoIsOut: json["playerIdWhoOut"] ?? 0,
        four: json["four"],
        typeOfOut: json["typeOfOut"] ?? '',
        sixdads: json["sixdads"],
        six: json["six"],
        extras: json['extras'] ?? 0,
        bowled: json["bowled"],
        dotBall: json["dotBall"] ?? 0,
        double: json['double'] ?? 0,
        single: json['single'] ?? 0,
        tripple: json['tripple'] ?? 0,
        caugth: json["caugth"],
        stump: json["stump"],
        lbw: json["LBW"],
        isValid: json["isValid"],
      );

  Map<String, dynamic> toJson() => {
        "run": run = 0,
        "perBallRecord": perBallRecord = '',
        "wicket": wicket,
        "totalRun": totalRun = 0,
        "wide": wide = 0,
        "noBall": noBall,
        "extras": extras = 0,
        "facedBall": facedBall = 0,
        "totalWicket": totalWicket,
        "helpingPlayerId": helpingPlayerId = 0,
        "playerIdWhoFaced": playerIdWhoFaced = 0,
        "runOut": runOut,
        "typeOfOut": typeOfOut,
        "playerIdWhoOut": playerIdWhoIsOut,
        "four": four,
        "bowlerId": bowlerId = 0,
        "sixdads": sixdads,
        "six": six,
        "bowled": bowled,
        "dotBall": dotBall,
        "caugth": caugth,
        "stump": stump,
        "LBW": lbw,
        "isValid": isValid
      };
}

class ScoreModel {
  HashMap<int, PlayerDetailsModel> teamPlayerModelMap;
  int extraRuns;
  ScoreModel({this.teamPlayerModelMap = null, this.extraRuns = 0});
  ScoreModel.fromJson(Map<String, dynamic> json) {
    extraRuns = json['extrasRuns'] ?? 0;
    teamPlayerModelMap = json['teamPlayerModelMap'] ?? '';
  }
}
