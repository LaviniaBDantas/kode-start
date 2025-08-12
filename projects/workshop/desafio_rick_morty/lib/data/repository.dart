import 'package:dio/dio.dart';
import 'package:desafio_rick_morty/models/paginated_characters.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';
import 'package:desafio_rick_morty/models/episode.dart';
abstract class Repository {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: "https://rickandmortyapi.com/api",
    ),
  );

  static Future<PaginatedCharacter> getCharacters() async {
      var response = await _dio.get("/character");
      return PaginatedCharacter.fromJson(response.data);
  }

  static Future<DetailedCharacter> getCharacterDetails(int characterId) async {
    var response = await _dio.get("/character/$characterId");
    return DetailedCharacter.fromJson(response.data);
  }

  static Future<Episode> getEpisodeDetails(String url) async {
    var response = await _dio.get(url);
    return Episode.fromJson(response.data);
  }
}