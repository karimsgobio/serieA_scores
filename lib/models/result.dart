class Result {
  final int homeTeam;
  final int awayTeam;

  Result(this.homeTeam, this.awayTeam);

  factory Result.fromJson(dynamic json) {
    return Result(
        json['homeTeam'] as int, json['awayTeam'] as int
    ); // Result
  }

  @override
  String toString() {
    return "{$homeTeam} {$awayTeam}";
  }
}
