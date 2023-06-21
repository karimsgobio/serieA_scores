class Team {
  final int id;
  final String name;
  final String crestUrl;
  int? position;
  int? points;
  int? won;
  int? draw;
  int? lost;

  Team(this.id, this.name, this.crestUrl, [this.position, this.points, this.won, this.draw, this.lost]);

  factory Team.fromJsonMatches(dynamic json) {
    return Team(
        json['id'] as int,
        json['shortName'] as String,
        json['crest'] as String,
    ); // Team
  }
  factory Team.fromJsonTeams(dynamic json) {
    return Team(
        json['team']['id'] as int,
        json['team']['shortName'] as String,
        json['team']['crest'] as String,
        json['position'] as int,
        json['points'] as int,
        json['won'] as int,
        json['draw'] as int,
        json['lost'] as int
    ); // Team
  }

  @override
  String toString() {
    return "{$id} {$name} {$crestUrl} {$position} {$points} {$won} {$draw} {$lost}";
  }
}
