import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/config.dart';
import 'package:marvel_characters/core/network/api_helper.dart';
import 'package:marvel_characters/data/data_sources/characters_data_source.dart';
import 'package:marvel_characters/data/dtos/character_dto.dart';

@LazySingleton(as: CharactersDataSource)
class CharactersRemoteDataSource implements CharactersDataSource {
  final ApiHelper api;

  const CharactersRemoteDataSource({required this.api});

  @override
  Future<List<CharacterDTO>> getCharacters({int? limit, int? offset}) async {
    final response = await api
        .request('$apiPath/characters', method: Method.get, queryParameters: {
      if (offset != null) 'offset': offset,
      if (limit != null) 'limit': limit,
    });
    final result = response.data['data']['results'] as List<dynamic>;
    return result.map((e) => CharacterDTO.fromJson(e)).toList();
  }
}
