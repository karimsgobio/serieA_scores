class Team {
  final int id;
  final String name;

  Team(this.id, this.name);

  factory Team.fromJson(dynamic json) {
    return Team(
        json['id'] as int,
        json['name'] as String
    ); // Team
  }

  @override
  String toString() {
    return "{$id} {$name}";
  }
}
