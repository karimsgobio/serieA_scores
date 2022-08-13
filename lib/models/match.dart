import 'package:serie_a_scores/models/score.dart';
import 'package:serie_a_scores/models/team.dart';
import 'package:intl/intl.dart';

class Match {
  final String status;
  final int matchday;
  final String date;
  final Team homeTeam;
  final Team awayTeam;
  final Score score;

  Match(this.status, this.matchday, this.date, this.homeTeam, this.awayTeam, this.score);

  factory Match.fromJson(dynamic json) {
    return Match(
        json['status'] as String,
        json['matchday'] as int,
        json['utcDate'] as String,
        Team.fromJsonMatches(json['homeTeam']),
        Team.fromJsonMatches(json['awayTeam']),
        Score.fromJson(json['score'])
    );
  }

  @override
  String toString() {
    return '{$status} {$matchday} ' + homeTeam.toString() + awayTeam.toString() + score.toString();
  }

  String getDateItFormat(){
    final DateFormat formatter = DateFormat('dd-MM-yyyy | HH:mm');
    final dateF = DateTime.parse(date);
    return formatter.format(dateF.toLocal());
  }
}
