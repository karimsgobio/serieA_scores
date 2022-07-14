class Team {
  final int id;
  final String name;
  final String crestUrl;
  int? position;
  int? points;

  Team(this.id, this.name, this.crestUrl, [this.position, this.points]);

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
        json['position'],
        json['points']
    ); // Team
  }

  @override
  String toString() {
    return "{$id} {$name} {$crestUrl} {$position} {$points}";
  }
}
