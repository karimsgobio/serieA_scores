class Result {
  final int? homeTeam;
  final int? awayTeam;

  Result(this.homeTeam, this.awayTeam);

  factory Result.fromJson(dynamic json) {
    return Result(
        json['homeTeam'],
        json['awayTeam']
    ); // Result
  }

  @override
  String toString() {
    return "{$homeTeam} {$awayTeam}";
  }
}
