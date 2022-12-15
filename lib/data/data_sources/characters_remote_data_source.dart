import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/config.dart';
import 'package:marvel_characters/core/network/api_helper.dart';
import 'package:marvel_characters/data/data_sources/characters_data_source.dart';
import 'package:marvel_characters/data/dtos/character.dart';

@LazySingleton(as: CharactersDataSource)
class CharactersRemoteDataSource implements CharactersDataSource {
  final ApiHelper _api;

  const CharactersRemoteDataSource(this._api);

  @override
  Future<List<CharacterDTO>> getCharacters({int? limit, int? offset}) async {
    final response = await _api
        .request('$apiPath/characters', method: Method.get, queryParameters: {
      if (offset != null) 'offset': offset,
      if (limit != null) 'limit': limit,
    });
    final result = response.data['data']['results'] as List<dynamic>;
    return result.map((e) => CharacterDTO.fromJson(e)).toList();
  }

  @override
  Future<CharacterDTO> getCharacter(int characterId) async {
    final response = await _api.request(
      '$apiPath/characters/$characterId',
      method: Method.get,
    );
    final result = response.data['data']['results'] as List<dynamic>;
    return CharacterDTO.fromJson(result.first);
  }
}
