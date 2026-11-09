import 'dart:convert';

class CreditsResponse {
  int id;
  List<Cast> cast;

  CreditsResponse({
    required this.id,
    required this.cast,
  });

  factory CreditsResponse.fromRawJson(String str) =>
      CreditsResponse.fromJson(json.decode(str));

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      );
}

class Cast {
  int id;
  String name;
  String? character;
  String? profilePath;

  Cast({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
  });

  String get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    return 'https://placehold.co/150x300/png';
  }

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        name: json["name"],
        character: json["character"],
        profilePath: json["profile_path"],
      );
}
