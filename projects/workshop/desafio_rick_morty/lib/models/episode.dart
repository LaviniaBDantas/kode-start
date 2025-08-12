class Episode {
  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  final int id;
  final String name;
  final String airDate;
  final String episode;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'air_date': airDate,
      'episode': episode,
    };
  }
}