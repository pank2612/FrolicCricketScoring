// To parse this JSON data, do
//
//     final playerModel = playerModelFromJson(jsonString);

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
      this.playerName,
      this.totalPlayedBalls = 0,
      this.madeRuns = 0,
      this.fours = 0,
      this.sixes = 0,
      this.overs,
      this.maiden,
      this.runsByBowler = 0,
      this.wickets = 0,
      this.caugth,
      this.runout,
      this.singles = 0,
      this.doubles = 0,
      this.tripples = 0,
      this.foursByBowler,
      this.sixesByBowlers,
      this.dotsBall = 0,
      this.facedBall = 0,
      this.dotsBallByBowler = 0});

  int playerId;
  String playerName;
  int totalPlayedBalls = 0;
  int madeRuns = 0;
  int fours = 0;
  int sixes = 0;
  int overs;
  int maiden;
  int runsByBowler = 0;
  int wickets = 0;
  int caugth;
  int runout;
  int singles = 0;
  int doubles = 0;
  int tripples = 0;
  int foursByBowler;
  int sixesByBowlers;
  int dotsBall = 0;
  int dotsBallByBowler = 0;
  int facedBall = 0;

  factory PlayerDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlayerDetailsModel(
        playerId: json["playerId"],
        dotsBallByBowler: json['dotsBallByBowler'] ?? 0,
        playerName: json["playerName"],
        totalPlayedBalls: json["totalPlayedBalls"] ?? 0,
        madeRuns: json["madeRuns"] ?? 0,
        fours: json["fours"] ?? 0,
        sixes: json["sixes"] ?? 0,
        overs: json["overs"],
        maiden: json["maiden"],
        runsByBowler: json["runsByBowler"] ?? 0,
        wickets: json["wickets"] ?? 0,
        caugth: json["caugth"],
        runout: json["runout"],
        singles: json["singles"] ?? 0,
        doubles: json["doubles"] ?? 0,
        tripples: json["tripples"] ?? 0,
        foursByBowler: json["foursByBowler"],
        sixesByBowlers: json["sixesByBowlers"],
        dotsBall: json["dotsBall"] ?? 0,
        facedBall: json["facedBall"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "playerName": playerName,
        "totalPlayedBalls": totalPlayedBalls,
        "madeRuns": madeRuns,
        "fours": fours,
        "sixes": sixes,
        "overs": overs,
        "maiden": maiden,
        "runsByBowler": runsByBowler,
        "wickets": wickets,
        "caugth": caugth,
        "runout": runout,
        "singles": singles,
        "doubles": doubles,
        "tripples": tripples,
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
      {this.run = '',
      this.totalRun = 0,
      this.wicket,
      this.wide = 0,
      this.noBall,
      this.helpingPlayerId,
      this.playerIdWhoFaced,
      this.runOut,
      this.playerIdWhoOut,
      this.four,
      this.sixdads,
      this.six,
      this.bowled,
      this.dotBall = 0,
      this.caugth,
      this.stump,
      this.lbw,
      this.isValid});
  bool isValid;
  String run = '';
  int totalRun = 0;
  int wicket;
  int wide = 0;
  int noBall;
  int helpingPlayerId;
  int playerIdWhoFaced;
  int runOut;
  int playerIdWhoOut;
  int four;
  String sixdads;
  int six;
  int bowled;
  int dotBall = 0;
  int caugth;
  int stump;
  int lbw;

  factory Bowl.fromJson(Map<String, dynamic> json) => Bowl(
        run: json["run"] ?? '',
        totalRun: json['totalRun'] ?? 0,
        wicket: json["wicket"],
        wide: json["wide"] ?? 0,
        noBall: json["noBall"],
        helpingPlayerId: json["helpingPlayerId"],
        playerIdWhoFaced: json["playerIdWhoFaced"],
        runOut: json["runOut"],
        playerIdWhoOut: json["playerIdWhoOut"],
        four: json["four"],
        sixdads: json["sixdads"],
        six: json["six"],
        bowled: json["bowled"],
        dotBall: json["dotBall"] ?? 0,
        caugth: json["caugth"],
        stump: json["stump"],
        lbw: json["LBW"],
        isValid: json["isValid"],
      );

  Map<String, dynamic> toJson() => {
        "run": run = '',
        "wicket": wicket,
        "totalRun": totalRun = 0,
        "wide": wide = 0,
        "noBall": noBall,
        "helpingPlayerId": helpingPlayerId,
        "playerIdWhoFaced": playerIdWhoFaced,
        "runOut": runOut,
        "playerIdWhoOut": playerIdWhoOut,
        "four": four,
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
