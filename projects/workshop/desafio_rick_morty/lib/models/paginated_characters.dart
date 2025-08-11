class PaginatedCharacter {
  PaginatedCharacter({
    required this.info,
    required this.results,
  });

  final Info info;
  final List<Character> results;

  factory PaginatedCharacter.fromJson(Map<String, dynamic> json) {
    return PaginatedCharacter(
      info: Info.fromJson(json['info']),
      results: List.from(json['results']).map((e) => Character.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }
}

class Character {
  Character({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}