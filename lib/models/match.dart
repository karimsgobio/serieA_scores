import 'package:serie_a_scores/models/score.dart';
import 'package:serie_a_scores/models/team.dart';

class Match {
  final String status;
  final int matchday;
  final Team homeTeam;
  final Team awayTeam;
  final Score score;

  Match(this.status, this.matchday, this.homeTeam, this.awayTeam, this.score);

  factory Match.fromJson(dynamic json) {
    return Match(
        json['status'] as String,
        json['matchday'] as int,
        Team.fromJson(json['homeTeam']),
        Team.fromJson(json['awayTeam']),
        Score.fromJson(json['score'])
    );
  }

  @override
  String toString() {
    return "{$status} {$matchday} " + homeTeam.toString() + " " + awayTeam.toString() + " " + score.toString();
  }
}
