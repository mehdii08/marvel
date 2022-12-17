import 'package:marvel_characters/data/dtos/character_dto.dart';

abstract class CharactersDataSource {
  Future<List<CharacterDTO>> getCharacters({int? limit, int? offset});
}
