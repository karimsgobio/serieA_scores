import 'package:serie_a_scores/models/result.dart';

class Score {
  final String? winner;
  final String duration;
  final Result fullTime;

  Score(this.winner, this.duration, this.fullTime);
  factory Score.fromJson(dynamic json) {
    return Score(
        json['winner'],
        json['duration'],
        Result.fromJson(json['fullTime'])
    );
  }

  @override
  String toString() {
    return "{$winner} {$duration} " + fullTime.toString();
  }
}
