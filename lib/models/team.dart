class Team {
  final int id;
  final String name;
  int? position;
  int? points;

  Team(this.id, this.name, [this.position, this.points]);

  factory Team.fromJsonMatches(dynamic json) {
    return Team(
        json['id'] as int,
        json['name'] as String,
    ); // Team
  }
  factory Team.fromJsonTeams(dynamic json) {
    return Team(
        json['team']['id'] as int,
        json['team']['name'] as String,
        json['position'] as int,
        json['points'] as int
    ); // Team
  }

  @override
  String toString() {
    return "{$id} {$name} {$position} {$points}";
  }
}
