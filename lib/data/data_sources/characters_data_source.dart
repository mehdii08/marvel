import 'package:marvel_characters/data/dtos/character.dart';

abstract class CharactersDataSource {
  Future<List<CharacterDTO>> getCharacters({int? limit, int? offset});

  Future<CharacterDTO> getCharacter(int characterId);
}
