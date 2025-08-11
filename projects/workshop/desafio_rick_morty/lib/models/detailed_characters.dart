class DetailedCharacter {
  DetailedCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final LocationInfo origin;
  final LocationInfo location;
  final String image;
  final List<String> episode;

  factory DetailedCharacter.fromJson(Map<String, dynamic> json) {
    return DetailedCharacter(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      origin: LocationInfo.fromJson(json['origin']),
      location: LocationInfo.fromJson(json['location']),
      image: json['image'],
      episode: List.castFrom<dynamic, String>(json['episode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'origin': origin.toJson(),
      'location': location.toJson(),
      'image': image,
      'episode': episode,
    };
  }
}

class LocationInfo {
  LocationInfo({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}